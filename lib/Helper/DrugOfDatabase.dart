import 'package:mew/Helper/Drug.dart';
import '../Helper/DrugOfDatabase.dart';
import '../Helper/DrugState.dart';
import '../database/DatabaseHandler.dart';
import '../states/DrugStateBase.dart';
import '../states/NotTakenState.dart';
import '../states/TakenState.dart';
import '../states/NotRequiredState.dart';

class DrugOfDatabase extends Drug{
  int id;
  DrugOfDatabase(
      {
        required this.id,
        required super.name,
        required super.time,
        required super.frequency,
        required super.dosage,
        required super.counter,
        required super.state
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'time': time,
      'frequency': frequency,
      'dosage': dosage,
      'counter': counter,

    };
  }
  @override
  void changeState(DatabaseHandler dbHandler, DrugState newState) {
    DrugStateBase state = _getStateInstance(newState);
    state.handleStateChange(dbHandler, this);
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