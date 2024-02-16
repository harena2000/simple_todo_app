import 'package:flutter/material.dart';
import 'package:simple_todo_app/app/constant/app_colors.dart';

class SimpleButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const SimpleButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.backgroundColor = AppColors.green,
      this.foregroundColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: TextButton(
        onPressed: () => onPressed(),
        style: TextButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: TextStyle(color: foregroundColor, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
