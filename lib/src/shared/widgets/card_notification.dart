import 'package:flutter/material.dart';
import 'package:share_app/src/shared/model/notification_model.dart';

class CardNotification extends StatelessWidget {
  final NotificationModel notification;

  const CardNotification({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    notification.title,
                    style: const TextStyle(
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
                  notification.body,
                  style: const TextStyle(fontSize: 16.0),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
