import 'dart:ui';

import 'package:flutter/material.dart';

class MapDialog extends StatelessWidget {
  final String deviceName;

  const MapDialog({required this.deviceName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Text(deviceName),
          content: const Text("SENSOR DATA"),
        ));
  }
}
