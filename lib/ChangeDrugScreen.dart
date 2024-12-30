import 'package:flutter/material.dart';
import 'package:mew/Helper/TimeConverter.dart';

class ChangeDrugScreen extends StatefulWidget {
  String medicationName;
  String dosage;
  String time;
  late TimeOfDay toD;

  ChangeDrugScreen(
      {super.key,
      required this.medicationName,
      required this.dosage,
      required this.time})
      : toD = TimeConverter.convertStringToTimeOfDay(time);

  @override
  _ChangeDrugScreenState createState() => _ChangeDrugScreenState();
}

class _ChangeDrugScreenState extends State<ChangeDrugScreen> {
  TimeOfDay? selectedTime;

  void initState() {
    super.initState();
    selectedTime = widget.toD;
  }

  void _selectTime(BuildContext context) async {
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
    print(TimeOfDay(hour: 15, minute: 00).format(context));
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Alarm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              initialValue: widget.medicationName,
              decoration: InputDecoration(
                //labelText: 'Medication Name',
                hintText: 'Enter the name of the medication',
              ),
            ),
            SizedBox(height: 24),
            TextFormField(
              initialValue: widget.dosage,
              decoration: InputDecoration(
                //labelText: 'Dosage',
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
                  onPressed: () => _selectTime(context),
                  child: Text('Pick Time'),
                ),
              ],
            ),
            SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                labelText: 'Supply',
                hintText: 'Enter your supply',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add save logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Medication saved!')),
                  );
                },
                child: Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
