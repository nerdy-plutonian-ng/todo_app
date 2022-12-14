import 'package:flutter/material.dart';

class TextStadiumButton extends StatelessWidget {
  const TextStadiumButton({Key? key, required this.text, required this.action})
      : super(key: key);

  final String text;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: action,
      style: TextButton.styleFrom(shape: const StadiumBorder()),
      child: Text(text),
    );
  }
}
