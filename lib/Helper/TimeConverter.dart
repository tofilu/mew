import 'package:flutter/material.dart';

abstract class TimeConverter {
  TimeConverter();

  static TimeOfDay convertStringToTimeOfDay(String time) {
    int hour = 0;
    int minute = 0;

    // Split the input string into hour and the remaining part
    List<String> firstSplit = time.split(':');
    if (firstSplit.length == 2) {
      hour = int.parse(firstSplit[0]);

      // Split the remaining part into minute and period (AM/PM)
      List<String> secondSplit = firstSplit[1].split(' ');
      if (secondSplit.length == 2) {
        minute = int.parse(secondSplit[0]);
        String period = secondSplit[1].toUpperCase();

        // Adjust for 12-hour clock conversions
        if (hour == 12 && period == "AM") {
          hour = 0;
        } else if (period == "PM" && hour != 12) {
          hour += 12;
        }
      }
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  static String convertTimeOfDayToString(TimeOfDay time) {
    int hour = time.hour;
    int minute = time.minute;

    // Determine AM or PM
    String period = hour >= 12 ? 'PM' : 'AM';

    // Convert hour to 12-hour format
    hour = hour % 12;
    if (hour == 0) hour = 12; // Adjust hour to 12 if it's 0 (midnight)

    // Format hour and minute with leading zero if necessary
    String hourString = hour.toString().padLeft(2, '0');
    String minuteString = minute.toString().padLeft(2, '0');

    return '$hourString:$minuteString $period';
  }
}
