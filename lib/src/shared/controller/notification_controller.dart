import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:share_app/config/exceptions/notification_exceptions.dart';
import 'package:share_app/config/shared_preferences/shared_pref.dart';
import 'package:share_app/src/shared/model/notification_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class NotificationController {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final NotificationException notificationException = NotificationException();
  SharedPref sharedPref = SharedPref();
  static const String notification = '';
  static List<NotificationModel> sentNotification = [];
  static List<NotificationModel> recievedNotification = [];

  List<NotificationModel> getSentNotification() {
    return sentNotification;
  }

  List<NotificationModel> getRecievedNotification() {
    return recievedNotification;
  }

  Future<void> sendNotification(String body, BuildContext context) async {
    if (body.isNotEmpty) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        var userId = await sharedPref.getUserId();
        var userName = await sharedPref.getUserName();
        var lat = position.latitude;
        var lng = position.longitude;

        final url = Uri.parse(
            'https://us-central1-share-app-mobile.cloudfunctions.net/saveNotification');

        final response = await http.post(url, body: {
          'lat': lat.toString(),
          'lng': lng.toString(),
          'userId': userId,
          'title': userName,
          'body': body,
        });

        if (response.statusCode != 200) {
          throw notificationException;
        }

        sentNotification.add(
          NotificationModel(
            body: body,
            title: userName,
            lat: lat,
            lng: lng,
            userId: userId,
          ),
        );
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
