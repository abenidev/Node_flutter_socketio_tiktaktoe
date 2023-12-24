import 'package:flutter/material.dart';
import 'package:tiktaktoe/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.controller, required this.hintText, this.isReadOnly = false});
  final TextEditingController controller;
  final String hintText;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          // boxShadow: [BoxShadow(color: Colors.blue, blurRadius: 5, spreadRadius: 0)],
          ),
      child: TextField(
        controller: controller,
        readOnly: isReadOnly,
        decoration: InputDecoration(
          fillColor: bgColor,
          filled: true,
          hintText: hintText,
          // border: InputBorder.none,
        ),
      ),
    );
  }
}
