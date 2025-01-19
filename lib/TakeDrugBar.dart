import 'package:flutter/material.dart';
import 'DrugBar.dart';
import 'Helper/Drug.dart';

class TakeDrugBar extends DrugBar {
  Drug drug;

  TakeDrugBar({required this.drug}) {
    this.drug = drug;
  }

  @override
  buildDrugAlarm(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(children: [Text(drug.name)]),
      Column(children: [Text(drug.time)]),
      Column(children: [
        ElevatedButton(onPressed: () {}, child: Icon(Icons.medication_liquid))
      ])
    ]);
  }
}
