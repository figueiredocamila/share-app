import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

class TextFieldPassword extends StatefulWidget {
  final TextEditingController controller;

  const TextFieldPassword({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<TextFieldPassword> createState() => _TextFieldPasswordState();
}

class _TextFieldPasswordState extends State<TextFieldPassword> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      validator: (value) {
        if (isNull(value) || value!.isEmpty) {
          return 'Este campo é obrigatório';
        }
        if (value.length < 8) {
          return 'A senha deve possuir pelo menos 8 caracteres';
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: 'SENHA',
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey[600],
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
          labelStyle: const TextStyle(fontSize: 12.0, color: Colors.black54),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.deepOrangeAccent,
          ))),
    );
  }
}
