import 'package:flutter/material.dart';

class SensorDialog extends StatefulWidget {
  const SensorDialog({Key? key}) : super(key: key);

  @override
  State<SensorDialog> createState() => _SensorDialogState();
}

class _SensorDialogState extends State<SensorDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[200],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Column(),
    );
  }
}
