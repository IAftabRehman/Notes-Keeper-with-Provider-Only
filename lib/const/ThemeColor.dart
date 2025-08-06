import 'package:flutter/material.dart';

class ThemeColor {
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

  static const List<Color> backgroundLight = [
    Color(0xff636363),
    Color(0xff6C5B7B),
    Color(0xffa2ab58),
  ];

  static const List<Color> backgroundDark = [
    Color(0xff232526),
    Colors.deepPurple,
    Colors.purple,
  ];

  static const List<Color> appBarColorLight = [
    Color(0xff4169E1),
    Color(0xff6495ED),
  ];
  static const List<Color> appBarColorDark = [
    Colors.white24,
    Color(0xff414345),
  ];

  static const Color taskUnSelectedLight = Color(0xff0071c5);
  static const Color taskSelectedLight = Color(0xff5D8AA8);

  static const Color taskUnSelectedDark = Colors.black12;
  static const Color taskSelectedDark = Colors.black26;

  static const Color containerShadowLight = Colors.black54;
  static const Color containerShadowDark = Colors.white24;
}
