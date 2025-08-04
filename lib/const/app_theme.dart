import 'package:flutter/material.dart';

class AppTheme {
  static const lightMode = ThemeMode.light;
  static const darkMode = ThemeMode.dark;

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.deepPurple,
  );

  static const List<Color> backGround_light = [
    Color(0xff355C7D),
    Color(0xff6C5B7B),
    Color(0xff585C5C),
  ];

  static const List<Color> backGround_dark = [
    Color(0xff232526),
    Color(0xff414345),
    Color(0xff000000),
  ];

  static const Color taskUnSelected_Light = Color(0xff0071c5);
  static const Color taskSelected_Light = Color(0xff5D8AA8);

  static const Color taskUnSelected_Dark = Colors.white;
  static const Color taskSelected_Dark = Colors.red;
}
