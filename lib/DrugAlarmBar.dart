import 'package:flutter/material.dart';
import 'package:mew/ChangeDrugScreen.dart';
import 'package:path/path.dart';

import 'DrugBar.dart';
import 'Helper/Drug.dart';

class DrugAlarmBar extends DrugBar {
  final Drug drug;

  DrugAlarmBar({required this.drug});

  Row _buildDrugAlarmTitle() {
    return Row(children: [
      Text(drug.name,
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold))
    ]);
  }

  Row _buildDrugAlarmInformation() {
    return Row(children: [
      Column(children: [
        Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Text("time " + drug.time))
      ]),
      Column(children: [
        if (drug.frequency == 1)
          Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Text("every day"))
        else
        Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Text("every " + drug.frequency.toString() + " days"))
      ])
    ]);
  }

  @override
  Widget buildBar(BuildContext context) {
    return ListBody(children: [
      Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 3.0, left: 16.0),
          child: _buildDrugAlarmTitle()),
      Padding(
          padding: const EdgeInsets.only(bottom: 5.0, left: 16.0),
          child: _buildDrugAlarmInformation()),
      Padding(
          padding: const EdgeInsets.only(bottom: 5.0, left: 16.0),
          child: ElevatedButton(
              onPressed: () {
                _routeToChangeDrugScreen(context);
              },
              child: Icon(Icons.edit)))
    ]);
  }

  _routeToChangeDrugScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeDrugScreen(
                medicationName: drug.name,
                dosage: drug.dosage,
                time: drug.time,
                frequency: drug.frequency,
                id: drug.id)));
  }
}
