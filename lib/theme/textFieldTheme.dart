import 'package:flutter/material.dart';

class TextFieldTheme {
  TextFieldTheme._();

  static InputDecorationTheme textFieldLight = InputDecorationTheme(
      labelStyle: const TextStyle().copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      hintStyle: const TextStyle().copyWith(color: Colors.white54),
      errorStyle: const TextStyle().copyWith(),
      floatingLabelStyle: const TextStyle().copyWith(color: Colors.white),

      filled: true,
      fillColor: Colors.blue[200],

      border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(24),
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white12),
          borderRadius: BorderRadius.circular(24),
      )
  );

  static InputDecorationTheme textFieldDark = InputDecorationTheme(
      labelStyle: const TextStyle().copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      hintStyle: const TextStyle().copyWith(color: Colors.white54),
      errorStyle: const TextStyle().copyWith(),
      floatingLabelStyle: const TextStyle().copyWith(color: Colors.white),

      filled: true,
      fillColor: Colors.blueGrey[300],

      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(24),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white12),
        borderRadius: BorderRadius.circular(24),
      )
  );
}