// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:share_app/src/shared/model/message_model.dart';

class CardMessage extends StatelessWidget {
  final MessageModel message;

  const CardMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    message.title,
                    style: TextStyle(
                        fontSize: 14.0, color: Colors.deepOrangeAccent),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  message.body,
                  style: TextStyle(fontSize: 16.0),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
