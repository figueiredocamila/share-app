import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:share_app/config/firebase/firebase_options.dart';
import 'package:share_app/config/routes/app_routes.dart';
import 'package:share_app/config/routes/initial_route.dart';
import 'package:share_app/config/shared_preferences/shared_pref.dart';
import 'package:share_app/src/shared/controller/location_controller.dart';
import 'package:share_app/src/shared/service/notification/notification_service.dart';

final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    Future.delayed(const Duration(seconds: 2), () {}),
    Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ),
  ]);

  final SharedPref sharedPref = SharedPref();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.denied) {
    await messaging.unsubscribeFromTopic('all');
  }

  final fcmToken = await messaging.getToken();
  await messaging.subscribeToTopic('all');

  if (fcmToken != null && fcmToken != '') {
    await sharedPref.setFcmToken(fcmToken);
  }

  await messaging.setAutoInitEnabled(true);

  LocationController.registerBackgroundTask();

  String initialRoute = await InitialRoute().initialize();

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
  void initState() {
    super.initState();
    initilizeFirebaseMessaging();
  }

  initilizeFirebaseMessaging() async {
    NotificationService.initialize();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      NotificationService.showNotification(message);
    });

    FirebaseMessaging.onBackgroundMessage(
      (RemoteMessage message) async {
        NotificationService.showNotification(message);
      },
    );
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
