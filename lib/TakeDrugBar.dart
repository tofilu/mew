import 'package:flutter/material.dart';
import 'DrugBar.dart';
import 'Helper/Drug.dart';

class TakeDrugBar extends DrugBar {
  Drug drug;

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
          Text("Take medication"),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Schließt den Dialog
                },
                child: Text("Skip"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Schließt den Dialog
                },
                child: Text("Done"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
