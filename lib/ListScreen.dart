import 'package:flutter/material.dart';

import 'Helper/Drug.dart';
import 'TakeDrugBar.dart';
import 'database/DatabaseHandler.dart';

class ListScreen extends StatelessWidget {
  final DatabaseHandler dbHandler = DatabaseHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold();
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
            List<Drug> sortedDrugs = sortDrugsByTime(drugs);

            List<StatelessWidget> drugAlarmBars = makeDrugBars(sortedDrugs);
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

  ListView displayBars(List<StatelessWidget> alarmBars) {
    return ListView.builder(
        itemCount: alarmBars.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(child: alarmBars[index]);
        });
  }

  List<StatelessWidget> makeDrugBars(List<Drug> drugs) {
    List<TakeDrugBar> alarmBars = [];
    for (Drug drug in drugs) {
      if (drug.counter == 0) {
        TakeDrugBar bar = TakeDrugBar(drug: drug);
        alarmBars.add(bar);
      }
    }
    return alarmBars;
  }

  List<Drug> sortDrugsByTime(List<Drug> drugs) {
    List<Drug> sortedDrugs = List.from(drugs);
    sortedDrugs.sort((a, b) => a.time.compareTo(b.time));
    return sortedDrugs;
  }
}
