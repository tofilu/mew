import 'package:flutter/material.dart';
import 'package:mew/Helper/DrugOfDatabase.dart';

import 'DrugAlarmBar.dart';
import 'Helper/Drug.dart';
import 'ListScreen.dart';

class DrugPlanScreen extends ListScreen {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: createFutureBuilder()));
  }

  @override
  makeDrugBars(List<DrugOfDatabase> drugs) {
    List<DrugAlarmBar> alarmBars = [];
    for (DrugOfDatabase drug in drugs) {
      DrugAlarmBar bar = DrugAlarmBar(drug: drug);
      alarmBars.add(bar);
    }
    return alarmBars;
  }
}
