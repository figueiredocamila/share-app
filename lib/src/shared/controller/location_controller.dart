import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:share_app/config/shared_preferences/shared_pref.dart';
import 'package:share_app/src/shared/client/location/location_client.dart';
import 'package:workmanager/workmanager.dart';

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

  static void callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      await LocationController().getCurrentLocation();

      return Future.value(true);
    });
  }

  static void registerBackgroundTask() async {
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );

    Workmanager().registerOneOffTask(
      "1",
      'getCurrentLocation',
      initialDelay: const Duration(minutes: 2),
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresCharging: true,
      ),
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
      debugPrint(e.toString());
    }
  }
}
