import 'dart:convert';
import 'package:flutter_2dv50e/models/device.dart';
import 'package:http/http.dart' as http;

Future<List<Device>> getDevices() async {
  const token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkZsb3diaWMiLCJpYXQiOjE2NDY4MTEyODl9.iB5J9FS4KMdhIn2cn3lJvYwU0deq7PnTYBcbvOHVDAw";

  final response = await http.get(
    Uri.parse('http://6b08-85-229-204-181.ngrok.io/v1/devices/user/2'),
    headers: {'authorization': 'Bearer ' + token},
  );

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
}
