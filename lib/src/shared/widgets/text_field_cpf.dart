import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

class TextFieldCPF extends StatefulWidget {
  final TextEditingController controller;

  const TextFieldCPF({
    super.key,
    required this.controller,
  });

  @override
  State<TextFieldCPF> createState() => _TextFieldCPFState();
}

class _TextFieldCPFState extends State<TextFieldCPF> {
  bool _validate = false;

  String _formatCPF(String cpf) {
    return cpf.replaceAllMapped(
      RegExp(r'^(\d{3})(\d{3})(\d{3})(\d{2})$'),
      (Match m) => '${m[1]}.${m[2]}.${m[3]}-${m[4]}',
    );
  }

  bool _validateCPF(String cpf) {
    return CPFValidator.isValid(cpf);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      autofocus: false,
      textCapitalization: TextCapitalization.none,
      enableSuggestions: false,
      decoration: InputDecoration(
          labelText: 'CPF',
          hintText: '000.000.000-00',
          helperText: 'Digite apenas os números',
          errorText: _validate ? 'Por favor, digite um CPF válido.' : null,
          labelStyle: const TextStyle(fontSize: 12.0, color: Colors.black54),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.deepOrangeAccent,
          ))),
      onChanged: (value) {
        String cpf = value.replaceAll(RegExp(r'[^\d]'), '');
        bool isValid = _validateCPF(cpf);
        setState(() {
          _validate = !isValid;
        });
        if (isValid) {
          widget.controller.text = _formatCPF(cpf);
          widget.controller.selection = TextSelection.fromPosition(
              TextPosition(offset: widget.controller.text.length));
        }
      },
    );
  }
}
