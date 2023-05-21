import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const refreshToken = '_refreshToken';
  static const userId = '_userId';
  static const fcmToken = '_fcmToken';
  static const userName = '_userName';
  static const lat = '_lat';
  static const lng = '_lng';
  static const error = '_error';

  Future<String> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String userName = prefs.getString('userName') ?? '';

    return userName;
  }

  Future<void> setUserName(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('userName', userName);
  }

  Future<void> removeUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('userName');
  }

  Future<String> getFcmToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String fcmToken = prefs.getString('fcmToken') ?? '';

    return fcmToken;
  }

  Future<void> setFcmToken(String fcmToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('fcmToken', fcmToken);
  }

  Future<void> removeFcmToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('fcmToken');
  }

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String userId = prefs.getString('userId') ?? '';

    return userId;
  }

  Future<void> setUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('userId', userId);
  }

  Future<void> removeUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('userId');
  }

  Future<String> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String refreshToken = prefs.getString('refreshToken') ?? '';

    return refreshToken;
  }

  Future<void> setRefreshToken(String refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('refreshToken', refreshToken);
  }

  Future<void> removeRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('refreshToken');
  }

  Future<double> getLat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    double lat = prefs.getDouble('lat') ?? 0;

    return lat;
  }

  Future<void> setLat(double lat) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setDouble('lat', lat);
  }

  Future<void> removeLat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('lat');
  }

  Future<double> getLng() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    double lng = prefs.getDouble('lng') ?? 0;

    return lng;
  }

  Future<void> setLng(double lng) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setDouble('lng', lng);
  }

  Future<void> removeLng() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('lng');
  }

  Future<String> getError() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String error = prefs.getString('error') ?? '';

    return error;
  }

  Future<void> setError(String error) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('error', error);
  }

  Future<void> removeError() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('error');
  }

  Future<void> removeAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('userName');
    await prefs.remove('fcmToken');
    await prefs.remove('userId');
    await prefs.remove('refreshToken');
    await prefs.remove('lat');
    await prefs.remove('lng');
    await prefs.remove('error');
  }
}
