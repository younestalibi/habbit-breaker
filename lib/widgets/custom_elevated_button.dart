import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final double borderRadius;
  final double padding;
  final TextStyle textStyle;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = const Color.fromARGB(255, 255, 255, 255),
    this.borderRadius = 5.0,
    this.padding = 5,
    this.textStyle = const TextStyle(
        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Expanded(
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            padding: EdgeInsets.all(padding),
            backgroundColor: backgroundColor,
          ),
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
