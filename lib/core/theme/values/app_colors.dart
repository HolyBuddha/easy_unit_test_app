import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const List<Color> buttonColorsList = [
    red,
    green,
    purple,
    yellow,
    blue
  ];

  static const Color gray = Color.fromRGBO(241, 241, 241, 1);
  static const Color red = Color.fromRGBO(255, 95, 87, 1);
  static const Color green = Color.fromRGBO(214, 255, 121, 1);
  static const Color purple = Color.fromRGBO(218, 189, 255, 1);
  static const Color yellow = Color.fromRGBO(255, 249, 93, 1);
  static const Color blue = Color.fromRGBO(160, 248, 246, 1);


  static  Color getRandomColor() {
    final random = Random();
    return buttonColorsList[random.nextInt(buttonColorsList.length)];
  }
}
