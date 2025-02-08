import 'package:flutter/material.dart';

class MewCardTheme {
  MewCardTheme._();

  static var lightCardTheme = CardTheme(
    color: Colors.blueGrey[200],
    margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 15.0),
  );

  static var darkCardTheme = CardTheme(
    color: Colors.blueGrey[700],
    margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 15.0),
  );
}