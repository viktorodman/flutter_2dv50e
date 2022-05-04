import 'package:meta/meta.dart';
import 'dart:convert';

TestThing testThingFromJson(String str) => TestThing.fromJson(json.decode(str));

String testThingToJson(TestThing data) => json.encode(data.toJson());

class TestThing {
  TestThing({
    required this.deviceName,
    required this.lat,
    required this.lng,
    required this.id,
  });

  final String deviceName;
  final double lat;
  final double lng;
  final String id;

  factory TestThing.fromJson(Map<String, dynamic> json) => TestThing(
        deviceName: json["deviceName"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "deviceName": deviceName,
        "lat": lat,
        "lng": lng,
        "id": id,
      };
}
