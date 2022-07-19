import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/api/device.dart';
import 'package:flutter_2dv50e/components/graphs/date-time-line-chart.dart';
import 'package:flutter_2dv50e/components/graphs/device-dropdown.dart';
import 'package:flutter_2dv50e/models/device.dart';
import 'package:flutter_2dv50e/models/graph-data.dart';
import 'package:flutter_2dv50e/providers/device-provider.dart';
import 'package:flutter_2dv50e/providers/graph-provider.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter_2dv50e/utils/time.dart' as time;

class GraphContent extends StatefulWidget {
  const GraphContent({Key? key}) : super(key: key);

  @override
  State<GraphContent> createState() => _GraphContentState();
}

class _GraphContentState extends State<GraphContent> {
  late Future<List<dynamic>> _testStuff;
  late Future<GraphData> _value;

  Map<String, dynamic> _props = {};
  Device? selectedDeviceOne;
  String? selectedPropOne;
  List<DeviceSensorData> chartDataOne = [];

  @override
  initState() {
    super.initState();
    _testStuff = getStartData();
  }

  Future<List<dynamic>> getStartData() async {
    List<dynamic> data = <dynamic>[];
    List<Device> devices = await getDevices();
    Map<String, dynamic> firstDeviceProps = await getDeviceProps(devices[0]);
    List<DeviceSensorData> chartData = await DeviceService().getChartData(
      devices[0].id,
      20,
      firstDeviceProps.keys
          .toList()
          .firstWhere((element) => element != 'dateObserved'),
    );

    setState(() {
      _props = firstDeviceProps;
      chartDataOne = chartData;
      selectedDeviceOne = devices[0];
      selectedPropOne = firstDeviceProps.keys
          .toList()
          .firstWhere((element) => element != 'dateObserved');
    });

    return <dynamic>[devices, firstDeviceProps];
  }

  Future<Map<String, dynamic>> getDeviceProps(Device device) async {
    Map<String, dynamic> sensorData =
        await DeviceService().getDeviceSensorData(device.id, device.deviceType);

    return sensorData;
  }

  Future<GraphData> getValue() async {
    await context
        .read<GraphProvider>()
        .getGraphData('119982f1-edba-4288-867b-8cb3cb42e44c');

    return context.read<GraphProvider>().graphData;
  }

  Future<List<Device>> getDevices() async {
    await context.read<DeviceProvider>().getAllDevices();

    return context.read<DeviceProvider>().devices;
  }

  Future<void> updateChartData(String? propName) async {
    Map<String, dynamic> firstDeviceProps =
        await getDeviceProps(selectedDeviceOne!);
    List<DeviceSensorData> chartData = await DeviceService().getChartData(
      selectedDeviceOne!.id,
      20,
      firstDeviceProps.keys
          .toList()
          .firstWhere((element) => element == propName),
    );

    setState(() {
      chartDataOne = chartData;
    });
  }

  Future<void> changeFirstDevice(Device? device) async {
    Map<String, dynamic> newProps = await DeviceService()
        .getDeviceSensorData(device!.id, device.deviceType);

    setState(() {
      _props = newProps;
      selectedDeviceOne = device;
      selectedPropOne = newProps.keys
          .toList()
          .firstWhere((element) => element != 'dateObserved');
    });
  }

  Future<List<dynamic>> updateDeviceProps(
      Device device, List<Device> deviceList) async {
    Map<String, dynamic> newProps =
        await DeviceService().getDeviceSensorData(device.id, device.deviceType);

    return <dynamic>[deviceList, newProps];
  }

  List<charts.Series<dynamic, DateTime>> createGraphData() {
    return [
      charts.Series<DeviceSensorData, DateTime>(
        id: 'Global Revenue',
        domainFn: (DeviceSensorData sales, _) => sales.year,
        measureFn: (DeviceSensorData sales, _) => sales.sales,
        data: chartDataOne,
      ),
      charts.Series<DeviceSensorData, DateTime>(
        id: 'Los Angeles Revenue',
        domainFn: (DeviceSensorData sales, _) => sales.year,
        measureFn: (DeviceSensorData sales, _) => sales.sales,
        data: [
          DeviceSensorData(DateTime.utc(2022, 01, 22), 10),
          DeviceSensorData(DateTime.utc(2022, 01, 23), 20),
          DeviceSensorData(DateTime.utc(2022, 01, 24), 30),
        ],
      )..setAttribute(
          charts.measureAxisIdKey, charts.Axis.secondaryMeasureAxisId)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _testStuff,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<dynamic>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else if (snapshot.hasData) {
            List<DropdownMenuItem<dynamic>> dropDownItems = [];
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DeviceDropdown(
                      devices: snapshot.data![0],
                      selectedDeviceProps: _props,
                      selectProp: (selectedProp) {
                        updateChartData(selectedProp);
                        print(selectedProp);
                        setState(() {
                          selectedPropOne = selectedProp;
                        });
                      },
                      title: "First Device",
                      deviceChanged: (device) => changeFirstDevice(device),
                      color: Colors.blue,
                    ),
                    /*  DeviceDropdown(
                      devices: snapshot.data![0],
                      selectedDeviceProps: _props,
                      title: "First Device",
                      deviceChanged: (device) => changeFirstDevice(device),
                      color: Colors.red,
                    ), */
                    const Expanded(
                      child: SizedBox(),
                      flex: 4,
                    )
                  ],
                ),
                Text(selectedPropOne ?? "hhuuuu"),
                Text(
                    selectedDeviceOne != null ? selectedDeviceOne!.name : "ne"),
                Expanded(
                    flex: 3,
                    child: PointsLineChart(
                      createGraphData(),
                      animate: true,
                      propTitle: "yeah",
                    )),
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
