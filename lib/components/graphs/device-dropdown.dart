import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/api/device.dart';
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
              children: [
                Expanded(
                  child: Row(
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
                    ], /*  RadioListTile(
                      title: Text(element.key),
                      /* leading: Radio( */
                      activeColor: widget.color,
                      value: widgetList.length,
                      groupValue: selectedProp,
                      onChanged: (int? val) {
                        setState(() {
                          selectedProp = val!;
                        });
                        widget.selectProp(element.key);
                      } /* ) */,
                    ), */
                  ),
                ),
              ],
            ),
            flex: 1,
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
        Text(widget.title),
        DropdownButton(
          value: selectedDevice!.name,
          items: widget.devices!.map<DropdownMenuItem<String>>(
            (Device device) {
              return DropdownMenuItem<String>(
                child: Text(device.name),
                value: device.name,
              );
            },
          ).toList(),
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
        Row(
          /* mainAxisAlignment: MainAxisAlignment.spaceAround, */
          children: createSensorProps(widget.selectedDeviceProps),
        ),
      ],
    );
  }
}
