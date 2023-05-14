import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const refreshToken = '_refreshToken';
  static const userId = '_userId';
  static const fcmToken = '_fcmToken';
  static const token = '_token';

  Future<String> getFcmToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String fcmToken = prefs.getString('fcmToken') ?? '';

    return fcmToken;
  }

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String userId = prefs.getString('userId') ?? '';

    return userId;
  }

  Future<String> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String refreshToken = prefs.getString('refreshToken') ?? '';

    return refreshToken;
  }

  Future<void> setFcmToken(String fcmToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('fcmToken', fcmToken);
  }

  Future<void> setUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('userId', userId);
  }

  Future<void> setRefreshToken(String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('refreshToken', refreshToken);
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '';

    return token;
  }

  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('token', token);
  }
}
