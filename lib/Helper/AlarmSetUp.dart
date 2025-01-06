import "package:android_alarm_manager_plus/android_alarm_manager_plus.dart";

class AlarmSetUp{

void setUpExactPeriodicAlarm(int idMed, DateTime dateTime, int frequency) async {
    await AndroidAlarmManager.periodic(
        Duration(days: frequency),
        idMed,
        callback,
        exact: true,
        wakeup: true,
        startAt: dateTime,
        rescheduleOnReboot: true);
  }

  void changeAlarm(int idMed, DateTime dateTime, int frequency) async {
    await AndroidAlarmManager.cancel(idMed);
    setUpExactPeriodicAlarm(idMed, dateTime, frequency);
  }

  void callback() {
  //Notification auslösen
    print('Alarm fired!');
  }

  void cancelAlarm(int idMed) async {
    await AndroidAlarmManager.cancel(idMed);
  }
}