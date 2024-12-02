import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DailyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: this.key,
        body: Text(
          'dailyscreen',
          style: TextStyle(fontSize: 40),
        ));
  }
}
