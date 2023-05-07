import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class TextFieldName extends StatelessWidget {
  final TextEditingController controller;

  const TextFieldName({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      validator: (value) {
        final RegExp regex = RegExp(r'^[a-zA-ZÀ-ú ]+$');
        if (isNull(value) || value!.isEmpty) {
          return 'Este campo é obrigatório';
        }
        if (value.trim().split(' ').length < 2) {
          return 'Por favor, insira seu nome completo';
        }
        if (!regex.hasMatch(value)) {
          return 'Este campo não pode conter números ou caracteres especiais';
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: 'NOME COMPLETO',
          labelStyle: TextStyle(fontSize: 12.0, color: Colors.black54),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.deepOrangeAccent,
          ))),
    );
  }
}
