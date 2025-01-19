import 'package:flutter/material.dart';
import 'package:mew/AddDrugScreen.dart';
import 'package:mew/Helper/TimeConverter.dart';

class ChangeDrugScreen extends AddDrugScreen {
  String medicationName;
  String dosage;
  String time;
  int frequency;
  int prescriptionTime;
  late TimeOfDay toD;

  ChangeDrugScreen(
      {super.key,
      required this.medicationName,
      required this.dosage,
      required this.time,
      required this.frequency,
      required this.prescriptionTime})
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
