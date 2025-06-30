import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Helpers {
  static final kPrimaryColor = Color(0xff2B475E);

   static const String LOGIN_VIEW_ROUTE = '/login';
   static const String REGISTER_VIEW_ROUTE = '/register';
   static const String CHAT_VIEW_ROUTE = '/chatHome';

  static final FirebaseAuth AUTH = FirebaseAuth.instance;

  static void showSnackBar(BuildContext context, String message, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }
}