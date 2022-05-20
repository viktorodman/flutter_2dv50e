import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/utils/time.dart' as time;
import 'dart:html' as html;

class DeviceCSVButton extends StatelessWidget {
  final String baseURL;
  final DateTime? startDate;
  final DateTime? endDate;
  final String deviceId;

  const DeviceCSVButton({
    required this.baseURL,
    required this.startDate,
    required this.endDate,
    required this.deviceId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 12.0),
      decoration: const BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 1.0,
            color: Color.fromRGBO(96, 125, 139, 1),
          ),
        ),
      ),
      child: TextButton.icon(
        // <-- TextButton
        onPressed: () {
          //await getCSV(snapshot.data![index].id);
          bool hasQuery = false;
          String link = "${baseURL}${deviceId}/csv";

          if (startDate != null) {
            link += "?startDate=${time.convertDateTimeToString(startDate!)}";
            hasQuery = true;
          }

          if (endDate != null) {
            if (hasQuery) {
              link += "&endDate=${time.convertDateTimeToString(endDate!)}";
            } else {
              link += "?endDate=${time.convertDateTimeToString(endDate!)}";
            }
          }

          html.window.open(link, "text");
        },
        icon: const Text(
          'Download CSV',
          style: TextStyle(
            color: Color.fromRGBO(96, 125, 139, 1),
          ),
        ),
        label: const Icon(
          Icons.download,
          size: 24.0,
          color: Color.fromRGBO(96, 125, 139, 1),
        ),
      ),
    );
  }
}
