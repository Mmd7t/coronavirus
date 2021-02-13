import 'package:flutter/material.dart';

/*------------------------------------  Light Theme  ---------------------------------------*/
ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: commonTheme.primaryColor,
  accentColor: commonTheme.accentColor,
  scaffoldBackgroundColor: Colors.white,
  dividerColor: commonTheme.dividerColor,
  visualDensity: commonTheme.visualDensity,
  inputDecorationTheme: commonTheme.inputDecorationTheme,
);

/*------------------------------------  Dark Theme  ---------------------------------------*/
ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: commonTheme.primaryColor,
  accentColor: commonTheme.accentColor,
  visualDensity: commonTheme.visualDensity,
  dividerColor: commonTheme.dividerColor,
  scaffoldBackgroundColor: Color(0xFF0E0127),
  inputDecorationTheme: commonTheme.inputDecorationTheme,
);

/*------------------------------------  Common Theme  ---------------------------------------*/
var commonTheme = ThemeData(
  primaryColor: Colors.indigo[300],
  dividerColor: Colors.redAccent,
  accentColor: Colors.redAccent,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: Colors.redAccent,
        width: 1.5,
      ),
    ),
  ),
);
