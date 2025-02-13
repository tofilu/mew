import 'package:flutter/material.dart';
import 'package:mew/states/TakeTodayState.dart';
import 'Helper/Drug.dart';
import 'Home.dart';
import '../Helper/DrugService.dart';

class AddDrugScreen extends StatefulWidget {
  final drugService = DrugService();

  AddDrugScreen({super.key});

  @override
  AddDrugScreenState createState() => AddDrugScreenState();
}

class AddDrugScreenState extends State<AddDrugScreen> {
  final TextEditingController medicationNameController =
      TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController frequencyController = TextEditingController();
  TimeOfDay? selectedTime;

  Future<void> saveMedication() async {
    final String medicationName = medicationNameController.text;
    final String dosage = dosageController.text;
    final int frequency = int.parse(frequencyController.text);
    final String time = selectedTime?.format(context) ?? '';

    // Save the medication to the database

    Drug drug = Drug(
      name: medicationName,
      time: time,
      frequency: frequency,
      dosage: dosage,
      counter: 0,
      state: TakeTodayState(),
    );
    widget.drugService.addDrug(drug);
  }

  bool checkInput() {
    bool validInput = true;
    final String medicationName = medicationNameController.text;
    if (medicationName.isEmpty) {
      validInput = false;
    }
    final String dosage = dosageController.text;
    if (dosage.isEmpty) {
      validInput = false;
    }
    final int? frequency = int.tryParse(frequencyController.text);
    if (frequency == null) {
      validInput = false;
    }

    if (selectedTime == null) {
      validInput = false;
    }
    return validInput;
  }

  void selectTime(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (time != null && time != selectedTime) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Medication"),
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 50,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.blueGrey[200] // Farbe im Dark Mode
                : Colors.blue[200], // Farbe im Light Mode
        ),
        backgroundColor: Colors.transparent,
        toolbarHeight: 120,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: medicationNameController,
              decoration: InputDecoration(
                labelText: 'Medication Name',
                hintText: 'Enter the name of the medication',
              ),
            ),
            SizedBox(height: 24),
            TextField(
              controller: dosageController,
              decoration: InputDecoration(
                labelText: 'Dosage',
                hintText: 'Enter the dosage (e.g., 500 mg)',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Text(
                  selectedTime != null
                      ? 'Time: ${selectedTime!.format(context)}'
                      : 'Select a time:',
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => selectTime(context),
                  child: Text('Pick Time'),
                ),
              ],
            ),
            SizedBox(height: 24),
            TextField(
              controller: frequencyController,
              decoration: InputDecoration(
                labelText: 'Frequency',
                hintText: 'Enter your frequency',
              ),
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (!checkInput()) {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(
                              "Invalid Input, Medication could not be saved!")),
                    );
                  } else {
                    await saveMedication();
                    // Show a snackbar
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Medication saved")),
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const Home(index: 2),
                      ),
                      (Route<dynamic> route) =>
                          false, // Remove all previous routes
                    );
                  }
                  // Add save logic here
                },
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
