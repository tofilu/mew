import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {

  // Private Konstruktor
  NotificationService._privateConstructor();

  // Statische Instanz des Singleton
  static final NotificationService _instance = NotificationService._privateConstructor();

  // Getter für den Zugriff auf die Instanz
  static NotificationService get instance => _instance;

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

    tz.initializeTimeZones();
    // Abrufen der Zeitzoneneinstellung des Geräts
    String deviceTimeZone = DateTime.now().timeZoneName;

    try {
      // Versuche, die Zeitzone anhand des Gerätenamens zu setzen
      tz.setLocalLocation(tz.getLocation(deviceTimeZone));
    } catch (e) {
      // Fallback zu einer Standardzeitzone, wenn die Gerätename nicht erkannt wird
      tz.setLocalLocation(tz.getLocation('Europe/Berlin'));
    }
    await requestAndroidNotificationPermission();
  }

  Future<void> requestAndroidNotificationPermission() async {
    // Anfrage für Benachrichtigungsberechtigung
    PermissionStatus notificationStatus = await Permission.notification.request();
    PermissionStatus alarmStatus = await Permission.scheduleExactAlarm.request();

    if (notificationStatus.isDenied && alarmStatus.isDenied) {
      await openAppSettings();
      return;
    } else if (notificationStatus.isPermanentlyDenied && alarmStatus.isPermanentlyDenied) {
      await openAppSettings();
      return;
    }
  }

  Future showNotification (
  {int id = 0, String? title, String? body, String? payload}) async {
    return notificationsPlugin.show(id, title, body, await notificationDetails());
  }

  Future<NotificationDetails> notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        '1', // Unique channel ID
        'MEW', // Channel name displayed to the user
        channelDescription: 'MEW App', // Optional description
        importance: Importance.max,
        priority: Priority.high, // Ensures the notification is displayed prominently
      ),
    );
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduleTime,
  }) async {
    final tz.TZDateTime scheduledDate = tz.TZDateTime.from(scheduleTime, tz.local);

    try {
      await notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        scheduledDate,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            '2',
            'Mew Scheduled',
            channelDescription: 'Scheduled Notifications from MEW',
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime
      );
    } catch (e) {
      print('Error scheduling notification: $e');
    }
  }
}