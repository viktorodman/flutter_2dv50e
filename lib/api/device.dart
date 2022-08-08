import 'dart:convert';
import 'package:flutter_2dv50e/components/graphs/date-time-line-chart.dart';
import 'package:flutter_2dv50e/models/device-types/air-quality-observed.dart';
import 'package:flutter_2dv50e/models/device.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DeviceService {
  Future<List<Device>> getDevices() async {
    final response =
        await http.get(Uri.parse(dotenv.env["API_URL"]! + '/v1/device/user/2'));
    try {
      if (response.statusCode == 200) {
        return List<Device>.from(
          jsonDecode(response.body).map(
            (x) => Device.fromJson(x),
          ),
        );
      } else {
        throw Exception('Failed to load Item');
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<Map<String, dynamic>> getDeviceSensorData(
      String deviceId, String? deviceType) async {
    print(deviceId);
    final response = await http
        .get(Uri.parse(dotenv.env["API_URL"]! + '/v1/request/test/$deviceId'));

    Map<String, dynamic> result = <String, dynamic>{};

    List<Map<String, dynamic>>.from(jsonDecode(response.body))
        .first
        .entries
        .forEach((el2) {
      String propKey = el2.key;

      if (propKey != "id" && propKey != "type" && propKey != "location") {
        Map<String, dynamic> deviceValue = el2.value as Map<String, dynamic>;
        result[el2.key] = deviceValue["value"];
      }
    });

    print(result);

    return result;
  }

  Future<List<DeviceSensorData>> getChartData(
      String deviceId, int numberOfResults, String propName) async {
    final response = await http
        .get(Uri.parse(dotenv.env["API_URL"]! + '/v1/request/test/$deviceId'));

    List<DeviceSensorData> result = <DeviceSensorData>[];

    try {
      List<Map<String, dynamic>>.from(jsonDecode(response.body))
          .getRange(0, 100)
          .forEach((measurement) {
        DateTime date = DateTime(2014);
        dynamic val = 0;
        measurement.entries.forEach((sensor) {
          if (sensor.key == "dateObserved") {
            print("Yupp: ${sensor.value["value"]}");
            date = DateTime.parse(sensor.value["value"]);
          } else if (sensor.key == propName) {
            val = sensor.value["value"] != null ? sensor.value["value"] : 90;
          }
        });
        if (val != null) {
          result.add(DeviceSensorData(date, val));
        }
      });

      /* result.forEach((element) {
        print(element.year);
      }); */
    } catch (e) {
      print(e);
    }

    print("wtf");
    print(result.first.data);

    return result;
  }

  Future<void> updateDeviceInfo(
      double lat, double lng, String desc, String deviceId) async {
    Map data = {"lat": lat, "lng": lng, "desc": desc};

    String body = jsonEncode(data);

    final response = await http.post(
      Uri.parse(dotenv.env["API_URL"]! + "/v1/device/$deviceId/info"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    //headers: {'authorization': 'Bearer ' + token},
    print(response.body);
  }
}
