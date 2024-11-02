import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? color;
  final double borderRadius;
  final double padding;
  final double? width;
  final TextStyle? textStyle;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.color,
    this.borderRadius = 5.0,
    this.padding = 5,
    this.width,
    this.fontSize = 15,
    this.fontWeight = FontWeight.bold,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
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
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color,
          ),
        ),
      ),
    );
  }
}
