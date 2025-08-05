import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../themes/theme_provider.dart';

class Helpers {
  // static final kPrimaryColor = Color(0xff2B475E);
  // static final kPrimaryFriendColor = Color(0xff006D84);
  // static final kPrimaryBgColor = Color(0xffAACECC);
  // static final kPrimaryWordsColor = Color(0xffC7EDE6);
  // static final kSecondaryColor = Color(0xff342418);
  // static final kSecondaryFriendColor = Color(0xFF7D6B5A);
  // static final kSecondaryBgColor = Color(0xffF5E9DA);
  // static final kSecondaryWordsColor = Color(0xffd3bca5);

 static final kPrimaryColor = Color(0xff0074ce);
  static final kPrimaryFriendColor = Color(0xff3db2ff);
  static final kPrimaryBgColor = Colors.white;
  static final kPrimaryWordsColor = Color(0xffb8e1ff);
  static final kSecondaryColor = Color(0xff2c3131);
  static final kSecondaryFriendColor = Color(0xFF626262);
  static final kSecondaryBgColor = Color(0xffcacaca);
  // static final kSecondaryWordsColor = Color(0xffd3bca5);

   static const String LOGIN_VIEW_ROUTE = '/login';
   static const String REGISTER_VIEW_ROUTE = '/register';
   static const String CHAT_VIEW_ROUTE = '/chatHome';
  static const String KMessageCollection = 'messages';
  static const String KMessage = 'message';

  static final FirebaseAuth AUTH = FirebaseAuth.instance;

  static void showSnackBar(BuildContext context, String message, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor:  Provider.of<ThemeProvider>(
        context,
      ).appBarColor),
    );
  }
}