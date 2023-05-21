// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:share_app/src/module/sign_up/index/controller/sign_up_controller.dart';
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

  void _submit(context) {
    if (_formKey.currentState!.validate()) {
      signUpController.signUp(context);
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
                        signUpController.isLoading ? null : _submit(context);
                      },
                      style: signUpController.isLoading
                          ? ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey)
                          : ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrangeAccent),
                      child: signUpController.isLoading
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
