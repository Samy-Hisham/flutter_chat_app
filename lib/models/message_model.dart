import 'package:chat_app/helpers/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final Timestamp createdAt;
  final String id;

  MessageModel({
    required this.createdAt,
    required this.id,
    required this.message,
  });

  factory MessageModel.fromJson(json) {
    return MessageModel(
      message: json[Helpers.KMessage],
      id: json['id'],
      createdAt: json['createdAt'],
    );
  }
}
