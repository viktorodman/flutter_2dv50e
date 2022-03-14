import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/api/device.dart';
import 'package:flutter_2dv50e/models/device.dart';

class DeviceProvider with ChangeNotifier {
  List<Device> _devices = [];
  List<Device> get devices => _devices;

  getAllDevices() async {
    _devices = await getDevices();
    print('In store');
    print(_devices);
    notifyListeners();
  }
}
