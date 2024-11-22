import 'package:blog_app/core/theme/palette.dart';
import 'package:flutter/material.dart';

class ThemeButton extends StatelessWidget {
  final String title;
  VoidCallback onTap;
  ThemeButton({super.key, this.title = 'title', required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppPallete.gradient1,
              AppPallete.gradient2,
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          borderRadius: BorderRadius.circular(7)),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppPallete.transparentColor,
            overlayColor: AppPallete.transparentColor,
            shadowColor: AppPallete.transparentColor,
            fixedSize: Size(395, 55)),
        child: Text(
          title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
