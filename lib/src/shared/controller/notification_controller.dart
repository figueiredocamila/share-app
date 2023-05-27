// ignore_for_file: use_build_context_synchronously

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
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

  Future<void> sendNotification(String body, BuildContext context) async {
    if (body.isNotEmpty) {
      try {
        var userId = await sharedPref.getUserId();
        var userName = await sharedPref.getUserName();
        var lat = 0.0;
        var lng = 0.0;

        debugPrint('User ID: $userId');
        debugPrint('User Name: $userName');
        debugPrint('Lat: $lat');
        debugPrint('Lng: $lng');
        debugPrint('Body: $body');

        // Provider.of<NotificationService>(context, listen: false)
        //     .showNotification(
        //   NotificationModel(body: body, title: userName, lat: lat, lng: lng),
        // );

        // final url = Uri.parse(
        //     'https://us-central1-share-app-mobile.cloudfunctions.net/saveNotification');

        // final response = await http.post(url, body: {
        //   'lat': lat.toString(),
        //   'lng': lng.toString(),
        //   'userId': userId,
        //   'title': userName,
        //   'body': body,
        // });

        // if (response.statusCode == 200) {
        //   // Sucesso na solicitação de POST
        //   debugPrint('Solicitação de POST bem-sucedida');
        // } else {
        //   // Erro na solicitação de POST
        //   debugPrint(
        //       'Erro na solicitação de POST. Código de status: ${response.statusCode}');
        // }

        // sentNotification.add(
        //   NotificationModel(
        //     body: body,
        //     title: userName,
        //     lat: lat,
        //     lng: lng,
        //     userId: userId,
        //   ),
        // );
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  static void dispose() {
    sentNotification.clear();
    recievedNotification.clear();
  }
}
