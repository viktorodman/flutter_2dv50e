import 'dart:convert';
import 'package:flutter_2dv50e/components/graphs/date-time-line-chart.dart';
import 'package:flutter_2dv50e/models/device-types/air-quality-observed.dart';
import 'package:flutter_2dv50e/utils/time.dart' as time;
import 'package:flutter_2dv50e/models/device.dart';
import 'package:http/http.dart' as http;

class DeviceService {
  Future<List<Device>> getDevices() async {
    final response =
        await http.get(Uri.parse('http://localhost:4000/v1/device/user/2'));
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

  Future<Map<String, dynamic>> getDeviceSensorData(String deviceId,
      String? deviceType, DateTime? startDate, DateTime? endDate) async {
    /* print(deviceId); */

    bool hasQuery = false;
    String link = 'http://localhost:4000/v1/request/test/$deviceId';

    if (startDate != null) {
      link += "?startDate=${time.convertDateTimeToString(startDate)}";
      hasQuery = true;
    }

    if (endDate != null) {
      if (hasQuery) {
        link += "&endDate=${time.convertDateTimeToString(endDate)}";
      } else {
        link += "?endDate=${time.convertDateTimeToString(endDate)}";
      }
    }
    final response = await http.get(Uri.parse(link));

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

    /* print(result); */

    return result;
  }

  Future<List<DeviceSensorData>> getChartData(
      String deviceId,
      int numberOfResults,
      String propName,
      DateTime? startDate,
      DateTime? endDate) async {
    bool hasQuery = false;
    String link = 'http://localhost:4000/v1/request/test/$deviceId';

    if (startDate != null) {
      link += "?startDate=${time.convertDateTimeToString(startDate)}";
      hasQuery = true;
    }

    if (endDate != null) {
      if (hasQuery) {
        link += "&endDate=${time.convertDateTimeToString(endDate)}";
      } else {
        link += "?endDate=${time.convertDateTimeToString(endDate)}";
      }
    }

    /* print(link); */
    final response = await http.get(Uri.parse(link));

    List<DeviceSensorData> result = <DeviceSensorData>[];

    try {
      if (List<Map<String, dynamic>>.from(jsonDecode(response.body)).isEmpty) {
        return [];
      }
      List<Map<String, dynamic>>.from(jsonDecode(response.body))
          .forEach((measurement) {
        if (measurement != null) {
          DateTime date = DateTime(2014);
          dynamic val = 0;
          measurement.entries.forEach((sensor) {
            if (sensor.key == "dateObserved") {
              /* print("Yupp: ${sensor.value["value"]}"); */
              date = DateTime.parse(sensor.value["value"]);
            } else if (sensor.key == propName) {
              val = sensor.value["value"] != null ? sensor.value["value"] : 90;
            }
          });
          if (val != null) {
            result.add(DeviceSensorData(date, val));
          }
        }
      });

      /* result.forEach((element) {
        print(element.year);
      }); */
    } catch (e) {
      print(e);
    }

    /* print("wtf");
    print(result.first.data); */

    return result;
  }

  Future<void> updateDeviceInfo(
      double lat, double lng, String desc, String deviceId) async {
    Map data = {"lat": lat, "lng": lng, "desc": desc};

    String body = jsonEncode(data);

    final response = await http.post(
      Uri.parse("http://localhost:4000/v1/device/$deviceId/info"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
    //headers: {'authorization': 'Bearer ' + token},
    /* print(response.body); */
  }
}
