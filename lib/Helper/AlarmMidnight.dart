import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:mew/database/DatabaseHandler.dart';

@pragma('vm:entry-point')
Future<void> _checkMidnight() async {
final DatabaseHandler dbHandler = DatabaseHandler();
dbHandler.countOneUpAll();
AlarmMidnight.scheduleMidnightAlarm();
}

class AlarmMidnight {

  static Future<void> scheduleMidnightAlarm() async {
    await AndroidAlarmManager.oneShotAt(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1, 0, 0, 30),
      69,
      _checkMidnight,
      exact: true,
      wakeup: true,
    );
  }


}
