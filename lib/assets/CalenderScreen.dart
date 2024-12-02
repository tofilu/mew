import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalenderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: this.key,
        body: Text(
          'calenderscreen',
          style: TextStyle(fontSize: 40),
        ));
  }
}
