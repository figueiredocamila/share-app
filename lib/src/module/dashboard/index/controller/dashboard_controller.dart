import 'package:flutter/material.dart';
import 'package:share_app/config/routes/app_routes.dart';
import 'package:share_app/src/shared/controller/auth_controller.dart';

class DashboardController {
  final AuthController authController = AuthController();
  final TextEditingController message = TextEditingController();

  void signOut(BuildContext context) {
    authController.signOut();
    Navigator.pushNamed(context, AppRoutes.signIn);
  }

  void dispose() {
    message.dispose();
  }
}
