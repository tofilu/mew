import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:mew/Helper/AlarmSetUp.dart';
import 'package:mew/theme/mewTheme.dart';
import 'Home.dart';


void main() async {
  // Ensure that plugin services are initialized so that `AndroidAlarmManager` is registered
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize AndroidAlarmManager
  await AndroidAlarmManager.initialize();
  AlarmSetUp().setUpAlarmMidnight();

  await notificationService.initNotification();

  runApp(const MewApp());
}

class MewApp extends StatelessWidget {
  const MewApp({super.key});

  @override
  Widget build(BuildContext context) {
    //DatabaseHandler().deleteDatabaseFile('medicament_database.db');
    return MaterialApp(
        theme: MewTheme.lightTheme,
        darkTheme: MewTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const Home(index: 0));
  }
}
