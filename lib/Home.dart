import 'package:flutter/material.dart';
import 'AddDrugScreen.dart';
import 'DailyScreen.dart';
import 'DrugPlanScreen.dart';
import 'Helper/NotificationService.dart';

class Home extends StatefulWidget {
  final int index;
  const Home({super.key, required this.index});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;
  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.index;
  }

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
    final notificationService =
        NotificationService(); // Create a single instance

    var timeNow = DateTime.now();
    var time = DateTime.now().add(Duration(seconds: 5));

    return Scaffold(
      appBar: AppBar(
        title: Text('MEW'),
        actions: [
          ElevatedButton(
            onPressed: () async {
              // Test notification
              try {
                await notificationService.showNotification(
                  title: 'Instant Notification',
                  body: 'Instant Notification at: $timeNow',
                );
                print('pressed button');
                await notificationService.scheduleNotification(
                  id: 1,
                  title: 'Scheduled Notification',
                  body: 'Scheduled Notification for: $time',
                  scheduleTime: DateTime.now().add(Duration(seconds: 5)),
                );
              } catch (e) {
                print('ERROR NOTI: $e');
              }
            },
            child: Text('Noti Test'),
          ),
        ],
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
