import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/api/device.dart';
import 'package:flutter_2dv50e/components/graphs/sensor-dialog.dart';
import 'package:flutter_2dv50e/models/device.dart';

class DeviceDropdown extends StatefulWidget {
  const DeviceDropdown({
    required this.deviceChanged,
    required this.devices,
    required this.selectedDeviceProps,
    required this.selectProp,
    required this.title,
    required this.color,
    required this.firstSelectedPos,
    Key? key,
  }) : super(key: key);

  final void Function(Device?) deviceChanged;
  final String title;
  final int firstSelectedPos;
  final List<Device>? devices;
  final Color color;
  final Map<String, dynamic> selectedDeviceProps;
  final void Function(String?) selectProp;

  @override
  State<DeviceDropdown> createState() => _DeviceDropdownState();
}

enum YeahButton { first, second, third }

class _DeviceDropdownState extends State<DeviceDropdown> {
  Device? selectedDevice;
  String? selectedDeviceName;
  int selectedProp = 0;

  @override
  initState() {
    super.initState();
    selectedDevice = widget.devices![widget.firstSelectedPos];
  }

  List<Widget> createSensorProps(Map<String, dynamic>? props) {
    List<Widget> widgetList = <Widget>[];

    props!.entries.forEach((element) {
      if (element.key != "dateObserved") {
        widgetList.add(
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              /* crossAxisAlignment: CrossAxisAlignment.start, */
              children: [
                Radio(
                  value: widgetList.length,
                  groupValue: selectedProp,
                  onChanged: (int? val) {
                    setState(() {
                      selectedProp = val!;
                    });
                    widget.selectProp(element.key);
                  },
                ),
                Expanded(child: Text(element.key))
              ],
            ),
          ),
        );
      }
    });

    return widgetList;
  }

  //Map<String, dynamic>
  @override
  Widget build(BuildContext context) {
    return Column(
      /* mainAxisAlignment: MainAxisAlignment.start, */
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            widget.title,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.5, style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          /* decoration: BoxDecoration(
              color: widget.color,
              /* color: const Color.fromRGBO(96, 125, 139, 1), */
              borderRadius: BorderRadius.circular(12)), */
          child: DropdownButton(
            /* dropdownColor: widget.color, */
            /*   icon: Icon(Icons.sensors), */
            /* underline: SizedBox(), */
            underline: Container(
              height: 2,
              color: widget.color,
            ),
            /* elevation: 12, */
            value: selectedDevice!.name,
            style: TextStyle(color: Colors.black),
            iconEnabledColor: Colors.black,
            items: widget.devices!.map<DropdownMenuItem<String>>(
              (Device device) {
                return DropdownMenuItem<String>(
                  child: Text(
                    "${device.deviceType} (${device.name})",
                    style: TextStyle(color: Colors.black),
                  ),
                  value: device.name,
                );
              },
            ).toList(),
            hint: Text(
              "Device 1",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            onChanged: (String? newValue) {
              Device? newSelectedDevice = widget.devices
                  ?.firstWhere((element) => element.name == newValue);
              setState(() {
                /* selected = newValue; */
                selectedProp = 0;
                selectedDeviceName = newValue;
                selectedDevice = newSelectedDevice;
              });
              widget.deviceChanged(newSelectedDevice);
            },
          ),
        ),
        /* Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: createSensorProps(widget.selectedDeviceProps),
        ), */
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ElevatedButton.icon(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
              Color.fromRGBO(96, 125, 139, 1),
            )),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => SensorDialog(
                  props: widget.selectedDeviceProps,
                  selectProp: widget.selectProp,
                ),
              );
            },
            icon: const Icon(Icons.sensors),
            label: Text("Select Sensor"),
          ),
        )
      ],
    );
  }
}
