package com.example.share_app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingBackgroundService
import android.content.Intent

import io.flutter.plugins.GeneratedPluginRegistrant

import android.os.Bundle

import android.os.Build
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.content.ContextWrapper


class MainActivity: FlutterActivity() {
  private val CHANNEL_ID = "1:1014358974664:android:92efcf45fe35276291c5fd"
  private val CHANNEL_NAME = "share_app"
  private val CHANNEL_DESCRIPTION = "app de notificações"
  private val BACKGROUND_CHANNEL = "com.example.share_app/background"
 

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    createNotificationChannel()
  }

  private fun createNotificationChannel() {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
      val channel = NotificationChannel(
        CHANNEL_ID,
        CHANNEL_NAME,
        NotificationManager.IMPORTANCE_HIGH
      )
      channel.description = CHANNEL_DESCRIPTION

      val notificationManager =
        getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
      notificationManager.createNotificationChannel(channel)
    }
  }

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
      super.configureFlutterEngine(flutterEngine)
      MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BACKGROUND_CHANNEL).setMethodCallHandler { call, result ->
          if (call.method == "startBackgroundIsolate") {
              val intent = Intent(this, FlutterFirebaseMessagingBackgroundService::class.java)
              intent.putExtra("flutter_background_action", call.arguments.toString())
              if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                startForegroundService(intent)
              } else {
                startService(intent)
              }
          }
      }
  }
}
