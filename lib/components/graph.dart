import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/components/graphs/date-time-line-chart.dart';
import 'package:flutter_2dv50e/components/graphs/device-dropdown.dart';
import 'package:flutter_2dv50e/models/device.dart';
import 'package:flutter_2dv50e/models/graph-data.dart';
import 'package:flutter_2dv50e/providers/device-provider.dart';
import 'package:flutter_2dv50e/providers/graph-provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter_2dv50e/utils/time.dart' as time;

class GraphContent extends StatefulWidget {
  const GraphContent({Key? key}) : super(key: key);

  @override
  State<GraphContent> createState() => _GraphContentState();
}

class _GraphContentState extends State<GraphContent> {
  late Future<GraphData> _value;
  late Future<List<Device>> _devices;
  String dropDown1Value = "xD";

  @override
  initState() {
    super.initState();
    _value = getValue();
    _devices = getDevices();
  }

  Future<GraphData> getValue() async {
    await context
        .read<GraphProvider>()
        .getGraphData('119982f1-edba-4288-867b-8cb3cb42e44c');

    print('YEAH3');
    return context.read<GraphProvider>().graphData;
    // return Provider.of<DeviceProvider>(context, listen: false).devices;
  }

  Future<List<Device>> getDevices() async {
    await context.read<DeviceProvider>().getAllDevices();

    return context.read<DeviceProvider>().devices;
  }

  void setFirstDevice(String? deviceName) {
    print(deviceName);
    setState(() {
      dropDown1Value = deviceName!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Device>>(
      future: _devices,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<Device>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else if (snapshot.hasData) {
            /* return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  PageTitle(title: "Device: ${snapshot.data?.deviceName}"),
                  DateTimeLineChart(data: snapshot.data!.values)
                ],
              ),
            ); */
            List<DropdownMenuItem<dynamic>> dropDownItems = [];

            return Column(
              children: [
                Expanded(
                  child: Row(
                    /* mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start, */
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DeviceDropdown(
                              data: snapshot.data,
                              title: "First Device",
                              callback: (String? yeah) => setFirstDevice(yeah),
                            ),
                            Column(
                              children: [
                                ListTile(
                                  title: const Text("prop1"),
                                  leading: Radio(
                                      value: YeahButton.first,
                                      groupValue: YeahButton.first,
                                      onChanged: (YeahButton? val) {
                                        print(val);
                                      }),
                                ),
                                ListTile(
                                  title: const Text("prop2"),
                                  leading: Radio(
                                      value: YeahButton.first, 
                                      groupValue: YeahButton.first,
                                      onChanged: (YeahButton? val) {
                                        print(val);
                                      }),
                                ),
                                ListTile(
                                  title: const Text("prop3"),
                                  leading: Radio(
                                      value: YeahButton.first,
                                      groupValue: YeahButton.first,
                                      onChanged: (YeahButton? val) {
                                        print(val);
                                      }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DeviceDropdown(
                              data: snapshot.data,
                              title: "Second Devices",
                              callback: (String? yeah) => setFirstDevice(yeah),
                            ),
                            Column(
                              children: [
                                ListTile(
                                  title: const Text("prop1"),
                                  leading: Radio(
                                      value: YeahButton.first,
                                      groupValue: YeahButton.first,
                                      onChanged: (YeahButton? val) {
                                        print(val);
                                      }),
                                ),
                                ListTile(
                                  title: const Text("prop2"),
                                  leading: Radio(
                                      value: YeahButton.first,
                                      groupValue: YeahButton.first,
                                      onChanged: (YeahButton? val) {
                                        print(val);
                                      }),
                                ),
                                ListTile(
                                  title: const Text("prop3"),
                                  leading: Radio(
                                      value: YeahButton.first,
                                      groupValue: YeahButton.first,
                                      onChanged: (YeahButton? val) {
                                        print(val);
                                      }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: PointsLineChart.withSampleData())
              ],
            );
          } else {
            return const Center(child: Text('Empty data'));
          }
        } else {
          return Center(child: Text('State: ${snapshot.connectionState}'));
        }
      },
    );
  }
}
