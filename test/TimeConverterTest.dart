import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mew/Helper/TimeConverter.dart';

void main() {
  test('StringToTimeOfDay', () {
    //Arrange
    String timeString = "03:02 AM";
    TimeOfDay time = TimeOfDay(hour: 03, minute: 02);
    //Act
    TimeOfDay actual = TimeConverter.convertStringToTimeOfDay(timeString);
    //Assert
    expect(time, actual);
  });

  test('StringPMtoAM', () {
    String timeString = "03:02 PM";
    TimeOfDay time = TimeOfDay(hour: 15, minute: 02);
    TimeOfDay actual = TimeConverter.convertStringToTimeOfDay(timeString);
    expect(time, actual);
  });

  test('edgeCases', () {
    String timeString = "12:30 AM";
    TimeOfDay time = TimeOfDay(hour: 00, minute: 30);
    TimeOfDay actual = TimeConverter.convertStringToTimeOfDay(timeString);
    expect(time, actual);

    String midnightString = "12:00 AM";
    TimeOfDay midnight = TimeOfDay(hour: 00, minute: 00);
    TimeOfDay actualMidnight =
        TimeConverter.convertStringToTimeOfDay(midnightString);
    expect(midnight, actualMidnight);

    String string11_59 = "11:59 PM";
    TimeOfDay expected11_59 = TimeOfDay(hour: 23, minute: 59);
    TimeOfDay actual11_59 = TimeConverter.convertStringToTimeOfDay(string11_59);
    expect(expected11_59, actual11_59);

    String string12_59 = "12:59 AM";
    TimeOfDay expected12_59 = TimeOfDay(hour: 00, minute: 59);
    TimeOfDay actual12_59 = TimeConverter.convertStringToTimeOfDay(string12_59);
    expect(expected12_59, actual12_59);

    String string_11_59am = "11:59 AM";
    TimeOfDay expected11_59am = TimeOfDay(hour: 11, minute: 59);
    TimeOfDay actual11_59am =
        TimeConverter.convertStringToTimeOfDay(string_11_59am);
    expect(expected11_59am, actual11_59am);

    String string12_pm = "12:00 PM";
    TimeOfDay expected12_pm = TimeOfDay(hour: 12, minute: 00);
    TimeOfDay actual12_pm = TimeConverter.convertStringToTimeOfDay(string12_pm);
    expect(expected12_pm, actual12_pm);

    String string12_30pm = "12:30 PM";
    TimeOfDay expected12_30pm = TimeOfDay(hour: 12, minute: 30);
    TimeOfDay actual12_30pm =
        TimeConverter.convertStringToTimeOfDay(string12_30pm);
    expect(expected12_30pm, actual12_30pm);
  });

  test('timeOfDayToString', () {
    TimeOfDay time = TimeOfDay(hour: 13, minute: 15);
    String timeString = "01:15 PM";
    String actual = TimeConverter.convertTimeOfDayToString(time);
    expect(timeString, actual);
  });

  test('timeOfDayToStringMidnight', () {
    TimeOfDay time = TimeOfDay(hour: 00, minute: 00);
    String timeString = "12:00 AM";
    String actual = TimeConverter.convertTimeOfDayToString(time);
    expect(timeString, actual);
  });

  test('timeOfDayToStringEdgeCaseAM', () {
    TimeOfDay time = TimeOfDay(hour: 00, minute: 30);
    String timeString = "12:30 AM";
    String actual = TimeConverter.convertTimeOfDayToString(time);
    expect(timeString, actual);
  });

  test('timeOfDayToStringEdgeCasePM', () {
    TimeOfDay time = TimeOfDay(hour: 12, minute: 15);
    String timeString = "12:15 PM";
    String actual = TimeConverter.convertTimeOfDayToString(time);
    expect(actual, timeString);
  });

  test('timeOfDayToStringEdgeCase1AM', () {
    TimeOfDay time = TimeOfDay(hour: 01, minute: 00);
    String timeString = "01:00 AM";
    String actual = TimeConverter.convertTimeOfDayToString(time);
    expect(actual, timeString);
  });

}
