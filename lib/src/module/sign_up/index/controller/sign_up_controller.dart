import 'package:flutter/material.dart';

class SignUpController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  void signUp() {
    print(emailController.text);
    print(passwordController.text);
    print(cpfController.text);
    print(nameController.text);
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    cpfController.dispose();
    nameController.dispose();
  }
}
