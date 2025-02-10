import '../Helper/DrugOfDatabase.dart';
import 'DrugStates.dart';
import 'TakeTodayState.dart';
class SkippedState extends DrugStates {
  @override
  void countUp(DrugOfDatabase drug) {
    drug.state = TakeTodayState as DrugStates;
  }
}