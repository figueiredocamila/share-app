// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      body: json['body'] as String,
      title: json['title'] as String,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      userId: json['userId'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'body': instance.body,
      'title': instance.title,
      'lat': instance.lat,
      'lng': instance.lng,
      'userId': instance.userId,
      'createdAt': instance.createdAt,
    };
