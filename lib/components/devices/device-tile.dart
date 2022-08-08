import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/api/device.dart';
import 'package:flutter_2dv50e/components/devices/device-csv.dart';
import 'package:flutter_2dv50e/components/devices/device-info.dart';
import 'package:flutter_2dv50e/components/devices/device-time-select.dart';
import 'package:flutter_2dv50e/models/device.dart';
import 'package:flutter_2dv50e/utils/time.dart' as time;
import 'dart:html' as html;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class DeviceTile extends StatefulWidget {
  const DeviceTile({
    required this.device,
    Key? key,
  }) : super(key: key);

  final Device device;

  @override
  State<DeviceTile> createState() => _DeviceTileState();
}

class _DeviceTileState extends State<DeviceTile> {
  DateTime? _startDate;
  DateTime? _endDate;
  @override
  Widget build(BuildContext context) {
    _selectFirstDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), // Refer step 1
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
      );
      if (picked != null && picked != _startDate)
        setState(() {
          _startDate = picked;
        });
    }

    _selectSecondDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), // Refer step 1
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
      );
      if (picked != null && picked != _endDate)
        setState(() {
          _endDate = picked;
        });
    }

    _updateDeviceInfo(double? lat, double? lng, String? description) async {
      print("Latitude: ${lat}");
      print("Longitude: ${lng}");
      print("Description: ${description}");
      if (lat != null && lng != null && description != null) {
        await DeviceService()
            .updateDeviceInfo(lat, lng, description, widget.device.id);
      }
    }

    return Card(
      elevation: 8.0,
      child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          subtitle: DeviceInfoButton(
            description: widget.device.description,
            currentLat: widget.device.lat,
            currentLng: widget.device.lng,
            deviceName: widget.device.name,
            onUpdate: (lat, lng, desc) => _updateDeviceInfo(lat, lng, desc),
          ),
          title: Text(widget.device.name),
          trailing: Container(
            child: Wrap(
              children: [
                DeviceTimeSelect(
                  dateTitle: "Start",
                  date: _startDate,
                  onCallback: () => _selectFirstDate(context),
                ),
                DeviceTimeSelect(
                  dateTitle: "End",
                  date: _endDate,
                  onCallback: () => _selectSecondDate(context),
                ),
                DeviceCSVButton(
                  baseURL: dotenv.env["API_URL"]! + "/v1/request/device/",
                  startDate: _startDate,
                  endDate: _endDate,
                  deviceId: widget.device.id,
                ),
              ],
            ),
          ),
          leading: Icon(Icons.sensors)),
    );
  }
}
