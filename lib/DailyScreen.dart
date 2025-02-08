import 'package:flutter/material.dart';
import 'Helper/DrugOfDatabase.dart';
import 'ListScreen.dart';
import 'package:mew/TakeDrugBar.dart';

class DailyScreen extends ListScreen {
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: key, body: createFutureBuilder());
  }

  @override
  makeDrugBars(List<DrugOfDatabase> drugs) {
    List<TakeDrugBar> alarmBars = [];
    for (DrugOfDatabase drug in drugs) {
      if (drug.counter == 0) {
        TakeDrugBar bar = TakeDrugBar(drug: drug);
        alarmBars.add(bar);
      print("DailyScreen: makeDrugBars: drug: ${drug.name}");
      }
    }
    return alarmBars;
  }
}
