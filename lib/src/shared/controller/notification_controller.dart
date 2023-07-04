import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:share_app/config/exceptions/notification_exceptions.dart';
import 'package:share_app/config/shared_preferences/shared_pref.dart';
import 'package:share_app/src/shared/model/notification_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

abstract class NotificationController {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  static const String notification = '';
  static List<NotificationModel> sentNotification = [];
  static List<NotificationModel> recievedNotification = [];

  static Future<List<NotificationModel>> getSentNotification() async {
    try {
      var userId = await SharedPref().getUserId();

      final url = Uri.parse(
          'https://us-central1-share-app-mobile.cloudfunctions.net/getSentNotifications');

      print(userId);

      final response = await http.post(url, body: {
        'userId': userId,
      });

      if (response.statusCode != 200) {
        throw NotificationException().notificationNotFount();
      }

      return jsonDecode(response.body)
          .map<NotificationModel>((json) => NotificationModel.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<List<NotificationModel>> getRecievedNotification() async {
    try {
      var userId = await SharedPref().getUserId();

      final url = Uri.parse(
          'https://us-central1-share-app-mobile.cloudfunctions.net/getNotifications');

      final response = await http.post(url, body: {
        'userId': userId,
      });

      if (response.statusCode != 200) {
        throw NotificationException().notificationNotFount();
      }

      return jsonDecode(response.body)
          .map<NotificationModel>((json) => NotificationModel.fromJson(json))
          .toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  static Future<void> sendNotification(
      String body, BuildContext context) async {
    if (body.isNotEmpty) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        var userId = await SharedPref().getUserId();
        var userName = await SharedPref().getUserName();
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
          throw NotificationException();
        }
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
