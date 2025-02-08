import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:mew/database/DatabaseHandler.dart';

class AlarmMidnight {

  static Future<void> scheduleDailyCheck() async {
    await AndroidAlarmManager.periodic(
      const Duration(days: 1),
      0,
      _checkMidnight,
      startAt: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0),
      exact: true,
      wakeup: true,
    );
  }

  static Future<void> _checkMidnight() async {
    final DatabaseHandler dbHandler = DatabaseHandler();
    dbHandler.countOneUpAll();
  }
}
