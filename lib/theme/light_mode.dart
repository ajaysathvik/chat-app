import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.light(
  background: Colors.grey.shade50,
  primary: Colors.grey.shade500,
  secondary: Colors.grey.shade200,
  tertiary: Colors.white,
  inversePrimary: Colors.grey.shade900,
));

ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
  background: Colors.black,
  primary: Colors.grey.shade300,
  secondary: Colors.grey.shade800,
  tertiary: Colors.grey.shade700,
  inversePrimary: Colors.grey.shade50,
));
