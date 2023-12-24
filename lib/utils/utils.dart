import 'package:flutter/material.dart';
import 'package:tiktaktoe/resources/game_methods.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

void showGameDialog(BuildContext context, String text) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              GameMethods().clearBoard(context);
              Navigator.pop(context);
            },
            child: const Text('Play Again!'),
          ),
        ],
      );
    },
  );
}

BoxBorder getBorder(int index) {
  const borderColor = Color(0xff776B5D);
  const borderWidth = 3.0;
  BorderSide borderSide = const BorderSide(color: borderColor, width: borderWidth);

  switch (index) {
    case 0:
      return Border(bottom: borderSide, right: borderSide);
    case 1:
      return Border(bottom: borderSide, right: borderSide);
    case 2:
      return Border(bottom: borderSide);
    case 3:
      return Border(bottom: borderSide, right: borderSide);
    case 4:
      return Border(right: borderSide, bottom: borderSide);
    case 5:
      return Border(bottom: borderSide);
    case 6:
      return Border(right: borderSide);
    case 7:
      return Border(right: borderSide);
    case 8:
      return const Border();
  }
  return Border.all();
}
