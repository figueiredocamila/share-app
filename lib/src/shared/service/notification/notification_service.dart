import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static void showNotification(RemoteMessage notificationData) async {
    RemoteNotification? notification = notificationData.notification;
    AndroidNotification? android = notificationData.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel_id',
            'channel_name',
            channelDescription: 'channel_description',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
      );

      // NotificationController.getRecievedNotification().then((notifications) {
      //   NotificationController.recievedNotification = notifications;
      // });
    }
  }
}
