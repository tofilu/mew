import 'package:flutter/material.dart';
import 'package:mew/theme/textFieldTheme.dart';
import 'package:mew/theme/elevatedButtonTheme.dart';
import 'package:mew/theme/cardTheme.dart';

class MewTheme {
  MewTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      surface: Colors.grey.shade300,
    ),
    appBarTheme: AppBarTheme(
      color: Colors.blue[200],
      titleTextStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 50, color: Colors.white),
      toolbarHeight: 85,
      titleSpacing: 40,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
      )
    ),
    inputDecorationTheme: TextFieldTheme.textFieldLight,
    elevatedButtonTheme: MewElevatedButtonTheme.lightElevatedButtonTheme,
    cardTheme: MewCardTheme.lightCardTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      surface: Colors.grey.shade900,
    ),
    appBarTheme: AppBarTheme(
        color: Colors.blueGrey[300],
        titleTextStyle: TextStyle(fontWeight: FontWeight.w900, fontSize: 50, color: Colors.white),
        toolbarHeight: 85,
        titleSpacing: 40,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0))
        )
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle().copyWith(fontWeight: FontWeight.w900),
      bodySmall: TextStyle().copyWith(fontWeight: FontWeight.w900),
    ),
    inputDecorationTheme: TextFieldTheme.textFieldDark,
    elevatedButtonTheme: MewElevatedButtonTheme.darkElevatedButtonTheme,
    cardTheme: MewCardTheme.darkCardTheme,
  );
}

