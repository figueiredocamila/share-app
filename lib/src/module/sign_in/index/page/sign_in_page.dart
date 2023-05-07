// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:share_app/config/routes/app_routes.dart';
import 'package:share_app/src/module/sign_in/index/controller/sign_in_controller.dart';
import 'package:share_app/src/shared/widgets/button_google_login.dart';
import 'package:share_app/src/shared/widgets/text_field_email.dart';
import 'package:share_app/src/shared/widgets/text_field_password.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  SignInController signInController = SignInController();
  AppRoutes appRoutes = AppRoutes();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    signInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.attractions_outlined,
                    color: Colors.deepOrangeAccent,
                    size: 60.0,
                  ),
                  Text.rich(TextSpan(
                      text: 'SHARE',
                      style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.deepOrangeAccent,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: 'app.',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.deepOrangeAccent,
                          ),
                        )
                      ]))
                ],
              ),
              SizedBox(height: 54),
              Row(children: [
                Text('FAÇA LOGIN E ACESSE SUA CONTA',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 14.0, color: Colors.black54))
              ]),
              SizedBox(height: 8),
              TextFieldEmail(
                  controller: signInController.emailController, helperText: ''),
              SizedBox(height: 8),
              TextFieldPassword(
                  controller: signInController.passwordController),
              SizedBox(height: 14),
              Row(children: [
                Text.rich(TextSpan(
                    text: 'Esqueceu sua senha?',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => signInController.resetPassword(),
                    style: TextStyle(fontSize: 12.0, color: Colors.black54)))
              ]),
              SizedBox(height: 34),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    signInController.signIn(context);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepOrangeAccent)),
                  child: Text('ENTRAR'),
                ),
              ),
              SizedBox(height: 24),
              Text('OU',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14.0, color: Colors.black54)),
              SizedBox(height: 24),
              GoogleSignInButton(
                onPressed: () {
                  signInController.signInWithGoogle(context);
                },
              ),
              SizedBox(height: 44),
              Row(children: [
                Text.rich(
                  TextSpan(
                    text: 'PRECISA DE UMA CONTA? ',
                    style: TextStyle(fontSize: 14.0, color: Colors.black54),
                    children: [
                      TextSpan(
                        text: 'CADASTRE-SE',
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () => signInController.goToSignUpPage(context),
                        style: TextStyle(
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ],
          ),
        ));
  }
}
