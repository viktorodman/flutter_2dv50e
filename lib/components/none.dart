/* import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/components/graph.dart';
import 'package:flutter_2dv50e/components/page-title.dart';
import 'package:flutter_2dv50e/models/device.dart';
import 'package:flutter_2dv50e/models/temperature-sensor.dart';
import 'package:flutter_2dv50e/providers/device-provider.dart';
import 'package:flutter_2dv50e/providers/stats-provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter_2dv50e/utils/time.dart' as time;

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  late Future<List<TemperatureSensor>> _value;

  @override
  initState() {
    super.initState();
    _value = getValue();
  }

  Future<List<TemperatureSensor>> getValue() async {
    await context.read<StatsProvider>().getAllStats();
    return context.read<StatsProvider>().stats;
    // return Provider.of<DeviceProvider>(context, listen: false).devices;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TemperatureSensor>>(
      future: _value,
      builder: (
        BuildContext context,
        AsyncSnapshot<List<TemperatureSensor>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else if (snapshot.hasData) {
            return Column(
              children: [
                const PageTitle(title: 'Stats'),
                Expanded(child: DashPatternLineChart.withSampleData()),
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
 */