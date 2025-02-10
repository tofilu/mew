import '../Helper/DrugOfDatabase.dart';
import 'SkippedState.dart';
import 'TakeSoonState.dart';
import 'TakeTodayState.dart';
import 'TakenState.dart';

abstract class DrugStates {
  void countUp(DrugOfDatabase drug);

  static DrugStates getStateFromString(String state) {
    switch (state) {
      case 'TakeTodayState':
        return TakeTodayState();
      case 'TakeSoonState':
        return TakeSoonState();
      case 'TakenState':
        return TakenState();
      case 'SkippedState':
        return SkippedState();
      default:
        return TakeTodayState();
    }
  }
}