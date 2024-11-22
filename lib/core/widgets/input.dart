import 'package:blog_app/core/theme/palette.dart';
import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isObscureText;
  const Input(
      {super.key,
      required this.controller,
      this.hint = 'email',
      this.isObscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: const EdgeInsets.all(27),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '$hint is missing ';
        }
        return null;
      },
      obscureText: isObscureText,
    );
  }
}
