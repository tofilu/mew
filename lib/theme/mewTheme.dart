import 'package:flutter/material.dart';
import 'package:mew/theme/textFieldTheme.dart';
import 'package:mew/theme/elevatedButtonTheme.dart';

class MewTheme {
  MewTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      surface: Colors.grey.shade300,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.blue[200],
      titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 36, color: Colors.black),
    ),
    inputDecorationTheme: TextFieldTheme.textFieldLight,
    elevatedButtonTheme: MewElevatedButtonTheme.lightElevatedButtonTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: Colors.grey.shade900,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.blue[800],
      titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 36, color: Colors.white),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle().copyWith(fontWeight: FontWeight.w900),
      bodySmall: TextStyle().copyWith(fontWeight: FontWeight.w900),
    ),
    inputDecorationTheme: TextFieldTheme.textFieldDark,
    elevatedButtonTheme: MewElevatedButtonTheme.darkElevatedButtonTheme,
  );
}

