import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/models/device.dart';
import 'package:flutter_2dv50e/utils/time.dart' as time;
import 'dart:html' as html;

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

    return Card(
      elevation: 8.0,
      child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          subtitle: Text(widget.device.devaddr),
          title: Text(widget.device.name),
          /* trailing: Text(
          'Created: ${time.convertDateTimeToString(device.created)}',
        ), */
          trailing: Container(
            child: Wrap(
              children: [
                TextButton.icon(
                  onPressed: () => _selectFirstDate(context),
                  icon: Text(
                    'Start: ${_startDate != null ? time.convertDateTimeToString(_startDate!) : ''}',
                    style: TextStyle(color: Colors.black),
                  ),
                  label: Icon(
                    Icons.date_range,
                    color: Color.fromRGBO(96, 125, 139, 1),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _selectSecondDate(context),
                  icon: Text(
                    'Slut: ${_endDate != null ? time.convertDateTimeToString(_endDate!) : ''}',
                    style: TextStyle(color: Colors.black),
                  ),
                  label: Icon(Icons.date_range,
                      color: Color.fromRGBO(96, 125, 139, 1)),
                ),
                Container(
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
                      String link =
                          "http://localhost:4000/v1/request/device/${widget.device.id}/csv";

                      if (_startDate != null) {
                        link +=
                            "?startDate=${time.convertDateTimeToString(_startDate!)}";
                        hasQuery = true;
                      }

                      if (_endDate != null) {
                        if (hasQuery) {
                          link +=
                              "&endDate=${time.convertDateTimeToString(_endDate!)}";
                        } else {
                          link +=
                              "?endDate=${time.convertDateTimeToString(_endDate!)}";
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
                ),
              ],
            ),
          ),
          leading: Icon(Icons.sensors)),
    );
  }
}
