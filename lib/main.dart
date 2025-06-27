import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/view/login_view.dart';
import 'package:chat_app/view/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'helpers/helpers.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context)
   {
    return MaterialApp(
      routes: {
        Helpers.LOGIN_VIEW_ROUTE: (context) => LoginView(),
        Helpers.REGISTER_VIEW_ROUTE: (context) => RegisterView(),
      },
      initialRoute: Helpers.LOGIN_VIEW_ROUTE,
    );
  }
}
