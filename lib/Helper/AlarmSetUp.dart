import "package:android_alarm_manager_plus/android_alarm_manager_plus.dart";

class AlarmSetUp{

void setUpExactPeriodicAlarm(int id, DateTime dateTime, int frequency) async {
    await AndroidAlarmManager.periodic(
        Duration(days: frequency),
        id,
        callback,
        exact: true,
        wakeup: true,
        startAt: dateTime,
        rescheduleOnReboot: true);
  }

  void callback() {
  //Notification auslösen
    print('Alarm fired!');
  }

  void cancelAlarm(int id) async {
    await AndroidAlarmManager.cancel(id);
  }
}