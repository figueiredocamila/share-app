import 'package:flutter/material.dart';
import 'package:share_app/config/shared_preferences/shared_pref.dart';
import 'package:http/http.dart' as http;

abstract class GeolocationService {
  static void sendLocationData(location) async {
    if (location == null) {
      return;
    }

    try {
      var fcmToken = await SharedPref().getFcmToken();
      var userId = await SharedPref().getUserId();
      var userName = await SharedPref().getUserName();

      debugPrint('User ID: $userId');
      debugPrint('fcmToken: $fcmToken');
      debugPrint('Lat: ${location.latitude}');
      debugPrint('Lng: ${location.longitude}');

      final url = Uri.parse(
          'https://us-central1-share-app-mobile.cloudfunctions.net/saveUserLocation');

      final response = await http.post(url, body: {
        'uid': userId,
        'lat': location.latitude.toString(),
        'lng': location.longitude.toString(),
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
}
