import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_app/config/firebase/firebase_options.dart';
import 'package:share_app/config/routes/app_routes.dart';
import 'package:share_app/config/routes/initial_route.dart';
import 'package:share_app/config/shared_preferences/shared_pref.dart';
import 'package:share_app/src/shared/service/notification/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future<void>.delayed(const Duration(seconds: 2));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  try {
    final fcmToken = await firebaseMessaging.getToken();

    debugPrint("FCM Token: $fcmToken");

    await firebaseMessaging.setAutoInitEnabled(true);
    await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    await SharedPref().setFcmToken(fcmToken!);

    String initialRoute = await InitialRoute().initialize();

    runApp(ShareApp(initialRoute: initialRoute));
  } catch (e) {
    debugPrint("Error initializing Firebase Messaging: $e");
  }
}

class ShareApp extends StatefulWidget {
  const ShareApp({
    super.key,
    required this.initialRoute,
  });

  final String initialRoute;

  @override
  State<ShareApp> createState() => _ShareAppState();
}

class _ShareAppState extends State<ShareApp> {
  static const platform = MethodChannel('com.example.share_app/location');

  late FirebaseMessaging firebaseMessaging;

  @override
  void initState() {
    super.initState();
    initializeFirebaseMessaging();
    startLocationService();
  }

  void initializeFirebaseMessaging() {
    debugPrint("Initializing Firebase Messaging...");
    NotificationService.initialize();

    debugPrint("Initializing Firebase Messaging...2");

    firebaseMessaging = FirebaseMessaging.instance;

    debugPrint("Initializing Firebase Messaging...3");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("FCM Message: ${message.notification?.body}");
      NotificationService.showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("FCM Message: ${message.notification?.body}");
      NotificationService.showNotification(message);
    });
  }

  Future<void> startLocationService() async {
    try {
      debugPrint("Starting location service...");
      await platform.invokeMethod('startLocationService');
    } on PlatformException catch (e) {
      debugPrint("Error starting location service: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Share App',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      navigatorKey: AppRoutes.navigatorKey,
      initialRoute: widget.initialRoute,
      routes: AppRoutes.routes,
    );
  }
}
