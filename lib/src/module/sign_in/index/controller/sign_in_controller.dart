import 'package:flutter/material.dart';
import 'package:share_app/src/module/sign_up/index/page/sign_up_page.dart';

class SignInController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void signIn() {
    print(emailController.text);
    print(passwordController.text);
  }

  void goToSignUpPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      ),
    );
  }

  void resetPassword() {}

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
