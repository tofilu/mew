import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    print('Initializing Notification Service...');
    AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid);

    await notificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
          print('Notification clicked');
          },
    );
    print('Notification Service Initialized');
  }

  Future showNotification (
  {int id = 0, String? title, String? body, String? payload}) async {
    return notificationsPlugin.show(id, title, body, await notificationDetails());
  }

  Future<NotificationDetails> notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId', // Unique channel ID
        'channelName', // Channel name displayed to the user
        channelDescription: 'Channel description', // Optional description
        importance: Importance.max,
        priority: Priority.high, // Ensures the notification is displayed prominently
      ),
    );
  }

}