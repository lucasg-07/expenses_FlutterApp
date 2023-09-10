import 'package:flutter/material.dart';

class ThemeClass {
  Color primaryColor = const Color(0xFF007BFF);
  Color secondaryColor = const Color(0xFFFFD600);
  Color tertiaryColor = const Color(0xFFFF0000);
  Color darkPrimaryColor = const Color(0x00008000);
  final ThemeData tema = ThemeData();

  static ThemeData lightTheme = ThemeData(
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: _themeClass.primaryColor,
      secondary: _themeClass.secondaryColor,
      tertiary: _themeClass.tertiaryColor,
    ),
    textTheme: _themeClass.tema.textTheme.copyWith(
      titleLarge: const TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      labelLarge: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
      primaryColor: ThemeData.dark().scaffoldBackgroundColor,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: _themeClass.darkPrimaryColor,
      ));
}

ThemeClass _themeClass = ThemeClass();
