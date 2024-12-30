import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mew/database/DatabaseHandler.dart';

import 'DrugAlarmBar.dart';
import 'Helper/Drug.dart';

class DrugPlanScreen extends StatelessWidget {
  final DatabaseHandler dbHandler = DatabaseHandler();

  DrugPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: createFutureBuilder()));
  }

  FutureBuilder createFutureBuilder() {
    return FutureBuilder(
        future: dbHandler.getAll(),
        builder: (context, snapshot) {
          //if future is completed and no error occurred, create an alarmbar
          //for every entry and display in listview
          if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasError) {
            List<Drug> drugs = snapshot.data;
            List<DrugAlarmBar> drugAlarmBars = makeDrugBars(drugs);
            return displayBars(drugAlarmBars);
          } else if (snapshot.hasError) {
            return Text("Error fetching Alarms");
            //if future is not done yet, return an empty container,
            //so that screen stays empty
          } else {
            return Container();
          }
        });
  }

  List<DrugAlarmBar> makeDrugBars(List<Drug> drugs) {
    List<DrugAlarmBar> alarmBars = [];
    for (Drug drug in drugs) {
      DrugAlarmBar bar = DrugAlarmBar(drug: drug);
      alarmBars.add(bar);
    }
    return alarmBars;
  }

  ListView displayBars(List<DrugAlarmBar> alarmBars) {
    return ListView.builder(
        itemCount: alarmBars.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(child: alarmBars[index]);
        });
  }
}
