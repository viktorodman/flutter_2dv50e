import 'package:flutter/material.dart';

enum MainPageState { none, devices, map, stats, graph }

class MainPageProvider with ChangeNotifier {
  MainPageState _state = MainPageState.devices;

  MainPageState get state => _state;

  set state(MainPageState newState) {
    _state = newState;
    notifyListeners();
  }
}
