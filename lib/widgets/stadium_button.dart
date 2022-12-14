import 'package:flutter/material.dart';

class StadiumButton extends StatelessWidget {
  const StadiumButton({Key? key, required this.text, required this.action})
      : super(key: key);

  final String text;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      child: Text(text),
      style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
    );
  }
}
