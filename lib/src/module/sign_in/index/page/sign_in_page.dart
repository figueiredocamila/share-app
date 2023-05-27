// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:share_app/config/routes/app_routes.dart';
import 'package:share_app/config/shared_preferences/shared_pref.dart';
import 'package:share_app/src/module/sign_in/index/controller/sign_in_page_controller.dart';
import 'package:share_app/src/shared/controller/auth_controller.dart';
import 'package:share_app/src/shared/controller/loading_controller.dart';
import 'package:share_app/src/shared/widgets/button_google_login.dart';
import 'package:share_app/src/shared/widgets/text_field_email.dart';
import 'package:share_app/src/shared/widgets/text_field_password.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  SignInPageController signInPageController = SignInPageController();
  AuthController authController = AuthController();
  LoadingController loadingController = LoadingController();
  SharedPref sharedPref = SharedPref();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    signInPageController.dispose();
    loadingController.dispose();
    super.dispose();
  }

  Future<void> _submit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        loadingController.startLoading();

        await authController.signInWithEmailAndPassword(
            signInPageController.emailController.text,
            signInPageController.passwordController.text);

        final erro = await sharedPref.getError();

        if (erro.isNotEmpty) {
          throw erro;
        }

        Navigator.pushNamed(context, AppRoutes.dashboard);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } finally {
        loadingController.stopLoading();
      }
    }
  }

  Future<void> _submitWithGoogle(BuildContext context) async {
    try {
      loadingController.startLoading();

      await authController.signInWithGoogle();

      final erro = await sharedPref.getError();

      if (erro.isNotEmpty) {
        throw erro;
      }

      Navigator.pushNamed(context, AppRoutes.dashboard);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      loadingController.stopLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.attractions_outlined,
                  color: Colors.deepOrangeAccent,
                  size: 60.0,
                ),
                Text.rich(
                  TextSpan(
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
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 54),
            Row(children: const [
              Text('FAÇA LOGIN E ACESSE SUA CONTA',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 14.0, color: Colors.black54))
            ]),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: [
                  Row(children: const [
                    Text('DADOS PESSOAIS',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 14.0, color: Colors.black54))
                  ]),
                  const SizedBox(height: 8),
                  TextFieldEmail(
                      controller: signInPageController.emailController,
                      helperText: ''),
                  const SizedBox(height: 8),
                  TextFieldPassword(
                    controller: signInPageController.passwordController,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            // Row(children: [
            //   Text.rich(TextSpan(
            //       text: 'Esqueceu sua senha?',
            //       recognizer: TapGestureRecognizer()
            //         ..onTap = () => signInController.resetPassword(),
            //       style: TextStyle(fontSize: 12.0, color: Colors.black54)))
            // ]),
            const SizedBox(height: 34),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  loadingController.isLoading ? null : _submit(context);
                },
                style: loadingController.isLoading
                    ? ElevatedButton.styleFrom(backgroundColor: Colors.grey)
                    : ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent),
                child: loadingController.isLoading
                    ? const Text('ENTRANDO')
                    : const Text('ENTRAR'),
              ),
            ),
            const SizedBox(height: 24),
            const Text('OU',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14.0, color: Colors.black54)),
            const SizedBox(height: 24),
            GoogleSignInButton(
              onPressed: () {
                loadingController.isLoading ? null : _submitWithGoogle(context);
              },
            ),
            const SizedBox(height: 44),
            Row(
              children: [
                Text.rich(
                  TextSpan(
                    text: 'PRECISA DE UMA CONTA? ',
                    style:
                        const TextStyle(fontSize: 14.0, color: Colors.black54),
                    children: [
                      TextSpan(
                        text: 'CADASTRE-SE',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () =>
                              Navigator.pushNamed(context, AppRoutes.signUp),
                        style: const TextStyle(
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
