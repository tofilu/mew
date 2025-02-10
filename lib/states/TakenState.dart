class TakenState implements DrugStateBehavior {
  @override
  void countUp(DrugOfDatabase drug) {
    drug.counter = 1;
    if (drug.counter < drug.frequency ) {
      drug.state = TakeSoonState();
    } else {
      drug.counter = 0;
      drug.state = TakeTodayState();
    }
  }
}