import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  final String body;
  final String title;

  MessageModel({
    required this.body,
    required this.title,
  });

  static MessageModel get empty => MessageModel(
        body: '',
        title: '',
      );

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
