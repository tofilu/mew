import 'package:flutter/material.dart';

class MewElevatedButtonTheme {
  MewElevatedButtonTheme._();

  static var lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
      textStyle: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 20
      )
    ),
  );

  static var darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        textStyle: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20
        )
    ),
  );
}