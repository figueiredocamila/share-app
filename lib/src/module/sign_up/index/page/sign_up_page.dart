// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:share_app/src/module/sign_up/index/controller/sign_up_controller.dart';
import 'package:share_app/src/shared/widgets/text_field_cpf.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    signUpController.dispose();
    super.dispose();
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
              ),
              SizedBox(height: 8),
              TextFieldPassword(
                controller: signUpController.passwordController,
              ),
              SizedBox(height: 8),
              TextFieldName(
                controller: signUpController.nameController,
              ),
              SizedBox(height: 8),
              TextFieldCPF(
                controller: signUpController.cpfController,
              ),
              SizedBox(height: 34),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    signUpController.signUp();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepOrangeAccent)),
                  child: Text('CRIAR CONTA'),
                ),
              ),
            ],
          ),
        ));
  }
}
