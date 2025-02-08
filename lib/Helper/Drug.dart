class Drug {
  String name;
  String time;
  int frequency;
  String dosage;
  int counter;

  Drug(
      {
      required this.name,
      required this.time,
      required this.frequency,
      required this.dosage,
      required this.counter});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'time': time,
      'frequency': frequency,
      'dosage': dosage,
      'counter': counter
    };
  }
}
