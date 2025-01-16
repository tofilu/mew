import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid);

    await notificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {
          },
    );

    await requestAndroidNotificationPermission();
  }

  Future<void> requestAndroidNotificationPermission() async {
    PermissionStatus status = await Permission.notification.request();

    if (status.isGranted) {
      print("Benachrichtigungsberechtigung erteilt");
    } else if (status.isDenied) {
      print("Benachrichtigungsberechtigung abgelehnt");
    } else if (status.isPermanentlyDenied) {
      print("Benachrichtigungsberechtigung dauerhaft abgelehnt");
      // Öffnen Sie die App-Einstellungen, um die Berechtigung zu aktivieren
      await openAppSettings();
    }
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