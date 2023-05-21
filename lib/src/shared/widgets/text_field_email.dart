import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:validators/validators.dart';

class TextFieldEmail extends StatefulWidget {
  final TextEditingController controller;
  final String helperText;

  const TextFieldEmail(
      {super.key, required this.controller, required this.helperText});

  @override
  State<TextFieldEmail> createState() => _TextFieldEmailState();
}

class _TextFieldEmailState extends State<TextFieldEmail> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (isNull(value) || value!.isEmpty) {
          return 'Este campo é obrigatório';
        }
        if (!EmailValidator.validate(value)) {
          return 'Digite um e-mail válido';
        }
        if (value.length > 50) {
          return 'Este campo deve ter no máximo 50 caracteres';
        }
        if (widget.helperText.isNotEmpty) {
          return widget.helperText;
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'E-MAIL',
        labelStyle: TextStyle(fontSize: 12.0, color: Colors.black54),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.deepOrangeAccent,
        )),
      ),
    );
  }
}
