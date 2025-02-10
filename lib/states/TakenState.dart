import 'package:mew/states/TakeSoonState.dart';
import '../Helper/DrugOfDatabase.dart';
import 'DrugStates.dart';
import 'TakeTodayState.dart';

class TakenState implements DrugStates {
  @override
  void countUp(DrugOfDatabase drug) {
    drug.counter = 1;
    if (drug.counter < drug.frequency ) {
      drug.state = TakeSoonState() as DrugStates;
    } else {
      drug.counter = 0;
      drug.state = TakeTodayState() as DrugStates;
    }
  }
}