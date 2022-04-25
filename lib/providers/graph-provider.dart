import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/api/device.dart';
import 'package:flutter_2dv50e/api/graph.dart';
import 'package:flutter_2dv50e/models/device.dart';
import 'package:flutter_2dv50e/models/graph-data.dart';

class GraphProvider with ChangeNotifier {
  GraphData _graphData = GraphData(deviceName: "deviceName", values: []);
  GraphData get graphData => _graphData;

  getGraphData(String deviceId) async {
    _graphData = await requestGraphData(deviceId);
    notifyListeners();
  }
}
