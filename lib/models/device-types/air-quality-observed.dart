import 'dart:convert';

AirQualityObserved airQualityObservedFromJson(String str) =>
    AirQualityObserved.fromJson(json.decode(str));

String airQualityObservedToJson(AirQualityObserved data) =>
    json.encode(data.toJson());

class AirQualityObserved {
  AirQualityObserved({
    this.id,
    this.type,
    this.dateObserved,
    this.battery,
    this.temperature,
    this.barometricTemperature,
    this.relativeHumidity,
    this.barometricPressure,
    this.co2,
    this.o2,
    this.o2Saturation,
    this.location,
  });

  final String? id;
  final String? type;
  final DateObserved? dateObserved;
  final O2? battery;
  final O2? temperature;
  final O2? barometricTemperature;
  final O2? relativeHumidity;
  final O2? barometricPressure;
  final O2? co2;
  final O2? o2;
  final O2? o2Saturation;
  final Location? location;

  factory AirQualityObserved.fromJson(Map<String, dynamic> json) =>
      AirQualityObserved(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        dateObserved: json["dateObserved"] == null
            ? null
            : DateObserved.fromJson(json["dateObserved"]),
        battery: json["battery"] == null ? null : O2.fromJson(json["battery"]),
        temperature: json["temperature"] == null
            ? null
            : O2.fromJson(json["temperature"]),
        barometricTemperature: json["barometricTemperature"] == null
            ? null
            : O2.fromJson(json["barometricTemperature"]),
        relativeHumidity: json["relativeHumidity"] == null
            ? null
            : O2.fromJson(json["relativeHumidity"]),
        barometricPressure: json["barometricPressure"] == null
            ? null
            : O2.fromJson(json["barometricPressure"]),
        co2: json["co2"] == null ? null : O2.fromJson(json["co2"]),
        o2: json["O2"] == null ? null : O2.fromJson(json["O2"]),
        o2Saturation: json["O2Saturation"] == null
            ? null
            : O2.fromJson(json["O2Saturation"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "dateObserved": dateObserved == null ? null : dateObserved?.toJson(),
        "battery": battery == null ? null : battery?.toJson(),
        "temperature": temperature == null ? null : temperature?.toJson(),
        "barometricTemperature": barometricTemperature == null
            ? null
            : barometricTemperature?.toJson(),
        "relativeHumidity":
            relativeHumidity == null ? null : relativeHumidity?.toJson(),
        "barometricPressure":
            barometricPressure == null ? null : barometricPressure?.toJson(),
        "co2": co2 == null ? null : co2?.toJson(),
        "O2": o2 == null ? null : o2?.toJson(),
        "O2Saturation": o2Saturation == null ? null : o2Saturation?.toJson(),
        "location": location == null ? null : location?.toJson(),
      };
}

class O2 {
  O2({
    this.type,
    this.value,
  });

  final String? type;
  final double? value;

  factory O2.fromJson(Map<String, dynamic> json) => O2(
        type: json["type"] ?? null,
        value: json["value"] == null ? null : json["value"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "value": value == null ? null : value,
      };
}

class DateObserved {
  DateObserved({
    this.type,
    this.value,
  });

  final String? type;
  final DateTime? value;

  factory DateObserved.fromJson(Map<String, dynamic> json) => DateObserved(
        type: json["type"] ?? null,
        value: json["value"] == null ? null : DateTime.parse(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "value": value == null ? null : value?.toIso8601String(),
      };
}

class Location {
  Location({
    this.type,
    this.value,
  });

  final String? type;
  final Value? value;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"] ?? null,
        value: json["value"] == null ? null : Value.fromJson(json["value"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type ?? null,
        "value": value == null ? null : value?.toJson(),
      };
}

class Value {
  Value({
    this.type,
    this.coordinates,
  });

  final String? type;
  final List<String>? coordinates;

  factory Value.fromJson(Map<String, dynamic> json) => Value(
        type: json["type"] ?? null,
        coordinates: json["coordinates"] == null
            ? null
            : List<String>.from(json["coordinates"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "coordinates": coordinates == null
            ? null
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
