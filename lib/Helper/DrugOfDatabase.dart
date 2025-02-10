import 'package:mew/Helper/Drug.dart';
import '../states/DrugStates.dart';

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
        required super.state,
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'time': time,
      'frequency': frequency,
      'dosage': dosage,
      'counter': counter,
      'state': state.toString(),
    };
  }

  void countUp() {
    state.countUp(this);
  }
}