import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Color fillColor;
  final double borderRadius;
  final String? Function(String?)? validator;

  const CustomInputField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.fillColor = const Color(0xFFF0F0F0),
    this.borderRadius = 50.0,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: fillColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 16.0,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        ),
      ),
      validator: validator,
    );
  }
}
