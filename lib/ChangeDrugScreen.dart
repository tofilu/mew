import 'package:flutter/material.dart';
import 'package:mew/AddDrugScreen.dart';
import 'package:mew/Helper/TimeConverter.dart';
import 'Helper/Drug.dart';

class ChangeDrugScreen extends AddDrugScreen {
  String nameBefore;
  String medicationName;
  String dosage;
  String time;
  int frequency;
  late TimeOfDay toD;

  ChangeDrugScreen(
      {super.key,
      required this.nameBefore,
      required this.medicationName,
      required this.dosage,
      required this.time,
      required this.frequency,
      })
      : toD = TimeConverter.convertStringToTimeOfDay(time);

  @override
  createState() => ChangeDrugScreenState();
}

class ChangeDrugScreenState extends AddDrugScreenState {
  TimeOfDay? selectedTime;

/*
  @override
  void initState() {
    super.initState();
    selectedTime = (widget as ChangeDrugScreen).toD;
  }
*/
  // Methode zum Speichern des geänderten Medikaments
  @override
  Future<void> saveMedication() async {
    final String medicationName = medicationNameController.text;
    final String dosage = dosageController.text;
    final String frequencyText = frequencyController.text;

    // Validierung der Eingabewerte
    if (medicationName.isEmpty ||
        dosage.isEmpty ||
        frequencyText.isEmpty ||
        selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bitte füllen Sie alle Felder aus')),
      );
      return;
    }
    final int frequency = int.parse(frequencyText);
    final String time = selectedTime?.format(context) ?? '';

    // Speichern des geänderten Medikaments in der Datenbank
    Drug drug = Drug(
      name: medicationName,
      time: time,
      frequency: frequency,
      dosage: dosage,
      counter: 0, // Counter bleibt auf 0, falls nicht verwendet
    );
    int id = await widget.dbHandler.getDrugId((widget as ChangeDrugScreen).nameBefore);
    // Hier wird das Medikament mit der richtigen ID aktualisiert
    widget.dbHandler.set(
      id,
      drug.name,
      drug.time,
      drug.frequency,
      drug.dosage,
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
    // Entferne die Zeilen, die den Text der Controller jedes Mal setzen
    return super.build(context);
  }
  
  @override
  void initState() {
    super.initState();
    medicationNameController.text = (widget as ChangeDrugScreen).medicationName;
    dosageController.text = (widget as ChangeDrugScreen).dosage;
    frequencyController.text =
        (widget as ChangeDrugScreen).frequency.toString();
    selectedTime = (widget as ChangeDrugScreen).toD;
  }

}
