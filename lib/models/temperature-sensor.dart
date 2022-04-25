import 'package:meta/meta.dart';
import 'dart:convert';

List<TemperatureSensor> temperatureSensorFromJson(String str) =>
    List<TemperatureSensor>.from(
        json.decode(str).map((x) => TemperatureSensor.fromJson(x)));

String temperatureSensorToJson(List<TemperatureSensor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TemperatureSensor {
  TemperatureSensor({
    required this.id,
    required this.deviceId,
    required this.type,
    required this.payload,
    required this.decodedPayload,
    required this.batteryPercent,
    required this.batteryVolt,
    required this.created,
  });

  final int id;
  final String deviceId;
  final String type;
  final String payload;
  final DecodedPayload decodedPayload;
  final dynamic batteryPercent;
  final double batteryVolt;
  final DateTime created;

  factory TemperatureSensor.fromJson(Map<String, dynamic> json) =>
      TemperatureSensor(
        id: json["id"],
        deviceId: json["device_id"],
        type: json["type"],
        payload: json["payload"],
        decodedPayload: DecodedPayload.fromJson(json["decoded_payload"]),
        batteryPercent: json["battery_percent"],
        batteryVolt: json["battery_volt"].toDouble(),
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "device_id": deviceId,
        "type": type,
        "payload": payload,
        "decoded_payload": decodedPayload.toJson(),
        "battery_percent": batteryPercent,
        "battery_volt": batteryVolt,
        "created": created.toIso8601String(),
      };
}

class DecodedPayload {
  DecodedPayload({
    required this.extSensor,
    required this.humSht,
    required this.tempCDs,
    required this.tempCSht,
    required this.batteryStatus,
    required this.batteryVolt,
  });

  final String extSensor;
  final double humSht;
  final double tempCDs;
  final double tempCSht;
  final int batteryStatus;
  final double batteryVolt;

  factory DecodedPayload.fromJson(Map<String, dynamic> json) => DecodedPayload(
        extSensor: json["Ext_sensor"],
        humSht: json["Hum_SHT"].toDouble(),
        tempCDs: json["TempC_DS"].toDouble(),
        tempCSht: json["TempC_SHT"].toDouble(),
        batteryStatus: json["battery_status"],
        batteryVolt: json["battery_volt"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "Ext_sensor": extSensor,
        "Hum_SHT": humSht,
        "TempC_DS": tempCDs,
        "TempC_SHT": tempCSht,
        "battery_status": batteryStatus,
        "battery_volt": batteryVolt,
      };
}
