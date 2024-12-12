import 'package:flutter/material.dart';

class AddDrugScreen extends StatefulWidget {
  const AddDrugScreen({super.key});

  @override
  _AddDrugScreenState createState() => _AddDrugScreenState();
}

class _AddDrugScreenState extends State<AddDrugScreen> {
  TimeOfDay? selectedTime;

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
    return Scaffold(
      appBar: AppBar(
        title: Text('New Medication'),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold,
        fontSize: 36,
        color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Medication Name',
                hintText: 'Enter the name of the medication',
                labelStyle: TextStyle(color: Colors.white),
                floatingLabelStyle: TextStyle(color: Colors.teal[900]),
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.teal,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(24)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white12),
                  borderRadius: BorderRadius.circular(24)
                )
              ),
            ),
            SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                labelText: 'Dosage',
                hintText: 'Enter the dosage (e.g., 500 mg)',
                  labelStyle: TextStyle(color: Colors.white),
                  floatingLabelStyle: TextStyle(color: Colors.teal[900]),
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.teal,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(24)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white12),
                      borderRadius: BorderRadius.circular(24)
                  )
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
                  style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
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
                  labelStyle: TextStyle(color: Colors.white),
                  floatingLabelStyle: TextStyle(color: Colors.teal[900]),
                  hintStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.teal,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(24)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white12),
                      borderRadius: BorderRadius.circular(24)
                  )
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20
                  )
                ),
                onPressed: () {
                  // Add save logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Medication saved!')),
                  );
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
