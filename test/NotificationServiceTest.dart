import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mew/Helper/NotificationService.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Mock-Kanal für flutter_local_notifications
  const MethodChannel notificationsChannel =
  MethodChannel('dexterous.com/flutter/local_notifications');
  final List<MethodCall> log = <MethodCall>[]; // Log zum Nachverfolgen von Aufrufen

  // Mock-Kanal für permission_handler
  const MethodChannel permissionChannel =
  MethodChannel('flutter.baseflow.com/permissions/methods');

  setUp(() {
    log.clear(); // Log vor jedem Test zurücksetzen

    // Mock für flutter_local_notifications
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(notificationsChannel, (MethodCall methodCall) async {
      log.add(methodCall); // Jeden Aufruf im Log speichern
      if (methodCall.method == 'initialize') {
        return true;
      } else if (methodCall.method == 'show') {
        return null; // Simuliere erfolgreichen Aufruf
      }
      return null;
    });

    // Mock für permission_handler
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(permissionChannel, (MethodCall methodCall) async {
      if (methodCall.method == 'requestPermissions') {
        return {
          Permission.notification.value: PermissionStatus.granted.index,
        }; // Simulierte Rückgabe
      }
      return null;
    });

    // Registrieren der Plugins
    AndroidFlutterLocalNotificationsPlugin.registerWith();
  });

  // Tests für den NotificationService
  late NotificationService notificationService;
  setUp(() {
    notificationService = NotificationService.instance;
  });

  test('initialize notifications', () async {
    await notificationService.initNotification();

    expect(
      log.last,
      isMethodCall('initialize', arguments: <String, Object>{
        'defaultIcon': '@mipmap/ic_launcher',
      }),
    );
  });

  test('request notification permission', () async {
    await notificationService.requestAndroidNotificationPermission();
  });

  test('show notification', () async {
    await notificationService.showNotification(
      id: 1,
      title: 'notification title',
      body: 'notification body',
    );

    expect(
      log.last,
      isMethodCall(
        'show',
        arguments: <String, Object?>{
          'id': 1,
          'title': 'notification title',
          'body': 'notification body',
          'payload': '',
          'platformSpecifics': <String, Object?>{
            'icon': null,
            'channelId': '1',
            'channelName': 'MEW',
            'channelDescription': 'MEW App',
            'channelShowBadge': true,
            'channelAction': 0,
            'importance': 5,
            'priority': 1,
            'playSound': true,
            'enableVibration': true,
            'vibrationPattern': null,
            'groupKey': null,
            'setAsGroupSummary': false,
            'groupAlertBehavior': 0,
            'autoCancel': true,
            'ongoing': false,
            'silent': false,
            'colorAlpha': null,
            'colorRed': null,
            'colorGreen': null,
            'colorBlue': null,
            'onlyAlertOnce': false,
            'showWhen': true,
            'when': null,
            'usesChronometer': false,
            'chronometerCountDown': false,
            'showProgress': false,
            'maxProgress': 0,
            'progress': 0,
            'indeterminate': false,
            'enableLights': false,
            'ledColorAlpha': null,
            'ledColorRed': null,
            'ledColorGreen': null,
            'ledColorBlue': null,
            'ledOnMs': null,
            'ledOffMs': null,
            'ticker': null,
            'visibility': null,
            'timeoutAfter': null,
            'category': null,
            'fullScreenIntent': false,
            'shortcutId': null,
            'additionalFlags': null,
            'subText': null,
            'tag': null,
            'colorized': false,
            'number': null,
            'audioAttributesUsage': 5,
            'style': 0,
            'styleInformation': <String, Object?>{
              'htmlFormatContent': false,
              'htmlFormatTitle': false,
            },
          },
        },
      ),
    );
  });

}
