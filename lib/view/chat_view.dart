import 'package:chat_app/cubit/auth_cubits/logout_cubit/logout_cubit.dart';
import 'package:chat_app/cubit/auth_cubits/logout_cubit/logout_states.dart';
import 'package:chat_app/helpers/helpers.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';
import '../widget/custom_bubble.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

// bool isDarkMode = false/'

class _ChatViewState extends State<ChatView> {
  CollectionReference messagesCollection = FirebaseFirestore.instance
      .collection(Helpers.KMessageCollection);

  TextEditingController messageController = TextEditingController();
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;

    return BlocProvider(
      create: (context) => LogoutCubit(),
      child: BlocListener<LogoutCubit, LogoutState>(
        listener: (context, state) {
          if (state is SuccessLogoutState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Helpers.LOGIN_VIEW_ROUTE,
              (route) => false,
            );
          } else if (state is LoadingLogoutState) {
            // Show loading indicator if needed
          } else if (state is FailureLogoutState) {
            Helpers.showSnackBar(
              context,
              'Something went wrong, please try again.',
            );
          }
        },

        child: BlocBuilder<LogoutCubit, LogoutState>(
          builder: (context, state) {
            return ModalProgressHUD(
              inAsyncCall: state is LoadingLogoutState,
              child: StreamBuilder<QuerySnapshot>(
                stream: messagesCollection
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<MessageModel> messagesList = [];

                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      messagesList.add(
                        MessageModel.fromJson(snapshot.data!.docs[i]),
                      );
                    }
                    return Scaffold(
                      backgroundColor: Provider.of<ThemeProvider>(
                        context,
                      ).backgroundColor,
                      appBar: AppBar(
                        leading: IconButton(
                          icon: Icon(Icons.logout),
                          onPressed: () {
                            BlocProvider.of<LogoutCubit>(context).logout();
                          },
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/scholar.png',
                              height: 50,
                            ),
                            Text('Chat', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        actions: [
                          IconButton(
                            icon: Icon(
                              Provider.of<ThemeProvider>(context).themeMode ==
                                      ThemeMode.dark
                                  ? Icons.light_mode
                                  : Icons.dark_mode,
                            ),
                            color: Colors.white,
                            onPressed: () {
                              final currentTheme = Provider.of<ThemeProvider>(
                                context,
                                listen: false,
                              );
                              currentTheme.changeTheme(
                                currentTheme.themeMode == ThemeMode.dark
                                    ? ThemeMode.light
                                    : ThemeMode.dark,
                              );
                            },
                          ),
                        ],
                        backgroundColor: Provider.of<ThemeProvider>(
                          context,
                        ).appBarColor,
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
                                    ? CustomBubble(
                                        messageModel: messagesList[index],
                                        textColor: Provider.of<ThemeProvider>(
                                          context,
                                        ).textColor,
                                        color: Provider.of<ThemeProvider>(
                                          context,
                                        ).bubbleColor,
                                      )
                                    : CustomFriendBubble(
                                        textColor: Provider.of<ThemeProvider>(
                                          context,
                                        ).textColor,
                                        color: Provider.of<ThemeProvider>(
                                          context,
                                        ).customFriendBubble,
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
                                  icon: Icon(
                                    Icons.send,
                                    color: Provider.of<ThemeProvider>(
                                      context,
                                    ).appBarColor,
                                  ),
                                  onPressed: () {
                                    // final text = messageController.text.trim();
                                    // if (text.isNotEmpty) {
                                    //   messagesCollection.add({'message': text});
                                    //   messageController.clear();
                                    // }
                                  },
                                ),
                                hintText: 'Type a message',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Provider.of<ThemeProvider>(
                                      context,
                                    ).appBarColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Provider.of<ThemeProvider>(
                                      context,
                                    ).appBarColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                    color: Provider.of<ThemeProvider>(
                                      context,
                                    ).appBarColor,
                                    width: 2,
                                  ),
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
              ),
            );
          },
        ),
      ),
    );
  }
}
