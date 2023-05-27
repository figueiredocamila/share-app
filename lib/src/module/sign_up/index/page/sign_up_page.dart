// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:share_app/config/routes/app_routes.dart';
import 'package:share_app/config/shared_preferences/shared_pref.dart';
import 'package:share_app/src/module/sign_up/index/controller/sign_up_controller.dart';
import 'package:share_app/src/shared/controller/auth_controller.dart';
import 'package:share_app/src/shared/controller/loading_controller.dart';
import 'package:share_app/src/shared/widgets/text_field_email.dart';
import 'package:share_app/src/shared/widgets/text_field_name.dart';
import 'package:share_app/src/shared/widgets/text_field_password.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SignUpController signUpController = SignUpController();
  LoadingController loadingController = LoadingController();
  AuthController authController = AuthController();
  SharedPref sharedPref = SharedPref();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    signUpController.dispose();
    super.dispose();
  }

  Future<void> _submit(context) async {
    if (_formKey.currentState!.validate()) {
      try {
        loadingController.startLoading();

        await authController.signUp(
          signUpController.emailController.text,
          signUpController.passwordController.text,
          signUpController.nameController.text,
        );

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Colors.deepOrangeAccent,
          )),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(40.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                verticalDirection: VerticalDirection.down,
                children: [
                  Row(children: [
                    Text('DADOS PESSOAIS',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 14.0, color: Colors.black54))
                  ]),
                  SizedBox(height: 8),
                  TextFieldEmail(
                    controller: signUpController.emailController,
                    helperText: signUpController.helperText,
                  ),
                  SizedBox(height: 8),
                  TextFieldPassword(
                    controller: signUpController.passwordController,
                  ),
                  SizedBox(height: 8),
                  TextFieldName(
                    controller: signUpController.nameController,
                  ),
                  SizedBox(height: 34),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        loadingController.isLoading ? null : _submit(context);
                      },
                      style: loadingController.isLoading
                          ? ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey)
                          : ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrangeAccent),
                      child: loadingController.isLoading
                          ? Text('CRIANDO CONTA')
                          : Text('CRIAR CONTA'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
