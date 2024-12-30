import 'package:flutter/material.dart';
import 'package:path/path.dart';

abstract class TimeConverter {
  TimeConverter();

  static TimeOfDay convertStringToTimeOfDay(String time) {
    int hour = 0;
    int minute = 0;
    List<String> firstSplit = time.split(':');
    if (firstSplit.length > 1) {
      String hourString = firstSplit[0];
      hour = int.parse(hourString);
      List<String> secondSplit = firstSplit[1].split(' ');
      if (secondSplit.length > 1) {
        String minuteString = secondSplit[0];
        minute = int.parse(minuteString);
        if (hour == 12 && secondSplit[1] == "AM") {
          hour -= 12;
        }

        if (secondSplit[1] == "PM") {
          if (hour != 12) {
            hour += 12;
          }
        }
      }
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  static String convertTimeOfDayToString(TimeOfDay time) {
    int hour = time.hour;
    int minute = time.minute;
    String hourString;
    String minuteString;

    String am_pm = "AM";

    if (hour >= 12) {
      hour -= 12;
      am_pm = "PM";
    }
    if (hour == 0) {
      hour += 12;
    }
    if (hour < 10) {
      hourString = "0$hour";
    } else {
      hourString = hour.toString();
    }
    if (minute < 10) {
      minuteString = "0$minute";
    } else {
      minuteString = minute.toString();
    }

    return "$hourString:$minuteString $am_pm";
  }
}
