import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationService() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final initializationSettingsDarwin = DarwinInitializationSettings(
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse);
  }

  void showNotification() {
    const notificationDetails = NotificationDetails();

    _flutterLocalNotificationsPlugin.show(
      0,
      "Stundenplanänderung! 😱",
      "Dein Stundenplan hat sich geändert. Tippe hier für mehr Details.",
      notificationDetails,
    );
  }

  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {}

  void _onDidReceiveNotificationResponse(NotificationResponse details) {}
}
