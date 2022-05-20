import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/utils/time.dart' as time;

class DeviceTimeSelect extends StatelessWidget {
  final DateTime? date;
  final Future<Null> Function() onCallback;
  final String dateTitle;
  const DeviceTimeSelect({
    required this.date,
    required this.dateTitle,
    required this.onCallback,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => onCallback(),
      icon: Text(
        '${dateTitle}: ${date != null ? time.convertDateTimeToString(date!) : ''}',
        style: TextStyle(color: Colors.black),
      ),
      label: Icon(
        Icons.date_range,
        color: Color.fromRGBO(96, 125, 139, 1),
      ),
    );
  }
}
