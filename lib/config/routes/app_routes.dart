import 'package:flutter/material.dart';
import 'package:share_app/src/module/dashboard/index/page/dashboard_page.dart';
import 'package:share_app/src/module/sign_in/index/page/sign_in_page.dart';
import 'package:share_app/src/module/sign_up/index/page/sign_up_page.dart';

class AppRoutes {
  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

  static String initial = '/home';

  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String dashboard = '/dashboard';

  static final routes = {
    AppRoutes.signIn: (_) => const SignInPage(),
    AppRoutes.signUp: (_) => const SignUpPage(),
    AppRoutes.dashboard: (_) => const DashboardPage(),
  };
}
