import 'package:flutter/material.dart';
import 'Helper/Drug.dart';
import 'ListScreen.dart';
import 'package:mew/TakeDrugBar.dart';

class DailyScreen extends ListScreen {
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: key, body: createFutureBuilder());
  }

  @override
  makeDrugBars(List<Drug> drugs) {
    List<TakeDrugBar> alarmBars = [];
    for (Drug drug in drugs) {
      if (drug.counter == 0) {
        TakeDrugBar bar = TakeDrugBar(drug: drug);
        alarmBars.add(bar);
      }
    }
    return alarmBars;
  }
}
