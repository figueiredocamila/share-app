import 'package:flutter/material.dart';
import 'package:share_app/config/routes/app_routes.dart';
import 'package:share_app/src/shared/controller/auth_controller.dart';

class SignUpController {
  final AuthController authController = AuthController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  String helperText = '';
  bool isLoading = false;

  void setHelperText(String message) {
    helperText = message;
  }

  void setIsLoading(status) {
    isLoading = status;
  }

  void signUp(context) {
    setIsLoading(true);

    try {
      authController.signUp(
        emailController.text,
        passwordController.text,
        nameController.text,
      );

      Navigator.pushNamed(context, AppRoutes.dashboard);
    } catch (e) {
      setHelperText(e.toString());
    }

    setIsLoading(false);
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }
}
