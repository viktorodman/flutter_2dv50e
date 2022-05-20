import 'dart:convert';
import 'package:meta/meta.dart';

Device deviceFromJson(String str) => Device.fromJson(json.decode(str));

String deviceToJson(Device data) => json.encode(data.toJson());

class Device {
  Device({
    required this.id,
    required this.uuid,
    required this.devEui,
    required this.devaddr,
    required this.name,
    required this.downlinkUrl,
    required this.created,
    required this.updated,
    required this.label,
    required this.labelTwo,
    required this.lat,
    required this.lng,
    required this.description,
    required this.deviceType,
  });

  final String id;
  final String uuid;
  final String devEui;
  final String devaddr;
  final String name;
  final String downlinkUrl;
  final DateTime created;
  final DateTime updated;
  final String label;
  final String labelTwo;
  final String? description;
  final String? deviceType;
  final double? lat;
  final double? lng;

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        id: json["id"],
        uuid: json["uuid"],
        devEui: json["dev_eui"],
        devaddr: json["devaddr"],
        name: json["name"],
        downlinkUrl: json["downlink_url"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        label: json["label"],
        labelTwo: json["label_two"],
        description: json["description"].runtimeType == String
            ? json["description"]
            : null,
        deviceType: json["deviceType"].runtimeType == String
            ? json["deviceType"]
            : null,
        lat: json["lat"].runtimeType == String
            ? double.parse(json["lat"])
            : null,
        lng: json["lng"].runtimeType == String
            ? double.parse(json["lng"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uuid": uuid,
        "dev_eui": devEui,
        "devaddr": devaddr,
        "name": name,
        "downlink_url": downlinkUrl,
        "created": created.toIso8601String(),
        "updated": updated.toIso8601String(),
        "label": label,
        "label_two": labelTwo,
        "description": description == null ? null : description,
        "deviceType": deviceType == null ? null : deviceType,
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
      };
}
