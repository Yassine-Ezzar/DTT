import 'package:flutter/material.dart';

class Styles {
  // Colors
  static Color scaffoldBackgroundColor = Color(0xFFF7F7F7);
  static Color defaultRedColor = Color(0xFFE65541);
  static Color defaultWhiteColor = Color(0xFFFFFFFF);
  static Color defaultLightGrayColor = Color(0xFFF7F7F7);
  static Color defaultDarkGrayColor = Color(0xFFEBEBEB);
  static Color defaultStrongColor = Color(0xFFCC000000);
  static Color defaultMediumColor = Color(0xFF66000000);
  static Color defaultLightColor = Color(0xFF33000000);

  // Typography
  static TextStyle title01 = TextStyle(
    fontFamily: 'Gotham SSm',
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: defaultStrongColor,
  );

  static TextStyle title02 = TextStyle(
    fontFamily: 'Gotham SSm',
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: defaultStrongColor,
  );

  static TextStyle title03 = TextStyle(
    fontFamily: 'Gotham SSm',
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: defaultStrongColor,
  );

  static TextStyle bodyBook = TextStyle(
    fontFamily: 'Gotham SSm',
    fontWeight: FontWeight.normal,
    fontSize: 12,
    color: defaultMediumColor,
  );

  static TextStyle inputLight = TextStyle(
    fontFamily: 'Gotham SSm',
    fontWeight: FontWeight.w300,
    fontSize: 12,
    color: defaultMediumColor,
  );

  static TextStyle hintBook = TextStyle(
    fontFamily: 'Gotham SSm',
    fontWeight: FontWeight.normal,
    fontSize: 12,
    color: defaultMediumColor.withOpacity(0.6),
  );

  static TextStyle subtitleBook = TextStyle(
    fontFamily: 'Gotham SSm',
    fontWeight: FontWeight.normal,
    fontSize: 10,
    color: defaultMediumColor,
  );

  static TextStyle detailBook = TextStyle(
    fontFamily: 'Gotham SSm',
    fontWeight: FontWeight.normal,
    fontSize: 12,
    color: defaultMediumColor,
  );

  // Padding and Borders
  static double defaultPadding = 18.0;
  static BorderRadius defaultBorderRadius = BorderRadius.circular(20);

  // Scrollbar Theme
  static ScrollbarThemeData scrollbarTheme = ScrollbarThemeData().copyWith(
    thumbColor: WidgetStateProperty.all(defaultRedColor),
    trackColor: WidgetStateProperty.all(defaultDarkGrayColor),
    trackVisibility: WidgetStateProperty.all(true),
    thumbVisibility: WidgetStateProperty.all(false),
    interactive: true,
    thickness: WidgetStateProperty.all(10.0),
    radius: Radius.circular(20),
  );
}
