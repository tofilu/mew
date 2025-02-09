import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:mew/database/DatabaseHandler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';
import 'NotificationService.dart';

@pragma('vm:entry-point')
Future<void> _checkMidnight() async {
tz.initializeTimeZones();
final DatabaseHandler dbHandler = DatabaseHandler();
dbHandler.countOneUpAll();
AlarmMidnight.scheduleMidnightAlarm(1);
}
bool isAlarmScheduled = false;

class AlarmMidnight {

  static Future<void> scheduleMidnightAlarm(int n) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('midnightAlarmScheduled')) {
      return;
    }
    sharedPreferences.setBool('midnightAlarmScheduled', true);
    await AndroidAlarmManager.oneShotAt(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + n, 1, 10, 30),
      69,
      _checkMidnight,
      exact: true,
      wakeup: true,
    );
    print('Scheduled midnight alarm');
  }



}
