class TakeSoonState extends DrugStateBehavior {
  @override
  void countUp(DrugOfDatabase drug) {
    if (drug.counter < drug.frequency ) {
      drug.counter = drug.counter + 1;
    } else {
      drug.counter = 0;
      drug.state = NotTakenState();
    }
  }
}