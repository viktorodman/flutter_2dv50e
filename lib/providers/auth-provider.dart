import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/models/user.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  User? get user => _user;

  /* authenticateUser() async {
    _listItems = await login();
    notifyListeners();
  } */
}
