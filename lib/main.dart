import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:share_app/config/routes/app_routes.dart';
import 'package:share_app/config/routes/initial_route.dart';
import 'package:share_app/src/shared/controller/location_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LocationController.registerBackgroundTask();

  await Firebase.initializeApp();

  String initialRoute = await InitialRoute().initialize();

  final fcmToken = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  debugPrint('User granted permission: ${settings.authorizationStatus}');
  debugPrint('Token: $fcmToken');

  runApp(ShareApp(initialRoute: initialRoute));
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
