import 'package:chat_app/helpers/helpers.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widget/custom_bubble.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  CollectionReference messagesCollection = FirebaseFirestore.instance
      .collection(Helpers.KMessageCollection);

  TextEditingController messageController = TextEditingController();
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;

    return StreamBuilder<QuerySnapshot>(
      stream: messagesCollection
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> messagesList = [];

          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/scholar.png', height: 50),
                  Text('Chat', style: TextStyle(color: Colors.white)),
                ],
              ),
              backgroundColor: Helpers.kPrimaryColor,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email
                          ? CustomBubble(messageModel: messagesList[index])
                          : CustomFriendBubble(
                              messageModel: messagesList[index],
                            );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: messageController,
                    onSubmitted: (data) {
                      messagesCollection.add({
                        'message': data,
                        'createdAt': DateTime.now(),
                        'id': email,
                        // 'idA': Helpers.AUTH.currentUser!.uid,
                      });
                      messageController.clear();
                      controller.animateTo(
                        0,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send, color: Helpers.kPrimaryColor),
                        onPressed: () {
                          // final text = messageController.text.trim();
                          // if (text.isNotEmpty) {
                          //   messagesCollection.add({'message': text});
                          //   messageController.clear();
                          // }
                        },
                      ),
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Helpers.kPrimaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Helpers.kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Center(child: Text('Chat')),
              backgroundColor: Helpers.kPrimaryColor,
            ),
            body: Center(child: Text('loading...')),
          );
        }
      },
    );
  }
}
