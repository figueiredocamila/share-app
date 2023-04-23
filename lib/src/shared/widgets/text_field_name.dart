import 'package:flutter/material.dart';

class TextFieldName extends StatelessWidget {
  final TextEditingController controller;

  const TextFieldName({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
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
