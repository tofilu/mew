import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Helper/Drug.dart';

abstract class DrugBar extends StatelessWidget {
  late Drug drug;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5.0,
        color: Colors.grey,
        shape: BeveledRectangleBorder(),
        child: ListBody(children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
              child: buildBar(context))
        ]));
  }

  Widget buildBar(BuildContext context);
}
