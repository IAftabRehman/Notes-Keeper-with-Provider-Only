import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreenProvider with ChangeNotifier {
  // For Splash Screen
  double _width = 0;
  double _height = 0;
  bool _animated = false;

  double get width => _width;

  double get height => _height;

  bool get animated => _animated;

  SplashScreenProvider() {
    _startTimer();
  }

  void _startTimer() {
    Timer(Duration(milliseconds: 1), () {
      _runAnimation();
    });
  }

  _runAnimation() {
    _width = 200;
    _height = 200;
    _animated = true;
    notifyListeners();
  }

  void moveToHome(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }
}
