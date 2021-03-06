import 'dart:convert';
import 'package:flutter_2dv50e/models/device.dart';
import 'package:http/http.dart' as http;

Future getCSV(String deviceId) async {
  //const token =
  print('IN GET CSV');
  //  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkZsb3diaWMiLCJpYXQiOjE2NDY4MTEyODl9.iB5J9FS4KMdhIn2cn3lJvYwU0deq7PnTYBcbvOHVDAw";

  final response = await http.get(Uri.parse(
      'http://localhost:4000/v1/request/device/$deviceId/csv?startDate=xd&endDate=23'));
  //headers: {'authorization': 'Bearer ' + token},

  if (response.statusCode == 200) {
    print('YEY');
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Item');
  }
}
