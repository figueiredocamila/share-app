import 'package:flutter/material.dart';
import 'package:share_app/src/module/dashboard/index/page/dashboard_page.dart';
import 'package:share_app/src/module/entrance/index/page/entrance_page.dart';

class AppRoutes {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static const String entrance = '/entrance';

  static const String dashboard = '/dashboard';

  static final routes = {
    AppRoutes.dashboard: (context) => const DashboardPage(),
    AppRoutes.entrance: (context) => const EntrancePage(),
  };
}
