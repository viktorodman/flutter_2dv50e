import 'dart:convert';
import 'package:flutter_2dv50e/models/device-types/air-quality-observed.dart';
import 'package:flutter_2dv50e/models/device.dart';
import 'package:http/http.dart' as http;

class DeviceService {
  Future<List<Device>> getDevices() async {
    //const token =
    print('IN GET DEVICES');
    //  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkZsb3diaWMiLCJpYXQiOjE2NDY4MTEyODl9.iB5J9FS4KMdhIn2cn3lJvYwU0deq7PnTYBcbvOHVDAw";

    final response =
        await http.get(Uri.parse('http://localhost:4000/v1/device/user/2'));
    //headers: {'authorization': 'Bearer ' + token},
    /* print(response.body); */

    try {
      if (response.statusCode == 200) {
        return List<Device>.from(
          jsonDecode(response.body).map(
            (x) => Device.fromJson(x),
          ),
        );
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load Item');
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<Map<String, dynamic>> stufftesting(
      String deviceId, String? deviceType) async {
    final response = await http
        .get(Uri.parse('http://localhost:4000/v1/request/test/$deviceId'));

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
    print(response.body);
  }
}
