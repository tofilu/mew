import 'package:mew/states/TakeTodayState.dart';
import '../Helper/DrugOfDatabase.dart';
import 'DrugStates.dart';

class TakeSoonState extends DrugStates {
  @override
  void countUp(DrugOfDatabase drug) {
    if (drug.counter < drug.frequency ) {
      drug.counter = drug.counter + 1;
    } else {
      drug.counter = 0;
      drug.state = TakeTodayState();
    }
  }
}