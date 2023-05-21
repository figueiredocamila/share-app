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

  NotificationModel({
    required this.body,
    required this.title,
    this.lat,
    this.lng,
    this.userId,
    this.createdAt,
  });

  static NotificationModel get empty => NotificationModel(
        body: '',
        title: '',
      );

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
