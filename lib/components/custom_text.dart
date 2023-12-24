import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.shadows, required this.text, required this.fontSize});
  final List<Shadow> shadows;
  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        // color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        // shadows: shadows,
      ),
    );
  }
}
