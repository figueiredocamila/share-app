import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel {
  final double lat;
  final double lng;
  final String userId;
  final String fcmToken;

  LocationModel({
    required this.lat,
    required this.lng,
    required this.userId,
    required this.fcmToken,
  });

  static LocationModel get empty => LocationModel(
        lat: 0,
        lng: 0,
        userId: '',
        fcmToken: '',
      );

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);
  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
