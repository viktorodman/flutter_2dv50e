import 'dart:convert';

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
      };
}
