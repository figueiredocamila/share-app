import 'package:flutter/material.dart';
import 'package:share_app/src/shared/model/notification_model.dart';
import 'package:share_app/src/shared/widgets/card_notification.dart';

class ListMessage extends StatefulWidget {
  final List<NotificationModel> notifications;

  const ListMessage({super.key, required this.notifications});

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
      itemCount: widget.notifications.length,
      separatorBuilder: (context, index) => const SizedBox(height: 6.0),
      itemBuilder: (context, index) {
        return CardNotification(notification: widget.notifications[index]);
      },
    );
  }
}
