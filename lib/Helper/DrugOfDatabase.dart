import 'package:mew/Helper/Drug.dart';

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
        required DrugStates state,
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'time': time,
      'frequency': frequency,
      'dosage': dosage,
      'counter': counter,
//????
    };
  }

  void countUp() {
    _state.countUp(this);
  }
}