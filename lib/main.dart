import 'package:flutter/material.dart';
import 'package:mew/DailyScreen.dart';
import 'package:mew/DrugPlanScreen.dart';
import 'package:mew/theme/mewTheme.dart';
import 'package:mew/AddDrugScreen.dart';
import 'Home.dart';
import 'database/DatabaseHandler.dart';
import 'package:mew/Helper/NotificationService.dart';

void main() => runApp(const MewApp());

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
