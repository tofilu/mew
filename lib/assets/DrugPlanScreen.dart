import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrugPlanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: this.key,
        body: Text(
          'drugs',
          style: TextStyle(fontSize: 40),
        ));
  }
}
