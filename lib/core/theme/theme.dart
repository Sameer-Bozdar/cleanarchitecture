import 'package:blog_app/core/theme/palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(width: 3, color: color));
  static final darkThemeMode = ThemeData.dark().copyWith(
      chipTheme: ChipThemeData(
          color: MaterialStateProperty.all(AppPallete.backgroundColor)),
      scaffoldBackgroundColor: AppPallete.backgroundColor,
      appBarTheme: AppBarTheme(backgroundColor: AppPallete.backgroundColor),
      inputDecorationTheme: InputDecorationTheme(
          focusedBorder: _border(AppPallete.gradient2),
          errorBorder: _border(),
          enabledBorder: _border()));
}
