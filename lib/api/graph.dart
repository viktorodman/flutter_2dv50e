import 'dart:convert';
import 'package:flutter_2dv50e/models/graph-data.dart';
import 'package:flutter_2dv50e/providers/graph-provider.dart';
import 'package:http/http.dart' as http;

Future<GraphData> requestGraphData(String deviceId) async {
  //const token =
  //  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6IkZsb3diaWMiLCJpYXQiOjE2NDY4MTEyODl9.iB5J9FS4KMdhIn2cn3lJvYwU0deq7PnTYBcbvOHVDAw";

  final response =
      await http.get(Uri.parse('http://localhost:4000/v1/graph/$deviceId'));
  //headers: {'authorization': 'Bearer ' + token},

  if (response.statusCode == 200) {
    /*  return List<GraphData>.from(
      jsonDecode(response.body).map(
        (x) => GraphData.fromJson(x),
      ),
    ); */
    return GraphData.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Item');
  }
}
