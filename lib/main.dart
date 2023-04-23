import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:share_app/config/routes/app_routes.dart';
import 'package:share_app/config/routes/initial_route.dart';

Future<void> main() async {
  String initialRoute = await InitialRoute().initialize();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'camis',
      navigatorKey: AppRoutes.navigatorKey,
      initialRoute: widget.initialRoute,
      routes: AppRoutes.routes,
    );
  }
}
