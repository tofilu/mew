import 'package:flutter/material.dart';
import 'package:mew/Helper/DrugOfDatabase.dart';
import 'DrugBar.dart';
import '../Helper/DrugService.dart';
import '../Helper/DrugState.dart';

class TakeDrugBar extends DrugBar {
  DrugOfDatabase drug;
  final drugService = DrugService();

  TakeDrugBar({required this.drug}) {
    this.drug = drug;
  }

  @override
  buildBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(children: [Text(drug.name)]),
        Column(children: [Text(drug.time)]),
        Column(children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return _buildPopUp(context);
                },
              );
            },
            child: Icon(Icons.medication_liquid),
          ),
        ]),
      ],
    );
  }

  _buildPopUp(BuildContext context) {
    return AlertDialog(
      title: Text("Medication Reminder"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        // Verhindert übergroßen Dialog
        children: [
          Text("Did you take your medication?"),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[200],
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Schließt den Dialog
                drugService.updateState(drug.id, SkippedState());
                },
                child: Text("Skip Today"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[200],
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Schließt den Dialog
                drugService.updateState(drug.id, TakenState());
                },
                child: Text("Yes"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
