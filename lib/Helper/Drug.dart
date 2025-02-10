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
  DrugState state;

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
      'state': state.index,
    };
  }

  void changeState(DatabaseHandler dbHandler, DrugState newState) {
    DrugStateBase state = _getStateInstance(newState);
    state.handleStateChange(dbHandler, DrugOfDatabase(
      id: name.hashCode, // Kein echtes DB-Id, nur für Demonstration
      name: name,
      time: time,
      frequency: frequency,
      dosage: dosage,
      counter: counter,
      state: newState,
    ));
  }

  static DrugStateBase _getStateInstance(DrugState state) {
    switch (state) {
      case DrugState.notTaken:
        return NotTakenState();
      case DrugState.taken:
        return TakenState();
      case DrugState.NotRequired:
        return NotRequiredState();
      default:
        return NotTakenState();
    }
  }
}
