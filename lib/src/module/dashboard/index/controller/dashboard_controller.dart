import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_app/src/shared/controller/message_controller.dart';

class DashboardController {
  final MessageController receivedMessagesController = MessageController();
  final MessageController sentMessagesController = MessageController();

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
