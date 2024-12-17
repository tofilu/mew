import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Helper/Drug.dart';

class DrugAlarmBar extends StatelessWidget {
  Drug drug;
  Drug exampleDrug = Drug(
      id: 2,
      name: "exampleDrug",
      time: "10:00",
      frequency: 2,
      amountLeft: 100,
      prescriptionTime: 10);

  DrugAlarmBar({super.key, required this.drug}) {
    this.drug = drug;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5.0,
        color: Colors.grey,
        shape: BeveledRectangleBorder(),
        child: ListBody(children: [
          Padding(
              padding:
                  const EdgeInsets.only(top: 12.0, bottom: 3.0, left: 16.0),
              child: buildDrugAlarmTitle()),
          Padding(
              padding: const EdgeInsets.only(bottom: 5.0, left: 16.0),
              child: buildDrugAlarmInformation())
        ]));
  }

  Row buildDrugAlarmTitle() {
    return Row(children: [
      Text(exampleDrug.name,
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold))
    ]);
  }

  Row buildDrugAlarmInformation() {
    return Row(children: [
      Column(children: [
        Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Text("time " + exampleDrug.time))
      ]),
      Column(children: [
        Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Text("every " + exampleDrug.frequency.toString() + " days"))
      ])
    ]);
  }
}
