import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({super.key, required this.txt, required this.onTap});

  final String txt;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return TextButton(
  style: TextButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
    )
    ,onPressed: onTap, child: Text(txt));
  }
}
