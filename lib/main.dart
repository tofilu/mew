import 'package:flutter/material.dart';
import 'package:mew/DailyScreen.dart';
import 'package:mew/DrugPlanScreen.dart';
import 'package:mew/theme/mewTheme.dart';
import 'package:mew/AddDrugScreen.dart';

void main() => runApp(const MewApp());

class MewApp extends StatelessWidget {
  const MewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: MewTheme.lightTheme,
        darkTheme: MewTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const Home());
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;

  List<Widget> screenIcons = [
    NavigationDestination(
      icon: Icon(Icons.check),
      label: 'Daily',
    ),
    NavigationDestination(
      icon: Icon(Icons.add),
      label: 'Add Medication',
    ),
    NavigationDestination(icon: Icon(Icons.medication), label: 'DrugPlan')
  ];

  List<Widget> screens = [DailyScreen(), AddDrugScreen(), DrugPlanScreen()];

  @override
  Widget build(BuildContext context) {
    //final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('MEW')
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.blue,
        selectedIndex: currentPageIndex,
        destinations: screenIcons,
      ),
      body: screens[currentPageIndex],
    );
  }
}
