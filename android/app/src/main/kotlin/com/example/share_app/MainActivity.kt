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

import android.Manifest
import android.content.pm.PackageManager
import androidx.core.content.ContextCompat
import androidx.core.app.ActivityCompat



class MainActivity: FlutterActivity() {
  private val CHANNEL_ID = "1:1014358974664:android:92efcf45fe35276291c5fd"
  private val CHANNEL_NAME = "share_app"
  private val CHANNEL_DESCRIPTION = "app de notificações"
  private val BACKGROUND_CHANNEL = "com.example.share_app/background"
  private val LOCATION_CHANNEL = "com.example.share_app/location"
  private val REQUEST_CODE_LOCATION_PERMISSION = 123
 

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
      val locationChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, LOCATION_CHANNEL)
        locationChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "startLocationService" -> {
                    if (checkLocationPermission()) {
                        startLocationService()
                        result.success(null)
                    } else {
                        requestLocationPermission()
                        result.error("PERMISSION_DENIED", "Location permission denied", null)
                    }
                }
                else -> result.notImplemented()
            }
        }

        val backgroundChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BACKGROUND_CHANNEL)
        backgroundChannel.setMethodCallHandler { call, result ->
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

      private fun checkLocationPermission(): Boolean {
        val permission = Manifest.permission.ACCESS_FINE_LOCATION
        val granted = PackageManager.PERMISSION_GRANTED
        return ContextCompat.checkSelfPermission(this, permission) == granted
    }

    private fun requestLocationPermission() {
        val permission = Manifest.permission.ACCESS_FINE_LOCATION
        ActivityCompat.requestPermissions(this, arrayOf(permission), REQUEST_CODE_LOCATION_PERMISSION)
    }

    private fun startLocationService() {
        val serviceIntent = LocationService.newIntent(this)
        startService(serviceIntent)
    }
}
