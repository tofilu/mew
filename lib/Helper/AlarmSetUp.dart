import "package:android_alarm_manager_plus/android_alarm_manager_plus.dart";
import 'package:mew/Helper/NotificationService.dart';

final NotificationService notificationService = NotificationService();

//Top Level Function
void callback() async {
  await notificationService.showNotification(
    title: 'Medication Reminder',
    body: 'Time to take your medication',
  );
}

class AlarmSetUp{

void setAlarm(int idMed, DateTime dateTime, int frequency) async {
  try {
    await AndroidAlarmManager.periodic(
        Duration(days: frequency),
        idMed,
        callback,
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
}