import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/api/device.dart';
import 'package:flutter_2dv50e/components/devices/device-time-select.dart';
import 'package:flutter_2dv50e/components/graphs/date-time-line-chart.dart';
import 'package:flutter_2dv50e/components/graphs/device-dropdown.dart';
import 'package:flutter_2dv50e/components/graphs/sensor-dialog.dart';
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

  DateTime? _startDate;
  DateTime? _endDate;

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
        _startDate,
        _endDate);

    List<DeviceSensorData> secondChartData = await DeviceService().getChartData(
        devices[1].id,
        20,
        secondDeviceProps.keys
            .toList()
            .firstWhere((element) => element != 'dateObserved'),
        _startDate,
        _endDate);

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
    Map<String, dynamic> sensorData = await DeviceService().getDeviceSensorData(
        device.id, device.deviceType, _startDate, _endDate);

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

  Future<void> updateFirstChartData(
      String? propName, sDate, DateTime? eDate) async {
    Map<String, dynamic> firstDeviceProps =
        await getDeviceProps(_firstSelectedDevice!);
    List<DeviceSensorData> chartData = await DeviceService().getChartData(
        _firstSelectedDevice!.id,
        20,
        firstDeviceProps.keys
            .toList()
            .firstWhere((element) => element == propName),
        sDate,
        eDate);

    setState(() {
      _firstChartData = chartData;
    });
  }

  Future<void> updateSecondChartData(
      String? propName, DateTime? sDate, DateTime? eDate) async {
    Map<String, dynamic> secondDeviceProps =
        await getDeviceProps(_secondSelectedDevice!);
    List<DeviceSensorData> chartData = await DeviceService().getChartData(
        _secondSelectedDevice!.id,
        20,
        secondDeviceProps.keys
            .toList()
            .firstWhere((element) => element == propName),
        sDate,
        eDate);

    setState(() {
      _secondChartData = chartData;
    });
  }

  Future<void> changeFirstDevice(Device? device) async {
    Map<String, dynamic> newProps = await DeviceService().getDeviceSensorData(
        device!.id, device.deviceType, _startDate, _endDate);

    setState(() {
      _firstDeviceProps = newProps;
      _firstSelectedDevice = device;
      _firstSelectedProp = newProps.keys
          .toList()
          .firstWhere((element) => element != 'dateObserved');
    });
  }

  _selectFirstDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _startDate) {
      await updateFirstChartData(_firstSelectedProp, picked, _endDate);
      await updateSecondChartData(_secondSelectedProp, picked, _endDate);

      setState(() {
        _startDate = picked;
      });
    }
  }

  _selectSecondDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _endDate) {
      await updateFirstChartData(_firstSelectedProp, _startDate, picked);
      await updateSecondChartData(_secondSelectedProp, _startDate, picked);

      setState(() {
        _endDate = picked;
      });
    }
  }

  Future<void> changeSecondDevice(Device? device) async {
    Map<String, dynamic> newProps = await DeviceService().getDeviceSensorData(
        device!.id, device.deviceType, _startDate, _endDate);

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
    Map<String, dynamic> newProps = await DeviceService().getDeviceSensorData(
        device.id, device.deviceType, _startDate, _endDate);

    return <dynamic>[deviceList, newProps];
  }

  List<charts.Series<dynamic, DateTime>> createGraphData() {
    return [
      charts.Series<DeviceSensorData, DateTime>(
        id: 'First Device',
        domainFn: (DeviceSensorData device, _) => device.date,
        measureFn: (DeviceSensorData device, _) => device.data,
        data: _firstChartData,
      ),
      charts.Series<DeviceSensorData, DateTime>(
          id: 'Second Device',
          domainFn: (DeviceSensorData device, _) => device.date,
          measureFn: (DeviceSensorData device, _) => device.data,
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
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      DeviceDropdown(
                        devices: snapshot.data![0],
                        selectedDeviceProps: _firstDeviceProps,
                        firstSelectedPos: 0,
                        selectProp: (selectedProp) {
                          updateFirstChartData(
                              selectedProp, _startDate, _endDate);
                          print(selectedProp);
                          setState(() {
                            _firstSelectedProp = selectedProp;
                          });
                        },
                        title: "Select first device",
                        deviceChanged: (device) => changeFirstDevice(device),
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      DeviceDropdown(
                        devices: snapshot.data![0],
                        firstSelectedPos: 1,
                        selectedDeviceProps: _secondDeviceProps,
                        selectProp: (selectedProp) {
                          updateSecondChartData(
                              selectedProp, _startDate, _endDate);
                          print(selectedProp);
                          setState(() {
                            _secondSelectedProp = selectedProp;
                          });
                        },
                        title: "Select second device",
                        deviceChanged: (device) => changeSecondDevice(device),
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: const ShapeDecoration(
                          color: Color.fromARGB(255, 236, 238, 238),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.5, style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: DeviceTimeSelect(
                          dateTitle: "Start",
                          date: _startDate,
                          onCallback: () {
                            _selectFirstDate(context);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: const ShapeDecoration(
                          color: Color.fromARGB(255, 236, 238, 238),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0.5, style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: DeviceTimeSelect(
                          dateTitle: "End",
                          date: _endDate,
                          onCallback: () {
                            _selectSecondDate(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 40,
                  child: PointsLineChart(
                    createGraphData(),
                    animate: true,
                    propTitle: "yeah",
                    firstTitle: _firstSelectedProp != null
                        ? "${_firstSelectedDevice?.name} - ${_firstSelectedProp}"
                        : "",
                    secondTitle: _secondSelectedProp != null
                        ? "${_secondSelectedDevice?.name} - ${_secondSelectedProp}"
                        : "",
                  ),
                ),
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
