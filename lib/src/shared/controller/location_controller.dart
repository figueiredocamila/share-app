import 'dart:async';
import 'package:location/location.dart';
import 'package:share_app/config/shared_preferences/shared_pref.dart';
import 'package:share_app/src/shared/client/location/location_client.dart';
import 'package:workmanager/workmanager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationController {
  final Location location = Location();
  final Workmanager workmanager = Workmanager();
  final SharedPref sharedPref = SharedPref();

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();

      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();

    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();

      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    LocationData locationData = await location.getLocation();

    double latitude = locationData.latitude!;
    double longitude = locationData.longitude!;

    sendLocation(latitude, longitude);
  }

  Future<int> getNextTaskId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int lastTaskId = prefs.getInt('getCurrentlocationId') ?? 0;
    int nextTaskId = lastTaskId + 1;

    await prefs.setInt('getCurrentlocationId', nextTaskId);

    return nextTaskId;
  }

  void callbackDispatcher() {
    workmanager.executeTask((task, inputData) {
      switch (task) {
        case 'getCurrentlocation':
          getCurrentLocation();
          break;
      }

      return Future.value(true);
    });
  }

  void registerBackgroundTask() async {
    int getCurrentlocationId = await getNextTaskId();

    workmanager.initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );

    workmanager.registerPeriodicTask(
      getCurrentlocationId.toString(),
      'getCurrentlocation',
      frequency: const Duration(minutes: 2),
    );
  }

  void sendLocation(latitude, longitude) async {
    var fcmToken = await sharedPref.getFcmToken();
    var userId = await sharedPref.getUserId();

    try {
      await LocationClient.repository.sendLocation(
        latitude,
        longitude,
        fcmToken,
        userId,
      );
    } catch (e) {
      print(e);
    }
  }
}
