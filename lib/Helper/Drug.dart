import '../Helper/DrugState.dart';
import '../Helper/DrugState.dart';
import '../database/DatabaseHandler.dart';
import '../states/DrugStateBase.dart';
import '../states/NotTakenState.dart';
import '../states/TakenState.dart';
import '../states/NotRequiredState.dart';
import 'DrugOfDatabase.dart';

class Drug {
  String name;
  String time;
  int frequency;
  String dosage;
  int counter;
  DrugStateBase state;

  Drug(
      {
      required this.name,
      required this.time,
      required this.frequency,
      required this.dosage,
      required this.counter,
      required this.state,
      });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'time': time,
      'frequency': frequency,
      'dosage': dosage,
      'counter': counter,
      'state': state,
    };
  }



}
