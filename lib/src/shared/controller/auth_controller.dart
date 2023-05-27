import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:share_app/config/exceptions/auth_exceptions.dart';
import 'package:share_app/config/shared_preferences/shared_pref.dart';
import 'package:share_app/src/shared/controller/error_controller.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final SharedPref sharedPref = SharedPref();
  final AuthException authException = AuthException();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      debugPrint('usuario google: $googleUser');

      if (googleUser == null) {
        throw authException.unableSignIn();
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);

      signIn();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw authException.userNotFound();
      } else if (e.code == 'wrong-password') {
        throw authException.wrongPassword();
      }
      throw authException.unableSignIn();
    } catch (e) {
      await sharedPref.setError(e.toString());
      debugPrint(e.toString());
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      if (_auth.currentUser != null) {
        await signIn();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw authException.userNotFound();
      } else if (e.code == 'wrong-password') {
        throw authException.wrongPassword();
      }
      throw authException.unableSignIn();
    } catch (e) {
      await sharedPref.setError(e.toString());
      debugPrint(e.toString());
    }
  }

  Future<void> signIn() async {
    await sharedPref.removeError();
    sharedPref.setUserId(_auth.currentUser?.uid ?? '');
    sharedPref.setUserName(_auth.currentUser?.displayName ?? '');
  }

  Future<void> signUp(String email, String password, String displayName) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(displayName);
      await sharedPref.removeError();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ErrorController.setError(authException.emailAlreadyInUse());
        throw authException.emailAlreadyInUse();
      }
      throw authException.unableSignUp();
    } catch (e) {
      await sharedPref.setError(e.toString());
      debugPrint(e.toString());
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
      await sharedPref.removeAll();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void isLoggedIn() {
    try {
      if (_auth.currentUser != null) {
        debugPrint('User is signed in!');
      } else {
        debugPrint('User is signed out!');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void resetPassword(String email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
