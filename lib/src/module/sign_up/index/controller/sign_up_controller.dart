import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  String signUpFeedback = '';
  bool isLoading = false;

  void setEmailAlreadyInUse(String message) {
    signUpFeedback = message;
  }

  void setIsLoading(status) {
    isLoading = status;
  }

  void signUp() async {
    try {
      setIsLoading(true);

      setEmailAlreadyInUse('');

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await userCredential.user?.updateDisplayName(nameController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        setEmailAlreadyInUse('Este e-mail já está em uso.');
      }
    } catch (e) {
      print(e);
      setEmailAlreadyInUse('Não foi possível cadastrar este usuário');
    } finally {
      setIsLoading(false);
      dispose();
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }
}
