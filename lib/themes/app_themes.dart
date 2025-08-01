import 'package:chat_app/helpers/helpers.dart';
import 'package:flutter/material.dart';

class AppTheme {

  static final lightColors = {
    'primaryColor': Helpers.kPrimaryColor,

  };
  static final darkColors = {
    'primaryColor': Helpers.kSecondaryColor,
  };

  static final lightTheme = ThemeData(
    primaryColor: lightColors['primaryColor'],
  );

  static final darkTheme = {
    'primaryColor': darkColors['primaryColor'],
  };
}