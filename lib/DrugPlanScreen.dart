import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mew/database/DatabaseHandler.dart';

import 'DrugAlarmBar.dart';
import 'Helper/Drug.dart';

class DrugPlanScreen extends StatelessWidget {

  final DatabaseHandler dbHandler = DatabaseHandler();

  @override
  Widget build(BuildContext context) {
  //ich möchte alle eingetragenen Medikamente aus der DB rausholen, und für jeden
    //Eintrag ein Objekt vom Typ DrugAlarmBar erstellen
    //ich kann hier nicht await benutzen, weil die Methode in der await verwendet
    //wird async sein muss, und die build methode nicht async sein darf
    //(deswegen auslagerung in eigene methode)
    Future<List<Drug>> allDrugAlarms = getAllDrugAlarms();

    List<DrugAlarmBar> barList = [];
    //allDrugAlarms ist vom typ future und deswegen kein iterable
    //ich könnte hier natürlich eine fehlerbehandlung machen und den Wert aus
    //dem future rausholen, aber ich denke das ist eher eine aufgabe vom db handler
    if (allDrugAlarms != null) {
      for (Drug drug in allDrugAlarms) {
      //
        DrugAlarmBar drugBar = DrugAlarmBar(drug: drug);
        barList.add(drugBar);
      }
    }

    return Scaffold(
        body: ListView.builder(
            itemCount: barList.length,
            itemBuilder: (context, index) {
              final item = barList[index];

              return ListTile(leading: item);
            }));
  }

  Future<List<Drug>> getAllDrugAlarms() async {
    List<Drug> allAlarms = await dbHandler.getAll();
    return allAlarms;
  }

