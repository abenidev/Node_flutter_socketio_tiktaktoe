import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.ontap, required this.label});
  final Function() ontap;
  final String label;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.blue, blurRadius: 2, spreadRadius: 0),
        ],
      ),
      child: MaterialButton(
        onPressed: ontap,
        minWidth: size.width,
        height: 50,
        child: Text(label, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
