import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/api/device.dart';
import 'package:flutter_2dv50e/api/requests.dart';
import 'package:flutter_2dv50e/models/device.dart';
import 'package:flutter_2dv50e/models/temperature-sensor.dart';

class StatsProvider with ChangeNotifier {
  List<TemperatureSensor> _stats = [];
  List<TemperatureSensor> get stats => _stats;

  getAllStats() async {
    _stats = await getSensorData();
    notifyListeners();
  }
}
