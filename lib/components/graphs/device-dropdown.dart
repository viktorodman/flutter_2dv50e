import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/models/device.dart';

class DeviceDropdown extends StatefulWidget {
  const DeviceDropdown({
    required this.callback,
    required this.data,
    required this.title,
    required this.color,
    Key? key,
  }) : super(key: key);

  final void Function(String?) callback;
  final String title;
  final List<Device>? data;
  final Color color;

  @override
  State<DeviceDropdown> createState() => _DeviceDropdownState();
}

enum YeahButton { first, second, third }

class _DeviceDropdownState extends State<DeviceDropdown> {
  String? selected;

  @override
  initState() {
    super.initState();
    if (widget.data![0] != null) {
      selected = widget.data![0].name;
    } else {
      selected = "No Device Found";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        /* mainAxisAlignment: MainAxisAlignment.start, */
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title),
          DropdownButton(
            value: selected,
            items: this.widget.data!.map<DropdownMenuItem<String>>(
              (Device device) {
                return DropdownMenuItem<String>(
                  child: Text(device.name),
                  value: device.name,
                );
              },
            ).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selected = newValue;
              });
              widget.callback(newValue);
            },
          ),
          Column(
            /* crossAxisAlignment: CrossAxisAlignment.start, */
            children: [
              ListTile(
                title: const Text("prop1"),
                leading: Radio(
                    activeColor: widget.color,
                    value: YeahButton.first,
                    groupValue: YeahButton.first,
                    onChanged: (YeahButton? val) {
                      print(val);
                    }),
              ),
              ListTile(
                title: const Text("prop2"),
                leading: Radio(
                    value: YeahButton.second,
                    groupValue: YeahButton.first,
                    onChanged: (YeahButton? val) {
                      print(val);
                    }),
              ),
              ListTile(
                title: const Text("prop3"),
                leading: Radio(
                    value: YeahButton.third,
                    groupValue: YeahButton.first,
                    onChanged: (YeahButton? val) {
                      print(val);
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
