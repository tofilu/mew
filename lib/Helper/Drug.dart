import '../Helper/DrugState.dart';

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
}
