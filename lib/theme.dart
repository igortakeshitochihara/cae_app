import 'dart:ui';
import 'package:flutter/material.dart';

final ThemeData appTheme = new ThemeData(
    fontFamily: 'Clear Sans',
    primaryColor: AppColors.colorPrimary);

class AppColors {
  static var colorPrimary = const Color(0xFF4CAF50);
  static var colorPrimaryLight = const Color(0xFFd5ebcd);
  static var colorWhite = Colors.white;
  static var colorGreen = Colors.green;
  static var colorYellow = Colors.yellow;
  static var colorRed = Colors.red;
  static var colorBlue = Colors.blue;
  static var colorBlack = Colors.black;
  static var colorGray = const Color(0xFF737373);
  static var colorGraySoft = const Color(0xFFefefef);
  static var colorGrayDark = const Color(0xFF4c4c4c);
  static var colorDisabled = const Color(0xFFc6c6c6);
  static var colorGrayLight = const Color(0xFFF5F5F5);

  static var colorSuccess = const Color(0xFF25ae88);
  static var colorWarning = const Color(0xFFefce4a);
  static var colorError = const Color(0xFFd75a4a);
}
