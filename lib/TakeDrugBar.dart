import 'package:flutter/material.dart';
import 'Helper/Drug.dart';

class TakeDrugBar extends StatelessWidget {
  Drug drug;

  TakeDrugBar({super.key, required this.drug}) {
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
              padding: const EdgeInsets.only(bottom: 15.0, top: 15.0),
              child: buildDrugAlarm())
        ]));
  }

  Row buildDrugAlarm() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Column(children: [Text(drug.name)]),
      Column(children: [Text(drug.time)]),
      Column(children: [
        ElevatedButton(onPressed: () {}, child: Icon(Icons.medication_liquid))
      ])
    ]);
  }
}
