import "package:android_alarm_manager_plus/android_alarm_manager_plus.dart";
import 'package:mew/Helper/NotificationService.dart';
import '../database/DatabaseHandler.dart';

import 'Drug.dart';

final NotificationService notificationService = NotificationService();

//Top Level Function
void callback(int idMed) async {
  Drug drug = await DatabaseHandler().getDrug(idMed);
  await notificationService.showNotification(
    title: 'Medication Reminder of ${drug.name}',
    body: 'Time to take your ${drug.dosage} ${drug.name}',
  );
}

void callbackMidnight() async {
  DatabaseHandler().countOneUpAll;
  }


class AlarmSetUp{

void setAlarm(int idMed, DateTime dateTime, int frequency) async {
  try {
    await AndroidAlarmManager.periodic(
        Duration(days: frequency),
        idMed,
        () => callback(idMed),
        exact: true,
        wakeup: true,
        startAt: dateTime,
        rescheduleOnReboot: true);
  } catch (e) {
    print("ES SAVED DAS DING NICHT, Fehler:  $e");
  }
  }

  void changeAlarm(int idMed, DateTime dateTime, int frequency) async {
    await AndroidAlarmManager.cancel(idMed);
    setAlarm(idMed, dateTime, frequency);
  }

  void cancelAlarm(int idMed) async {
    await AndroidAlarmManager.cancel(idMed);
  }

void setUpAlarmMidnight(){
  DateTime now = DateTime.now();
  DateTime midnight = DateTime(now.year, now.month, now.day, 0, 0, 0);
  int id = -0;
  try {
    AndroidAlarmManager.periodic(
        const Duration(days: 1),
        id,
        callbackMidnight,
        exact: true,
        wakeup: true,
        startAt: midnight,
        rescheduleOnReboot: true);
  } catch (e) {
    print(e);
  }
}
}