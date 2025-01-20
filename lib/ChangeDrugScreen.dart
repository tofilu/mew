import 'package:flutter/material.dart';
import 'package:mew/AddDrugScreen.dart';
import 'package:mew/Helper/TimeConverter.dart';
import 'Helper/Drug.dart';
import 'database/DatabaseHandler.dart';

class ChangeDrugScreen extends AddDrugScreen {
  final DatabaseHandler dbHandler = DatabaseHandler();
  String medicationName;
  String dosage;
  String time;
  int frequency;
  int prescriptionTime;
  int id = 0;
  late TimeOfDay toD;

  ChangeDrugScreen(
      {super.key,
      required this.medicationName,
      required this.dosage,
      required this.time,
      required this.frequency,
      required this.prescriptionTime,
      required this.id})
      : toD = TimeConverter.convertStringToTimeOfDay(time);

  @override
  createState() => ChangeDrugScreenState();
}

class ChangeDrugScreenState extends AddDrugScreenState {
  TimeOfDay? selectedTime;

  void initState() {
    super.initState();
    selectedTime = (widget as ChangeDrugScreen).toD;
  }
  // Methode zum Speichern des geänderten Medikaments
  Future<void> saveMedication() async {
    final String medicationName = medicationNameController.text;
    final String dosage = dosageController.text;
    final String frequencyText = frequencyController.text;
    final String prescriptionTimeText = presciptionTimeController.text;

    // Validierung der Eingabewerte
    if (medicationName.isEmpty || dosage.isEmpty || frequencyText.isEmpty || prescriptionTimeText.isEmpty || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bitte füllen Sie alle Felder aus')),
      );
      return;
    }
    final int frequency = int.parse(frequencyText);
    final int prescriptionTime = int.parse(prescriptionTimeText);
    final String time = selectedTime?.format(context) ?? '';

    // Speichern des geänderten Medikaments in der Datenbank
    Drug drug = Drug(
      name: medicationName,
      time: time,
      frequency: frequency,
      dosage: dosage,
      prescriptionTime: prescriptionTime,
      counter: 0, // Counter bleibt auf 0, falls nicht verwendet
    );
    // Hier wird das Medikament mit der richtigen ID aktualisiert
    widget.dbHandler.set(
      (widget as ChangeDrugScreen).id,
      drug.name,
      drug.time,
      drug.frequency,
      drug.dosage,
      drug.prescriptionTime,
      drug.counter,
    );
    // Bestätigungsmeldung
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Medication: $medicationName updated")),
    );
  }
/*
  @override
  void addToDatabase(Drug drug) {
    widget.dbHandler.set((widget as ChangeDrugScreen).id, drug.name, drug.time,
        drug.frequency, drug.dosage, drug.prescriptionTime, drug.counter);
  }
*/
  @override
  Widget build(BuildContext context) {
    medicationNameController.text = (widget as ChangeDrugScreen).medicationName;
    dosageController.text = (widget as ChangeDrugScreen).dosage;
    frequencyController.text =
        (widget as ChangeDrugScreen).frequency.toString();
    presciptionTimeController.text =
        (widget as ChangeDrugScreen).prescriptionTime.toString();
    return super.build(context);
  }
}
