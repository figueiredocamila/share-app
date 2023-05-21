import 'package:flutter/material.dart';

class TextFieldMessage extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSubmitted;

  const TextFieldMessage({
    super.key,
    required this.controller,
    required this.onSubmitted,
  });

  @override
  State<TextFieldMessage> createState() => _TextFieldMessageState();
}

class _TextFieldMessageState extends State<TextFieldMessage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: widget.controller,
            onSubmitted: (value) {
              widget.onSubmitted(value);
            },
            decoration: const InputDecoration(
              isDense: true,
              hintText: 'Digite uma mensagem',
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.deepOrangeAccent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.deepOrangeAccent,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
