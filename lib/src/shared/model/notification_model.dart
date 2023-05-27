import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  final String body;
  final String title;
  final double? lat;
  final double? lng;
  final String? userId;
  final String? createdAt;
  final int? id;

  NotificationModel({
    required this.body,
    required this.title,
    this.lat,
    this.lng,
    this.userId,
    this.createdAt,
    this.id,
  });

  static NotificationModel get empty => NotificationModel(
        body: '',
        title: '',
        lat: 0,
        lng: 0,
        userId: '',
        createdAt: '',
        id: 0,
      );

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
