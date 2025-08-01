import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../themes/theme_provider.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({super.key, required this.txt, required this.onTap});

  final String txt;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      ),
      onPressed: onTap,
      child: Text(txt, style: TextStyle(color:  Provider.of<ThemeProvider>(
        context,
      ).appBarColor)),
    );
  }
}
