// To parse this JSON data, do
//
//     final graphData = graphDataFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GraphData graphDataFromJson(String str) => GraphData.fromJson(json.decode(str));

String graphDataToJson(GraphData data) => json.encode(data.toJson());

class GraphData {
  GraphData({
    required this.deviceName,
    required this.values,
  });

  final String deviceName;
  final List<Value> values;

  factory GraphData.fromJson(Map<String, dynamic> json) => GraphData(
        deviceName: json["deviceName"],
        values: List<Value>.from(json["values"].map((x) => Value.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "deviceName": deviceName,
        "values": List<dynamic>.from(values.map((x) => x.toJson())),
      };
}

class Value {
  Value({
    required this.created,
    required this.humidity,
    required this.temperature,
    required this.pressure,
  });

  final DateTime created;
  final double humidity;
  final double temperature;
  final int pressure;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        created: DateTime.parse(json["created"]),
        humidity: json["humidity"].toDouble(),
        temperature: json["temperature"].toDouble(),
        pressure: json["pressure"],
      );

  Map<String, dynamic> toJson() => {
        "created": created.toIso8601String(),
        "humidity": humidity,
        "temperature": temperature,
        "pressure": pressure,
      };
}
