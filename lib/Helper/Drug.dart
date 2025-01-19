class Drug {
  int id;
  String name;
  String time;
  int frequency;
  String dosage;
  int prescriptionTime;
  int counter;

  Drug(
      {this.id = 0,
      required this.name,
      required this.time,
      required this.frequency,
      required this.dosage,
      required this.prescriptionTime,
      required this.counter});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'time': time,
      'frequency': frequency,
      'dosage': dosage,
      'prescriptionTime': prescriptionTime,
      'counter': counter
    };
  }
}
