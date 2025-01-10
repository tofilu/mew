import "package:android_alarm_manager_plus/android_alarm_manager_plus.dart";
import 'package:mew/Helper/NotificationService.dart';
import '../database/DatabaseHandler.dart';

import 'Drug.dart';

final NotificationService notificationService = NotificationService();

//Top Level Function
@pragma('vm:entry-point')
void callback(int idMed) async {
  print("im callback mit idMed: $idMed");
  Drug drug = await DatabaseHandler().getDrug(idMed);
  await notificationService.showNotification(
    title: 'Medication Reminder of ${drug.name}',
    body: 'Time to take your ${drug.dosage} ${drug.name}',
  );
}

@pragma('vm:entry-point')
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
      print("saved Alarm");
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
  print("midnight alarm saved");
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

void cancelAllAlarms() async {
  for (int i = 0; i <= 5; i++) {
    await AndroidAlarmManager.cancel(i); // Assuming you use IDs from 1 to 100
  }
}


}