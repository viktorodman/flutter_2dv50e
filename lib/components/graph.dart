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

  Map<String, dynamic> _firstDeviceProps = {};
  Device? _firstSelectedDevice;
  String? _firstSelectedProp;
  List<DeviceSensorData> _firstChartData = [];

  Map<String, dynamic> _secondDeviceProps = {};
  Device? _secondSelectedDevice;
  String? _secondSelectedProp;
  List<DeviceSensorData> _secondChartData = [];

  @override
  initState() {
    super.initState();
    _testStuff = getStartData();
  }

  Future<List<dynamic>> getStartData() async {
    List<dynamic> data = <dynamic>[];
    List<Device> devices = await getDevices();
    Map<String, dynamic> firstDeviceProps = await getDeviceProps(devices[0]);
    Map<String, dynamic> secondDeviceProps = await getDeviceProps(devices[1]);

    List<DeviceSensorData> firstChartData = await DeviceService().getChartData(
      devices[0].id,
      20,
      firstDeviceProps.keys
          .toList()
          .firstWhere((element) => element != 'dateObserved'),
    );

    List<DeviceSensorData> secondChartData = await DeviceService().getChartData(
      devices[1].id,
      20,
      secondDeviceProps.keys
          .toList()
          .firstWhere((element) => element != 'dateObserved'),
    );

    setState(() {
      _firstDeviceProps = firstDeviceProps;
      _firstChartData = firstChartData;
      _firstSelectedDevice = devices[0];
      _firstSelectedProp = firstDeviceProps.keys
          .toList()
          .firstWhere((element) => element != 'dateObserved');

      _secondDeviceProps = secondDeviceProps;
      _secondChartData = secondChartData;
      _secondSelectedDevice = devices[1];
      _secondSelectedProp = secondDeviceProps.keys
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

  Future<void> updateFirstChartData(String? propName) async {
    Map<String, dynamic> firstDeviceProps =
        await getDeviceProps(_firstSelectedDevice!);
    List<DeviceSensorData> chartData = await DeviceService().getChartData(
      _firstSelectedDevice!.id,
      20,
      firstDeviceProps.keys
          .toList()
          .firstWhere((element) => element == propName),
    );

    setState(() {
      _firstChartData = chartData;
    });
  }

  Future<void> updateSecondChartData(String? propName) async {
    Map<String, dynamic> secondDeviceProps =
        await getDeviceProps(_secondSelectedDevice!);
    List<DeviceSensorData> chartData = await DeviceService().getChartData(
      _secondSelectedDevice!.id,
      20,
      secondDeviceProps.keys
          .toList()
          .firstWhere((element) => element == propName),
    );

    setState(() {
      _secondChartData = chartData;
    });
  }

  Future<void> changeFirstDevice(Device? device) async {
    Map<String, dynamic> newProps = await DeviceService()
        .getDeviceSensorData(device!.id, device.deviceType);

    setState(() {
      _firstDeviceProps = newProps;
      _firstSelectedDevice = device;
      _firstSelectedProp = newProps.keys
          .toList()
          .firstWhere((element) => element != 'dateObserved');
    });
  }

  Future<void> changeSecondDevice(Device? device) async {
    Map<String, dynamic> newProps = await DeviceService()
        .getDeviceSensorData(device!.id, device.deviceType);

    setState(() {
      _secondDeviceProps = newProps;
      _secondSelectedDevice = device;
      _secondSelectedProp = newProps.keys
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
        data: _firstChartData,
      ),
      charts.Series<DeviceSensorData, DateTime>(
          id: 'Los Angeles Revenue',
          domainFn: (DeviceSensorData sales, _) => sales.year,
          measureFn: (DeviceSensorData sales, _) => sales.sales,
          data: _secondChartData)
        ..setAttribute(
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
                DeviceDropdown(
                  devices: snapshot.data![0],
                  selectedDeviceProps: _firstDeviceProps,
                  firstSelectedPos: 0,
                  selectProp: (selectedProp) {
                    updateFirstChartData(selectedProp);
                    print(selectedProp);
                    setState(() {
                      _firstSelectedProp = selectedProp;
                    });
                  },
                  title: "First Device",
                  deviceChanged: (device) => changeFirstDevice(device),
                  color: Colors.blue,
                ),
                SizedBox(
                  height: 30,
                ),
                DeviceDropdown(
                  devices: snapshot.data![0],
                  firstSelectedPos: 1,
                  selectedDeviceProps: _secondDeviceProps,
                  selectProp: (selectedProp) {
                    updateSecondChartData(selectedProp);
                    print(selectedProp);
                    setState(() {
                      _secondSelectedProp = selectedProp;
                    });
                  },
                  title: "Second Device",
                  deviceChanged: (device) => changeSecondDevice(device),
                  color: Colors.red,
                ),
                /*  DeviceDropdown(
                  devices: snapshot.data![0],
                  selectedDeviceProps: _firstDeviceProps,
                  title: "First Device",
                  deviceChanged: (device) => changeFirstDevice(device),
                  color: Colors.red,
                ), */
                /* const Expanded(
                  child: SizedBox(),
                  flex: 4,
                ), */
                Expanded(
                    flex: 40,
                    child: PointsLineChart(
                      createGraphData(),
                      animate: true,
                      propTitle: "yeah",
                      firstTitle: _firstSelectedProp ?? "",
                      secondTitle: _secondSelectedProp ?? "",
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
