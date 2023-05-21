import 'package:share_app/config/routes/app_routes.dart';
import 'package:share_app/config/shared_preferences/shared_pref.dart';

class InitialRoute {
  final SharedPref sharedPref = SharedPref();

  Future<String> initialize() async {
    dynamic userId = await sharedPref.getUserId();

    if (userId.toString().isNotEmpty) {
      return AppRoutes.dashboard;
    }

    return AppRoutes.signIn;
  }
}
