import 'package:flutter/material.dart';

class CustomColor {
  static const Color primaryDark = Color(0xFF8675A9);
  static const Color primary = Color(0xFFC3AED6);
  static const Color primaryDarker = Color(0xFF473E59);
  static const Color secondary = Color(0xFFEFBBCF);
  static const Color tertiary = Color(0xFFFFD5CD);
  static const Color white = Color(0xFFFEFEFE);
  static const Color lightGray = Color(0xFFE4E4E4);
  static const Color gray = Color(0xFFAEAEAE);
  static const Color darkGray = Color(0xFF4A4A4A);
  static const Color black = Color(0xFF111111);
}

mixin CustomText {
  static TextStyle heading1({
    Color color = CustomColor.white,
    TextDecoration? decor,
  }) => TextStyle(
    fontFamily: 'Baloo',
    fontSize: 48,
    color: color,
    decoration: decor,
  );

  static TextStyle heading2({
    Color color = CustomColor.white,
    TextDecoration? decor,
  }) => TextStyle(
    fontFamily: 'Baloo',
    fontSize: 40,
    color: color,
    decoration: decor,
  );

  static TextStyle subHeading1({
    Color color = CustomColor.white,
    TextDecoration? decor,
  }) => TextStyle(
    fontFamily: 'Baloo',
    fontSize: 32,
    color: color,
    decoration: decor,
  );

  static TextStyle subHeading2({
    Color color = CustomColor.white,
    TextDecoration? decor,
  }) => TextStyle(
    fontFamily: 'Baloo',
    fontSize: 24,
    color: color,
    decoration: decor,
  );

  static TextStyle subHeading3({
    Color color = CustomColor.white,
    TextDecoration? decor,
  }) => TextStyle(
    fontFamily: 'Baloo',
    fontSize: 16,
    color: color,
    decoration: decor,
  );

  static TextStyle subHeading4({
    Color color = CustomColor.white,
    TextDecoration? decor,
  }) => TextStyle(
    fontFamily: 'Baloo',
    fontSize: 12,
    color: color,
    decoration: decor,
  );

  static TextStyle text1({
    Color color = CustomColor.white,
    TextDecoration? decor,
    bool? bold = false,
  }) => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 12,
    color: color,
    decoration: decor,
    fontWeight: bold == true ? FontWeight.bold : FontWeight.normal,
  );

  static TextStyle text2({
    Color color = CustomColor.white,
    TextDecoration? decor,
    bool? bold = false,
  }) => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 11,
    color: color,
    decoration: decor,
    fontWeight: bold == true ? FontWeight.bold : FontWeight.normal,
  );

  static TextStyle text3({
    Color color = CustomColor.white,
    TextDecoration? decor,
    bool? bold = false,
  }) => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 10,
    color: color,
    decoration: decor,
    fontWeight: bold == true ? FontWeight.bold : FontWeight.normal,
  );

  static TextStyle textMd1({
    Color color = CustomColor.white,
    TextDecoration? decor,
    bool? bold = false,
  }) => TextStyle(
    fontFamily: 'Poppins',
    fontSize: 14,
    fontWeight: bold == true ? FontWeight.bold : FontWeight.normal,
    color: color,
    decoration: decor,
  );
}
