import 'package:share_app/config/routes/app_routes.dart';

class InitialRoute {
  Future<String> initialize() async {
    dynamic token;

    if (token != null) {
      return AppRoutes.dashboard;
    }

    return AppRoutes.entrance;
  }
}
