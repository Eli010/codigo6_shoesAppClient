import 'dart:math';

import 'package:flutter/material.dart';

class ResponsiveUI {
  static double pWidth(BuildContext context, double width) {
    return MediaQuery.of(context).size.width * width;
  }

  static double pHeight(BuildContext context, double height) {
    return MediaQuery.of(context).size.height * height;
  }

  static double pDiagonal(BuildContext context, double diagonal) {
    double height = MediaQuery.of(context).size.height;
    double widht = MediaQuery.of(context).size.width;
    return sqrt(pow(height, 2) + pow(widht, 2)) * diagonal;
  }
}
