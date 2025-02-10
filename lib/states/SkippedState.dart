class SkippedState extends DrugStates {
  @override
  void countUp(DrugOfDatabase drug) {
    drug.state = TakeTodayState();
  }
}