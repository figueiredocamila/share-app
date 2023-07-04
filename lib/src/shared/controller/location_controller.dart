import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:share_app/config/shared_preferences/shared_pref.dart';
import 'package:http/http.dart' as http;

abstract class GeolocationService {
  static Future<void> sendLocationData() async {
    try {
      await getLocation();
      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

      var fcmToken = await firebaseMessaging.getToken();
      var userId = await SharedPref().getUserId();
      var userName = await SharedPref().getUserName();
      var lat = await SharedPref().getLat();
      var lng = await SharedPref().getLng();

      debugPrint('User ID: $userId');
      debugPrint('fcmToken: $fcmToken');
      debugPrint('Lat: $lat');
      debugPrint('Lng: $lng');
      debugPrint('Name: $userName');

      final url = Uri.parse(
          'https://us-central1-share-app-mobile.cloudfunctions.net/saveUserLocation');

      final response = await http.post(url, body: {
        'uid': userId,
        'lat': lat.toString(),
        'lng': lng.toString(),
        'fcmToken': fcmToken,
        'name': userName,
      });

      if (response.statusCode != 200) {
        throw Exception('Failed to send location');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      var lat = position.latitude;
      var lng = position.longitude;

      SharedPref().setLat(lat);
      SharedPref().setLng(lng);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
