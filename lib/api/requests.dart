import 'dart:convert';
import 'package:flutter_2dv50e/models/device.dart';
import 'package:flutter_2dv50e/models/temperature-sensor.dart';
import 'package:http/http.dart' as http;

Future<List<TemperatureSensor>> getSensorData() async {
  const token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkZsb3diaWMiLCJpYXQiOjE2NDY4MTEyODl9.iB5J9FS4KMdhIn2cn3lJvYwU0deq7PnTYBcbvOHVDAw";

  final response = await http.get(
    Uri.parse(
        'http://94c1-85-229-204-181.ngrok.io/v1/request/device/defe74aa-f1bb-458f-82ff-3c6e94d7fcd7/'),
    headers: {'authorization': 'Bearer ' + token},
  );

  if (response.statusCode == 200) {
    print(response.body);
    return List<TemperatureSensor>.from(
      jsonDecode(response.body)["temp"].map(
        (x) => TemperatureSensor.fromJson(x),
      ),
    );
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Item');
  }
}
