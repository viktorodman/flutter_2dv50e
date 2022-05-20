import 'dart:convert';
import 'dart:html';
import 'package:flutter_2dv50e/models/graph-data.dart';
import 'package:flutter_2dv50e/providers/graph-provider.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://localhost:4000/v1/graph/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      window.localStorage["token"] = jsonDecode(response.body).token;
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> isAuthenticated() async {
    print("försöker");
    bool hasToken = window.localStorage.containsKey("token");

    if (!hasToken) return false;

    var token = window.localStorage["token"];

    final response = await http.get(
      Uri.parse('http://localhost:4000/v1/auth'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      /*  return List<GraphData>.from(
      jsonDecode(response.body).map(
        (x) => GraphData.fromJson(x),
      ),
    ); */
      /* return GraphData.fromJson(jsonDecode(response.body)); */
      return true;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      return false;
    }
  }
}
