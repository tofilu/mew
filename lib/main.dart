import 'package:flutter/material.dart';
import 'package:mew/theme/mewTheme.dart';
import 'Helper/NotificationService.dart';
import 'Home.dart';
import 'database/DatabaseHandler.dart';


void main() async {
  // Ensure that plugin services are initialized so that `AndroidAlarmManager` is registered
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.instance.initNotification();

  runApp(const MewApp());
}

class MewApp extends StatelessWidget {
  const MewApp({super.key});

  @override
  Widget build(BuildContext context) {
    DatabaseHandler().deleteDatabaseFile('medicament_database.db');
    return MaterialApp(
        theme: MewTheme.lightTheme,
        darkTheme: MewTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const Home(index: 0));
  }
}
