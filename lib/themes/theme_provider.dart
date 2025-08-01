import 'package:chat_app/helpers/helpers.dart';
import 'package:chat_app/themes/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeProvider() {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  void changeTheme(ThemeMode mode) {
    _themeMode = mode;
    _saveTheme();
    notifyListeners();
  }



  Future<void> _loadTheme() async {
    // refactor this to use SharedPreferences object
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? theme = prefs.getString('theme');
    if (theme == 'dark') {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', _themeMode == ThemeMode.dark ? 'dark' : 'light');
  }

  ThemeData get themeData {
    return _themeMode == ThemeMode.light ? ThemeData.light() : ThemeData.dark();
  }

  Color get textColor {
    return _themeMode == ThemeMode.light ? Colors.white : Colors.white;
  }

  Color get wordsColor {
    return _themeMode == ThemeMode.light ? Helpers.kPrimaryWordsColor : Helpers.kSecondaryWordsColor;
  }

  Color get appBarColor {
    return _themeMode == ThemeMode.light ? Helpers.kPrimaryColor : Helpers.kSecondaryColor;
  }

  Color get backgroundColor {
    return _themeMode == ThemeMode.light ?  Helpers.kPrimaryBgColor :  Helpers.kSecondaryBgColor;
  }

  Color get bubbleColor {
    return _themeMode == ThemeMode.light ? Helpers.kPrimaryColor : Helpers.kSecondaryColor;
  }

  Color get customFriendBubble {
    return _themeMode == ThemeMode.light ? Helpers.kPrimaryFriendColor : Helpers.kSecondaryFriendColor;
  }
}
