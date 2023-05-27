import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_app/config/environment/environment.dart';

bool isDebug = false;

Future<Map<String, String>> getHeaderDefault() async {
  final currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    final idToken = await currentUser.getIdToken();
    return {
      'Authorization': idToken,
      'Platform': Platform.isIOS ? 'iOS' : 'Android',
    };
  }
  return {};
}

Future getEnvironment() async {
  debugPrint(' url $Environment.baseUrl');
  return Environment.baseUrl;
}

Future<BaseOptions> getOptions() async {
  return BaseOptions(
    baseUrl: await getEnvironment(),
    // headers: await getHeaderDefault(),
    receiveTimeout: const Duration(seconds: 15),
    sendTimeout: const Duration(seconds: 15),
    connectTimeout: const Duration(seconds: 15),
  );
}

Dio getDioInstanceLogged() {
  final Dio client = Dio();

  client.interceptors.add(LogInterceptor(
      requestBody: isDebug,
      responseBody: isDebug,
      requestHeader: isDebug,
      responseHeader: isDebug,
      request: isDebug));

  client.interceptors.add(AppInterceptors());

  return client;
}

class AppInterceptors extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var optionsHeader = await getOptions();
    options.headers = optionsHeader.headers;
    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }
}
