import 'package:flutter/material.dart';
import 'package:share_app/src/shared/model/message_model.dart';
import 'package:share_app/src/shared/widgets/card_message.dart';

class ListMessage extends StatefulWidget {
  final List<MessageModel> messages;

  const ListMessage({super.key, required this.messages});

  @override
  State<ListMessage> createState() => _ListMessageState();
}

class _ListMessageState extends State<ListMessage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: widget.messages.length,
      separatorBuilder: (context, index) => const SizedBox(height: 6.0),
      itemBuilder: (context, index) {
        return CardMessage(message: widget.messages[index]);
      },
    );
  }
}
