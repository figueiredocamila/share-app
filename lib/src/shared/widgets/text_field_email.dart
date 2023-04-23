import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class TextFieldEmail extends StatefulWidget {
  final TextEditingController controller;

  const TextFieldEmail({super.key, required this.controller});

  @override
  State<TextFieldEmail> createState() => _TextFieldEmailState();
}

class _TextFieldEmailState extends State<TextFieldEmail> {
  bool _isEmailValid = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onChange() {
    setState(() {
      _isEmailValid = EmailValidator.validate(widget.controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: widget.controller,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'E-MAIL',
        labelStyle: const TextStyle(fontSize: 12.0, color: Colors.black54),
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.deepOrangeAccent,
        )),
        errorText: _isEmailValid ? null : 'Email inválido',
      ),
      onChanged: (value) => _onChange(),
    );
  }
}
