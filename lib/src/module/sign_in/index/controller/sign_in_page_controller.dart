import 'package:flutter/material.dart';

class SignInPageController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String error = '';

  void setError(String value) {
    error = value;
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
