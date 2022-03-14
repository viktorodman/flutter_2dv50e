import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_2dv50e/models/item.dart';

Future<List<Item>> fetchItem() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

  if (response.statusCode == 200) {
    return List<Item>.from(
      jsonDecode(response.body).map(
        (x) => Item.fromJson(x),
      ),
    );
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Item');
  }
}
