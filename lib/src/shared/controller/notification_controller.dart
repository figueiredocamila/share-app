import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:share_app/config/exceptions/notification_exceptions.dart';
import 'package:share_app/config/shared_preferences/shared_pref.dart';
import 'package:share_app/src/shared/model/notification_model.dart';

class NotificationController {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final NotificationException notificationException = NotificationException();
  SharedPref sharedPref = SharedPref();
  static const String notification = '';
  static List<NotificationModel> sentNotification = [];
  static List<NotificationModel> recievedNotification = [];

  // NotificationModel msg1 = NotificationModel(
  //   body: "Olá! Só queria dizer que você é incrível. Tenha um dia maravilhoso!",
  //   title: 'Aventureiro21',
  // );

  // NotificationModel msg2 = NotificationModel(
  //   body:
  //       "Lembre-se de cuidar de si mesmo(a) hoje. Você merece um momento de descanso e autocuidado. Cuide-se!",
  //   title: 'SorrisoRadiante',
  // );

  // NotificationModel msg3 = NotificationModel(
  //   body:
  //       "Parabéns pelo seu novo emprego! Tenho certeza de que você vai arrasar. Estou torcendo por você!",
  //   title: 'SonhadorInspirado',
  // );

  List<NotificationModel> getSentNotification() {
    // sentNotification.add(msg1);
    // sentNotification.add(msg2);
    // sentNotification.add(msg3);
    return sentNotification;
  }

  List<NotificationModel> getRecievedNotification() {
    // recievedNotification.add(msg1);
    // recievedNotification.add(msg2);
    // recievedNotification.add(msg3);
    return recievedNotification;
  }

  Future<void> sendNotification(String body) async {
    var userId = await sharedPref.getUserId();
    var userName = await sharedPref.getUserName();
    var lat = await sharedPref.getLat();
    var lng = await sharedPref.getLng();

    if (body.isNotEmpty) {
      sentNotification.add(
        NotificationModel(
          body: body,
          title: userName,
          lat: lat,
          lng: lng,
          userId: userId,
        ),
      );
    }
  }

  static void dispose() {
    sentNotification.clear();
    recievedNotification.clear();
  }
}
