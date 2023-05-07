import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:share_app/config/exceptions/auth_exceptions.dart';
import 'package:share_app/src/module/dashboard/index/page/dashboard_page.dart';
import 'package:share_app/src/module/sign_up/index/page/sign_up_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthException authException = AuthException();

  String helperText = '';

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  void setHelperText(String message) {
    helperText = message;
  }

  void signInWithGoogle(context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      signIn();

      if (userCredential.user != null) {
        goToDashboardPage(context);
      }
    } catch (e) {
      print(e);
    }
  }

  void signInWithEmailAndPassword(context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      signIn();

      if (userCredential.user != null) {
        goToDashboardPage(context);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setHelperText(authException.userNotFound());
      } else if (e.code == 'wrong-password') {
        setHelperText(authException.wrongPassword());
      }
    }
  }

  void signIn() async {
    try {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      var fcmToken = await messaging.getToken();

      if (fcmToken != null && fcmToken != '') {
        print('Token: $fcmToken');
      }
    } catch (e) {
      print(e);
    }
  }

  void goToDashboardPage(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const DashboardPage()));
  }

  void goToSignUpPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      ),
    );
  }

  void isLoggedIn() {
    try {
      if (_auth.currentUser != null) {
        print('User is signed in!');
      } else {
        print('User is signed out!');
      }
    } catch (e) {
      print(e);
    } finally {
      dispose();
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void resetPassword() {
    FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
  }
}
