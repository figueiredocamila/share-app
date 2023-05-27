import 'package:flutter/material.dart';
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

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }
}
