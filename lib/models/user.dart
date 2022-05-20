import 'package:meta/meta.dart';
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.token,
    required this.username,
    required this.id,
  });

  final String token;
  final String username;
  final String id;

  factory User.fromJson(Map<String, dynamic> json) => User(
        token: json["token"] == null ? null : json["token"],
        username: json["username"] == null ? null : json["username"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "token": token == null ? null : token,
        "username": username == null ? null : username,
        "id": id == null ? null : id,
      };
}
