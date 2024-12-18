class Drug {
  int? id;
  String name;
  String time;
  int frequency;
  int amountLeft;
  int prescriptionTime;
  int counter;

  Drug({
    this.id,
    required this.name,
    required this.time,
    required this.frequency,
    required this.amountLeft,
    required this.prescriptionTime,
    required this.counter
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'time': time,
      'frequency': frequency,
      'amountLeft': amountLeft,
      'prescriptionTime': prescriptionTime,
      'counter': counter
    };
  }
}