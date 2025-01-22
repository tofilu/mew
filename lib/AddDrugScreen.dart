import 'package:flutter/material.dart';
import 'Helper/Drug.dart';
import 'Home.dart';
import 'database/DatabaseHandler.dart';

class AddDrugScreen extends StatefulWidget {
  final DatabaseHandler dbHandler = DatabaseHandler();

  AddDrugScreen({super.key});

  @override
  AddDrugScreenState createState() => AddDrugScreenState();
}

class AddDrugScreenState extends State<AddDrugScreen> {
  final TextEditingController medicationNameController =
      TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController presciptionTimeController =
      TextEditingController();
  final TextEditingController frequencyController = TextEditingController();
  TimeOfDay? selectedTime;

  Future<void> saveMedication() async {
    final String medicationName = medicationNameController.text;
    final String dosage = dosageController.text;
    final int frequency = int.parse(frequencyController.text);
    final int prescriptionTime = int.parse(presciptionTimeController.text);
    final String time = selectedTime?.format(context) ?? '';

    // Save the medication to the database

    Drug drug = Drug(
      name: medicationName,
      time: time,
      frequency: frequency,
      dosage: dosage,
      prescriptionTime: prescriptionTime,
      counter: 0,
    );
    addToDatabase(drug);

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Medication: $medicationName saved")),
    );
  }

  void addToDatabase(Drug drug) {
    widget.dbHandler.addToDataBase(drug);
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
        title: Text('New Medication'),
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
            TextField(
              controller: presciptionTimeController,
              decoration: InputDecoration(
                labelText: 'Presciption time',
                hintText: 'Enter your prescription time',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  saveMedication();
                  // Add save logic here
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const Home(index: 2),
                    ),
                    (Route<dynamic> route) =>
                        false, // Remove all previous routes
                  );
                  ;
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
