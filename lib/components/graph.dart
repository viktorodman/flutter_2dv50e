import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/api/request.dart';
import 'package:flutter_2dv50e/components/graphs/date-time-line-chart.dart';
import 'package:flutter_2dv50e/components/page-title.dart';
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

  @override
  initState() {
    super.initState();
    _value = getValue();
  }

  Future<GraphData> getValue() async {
    await context
        .read<GraphProvider>()
        .getGraphData('119982f1-edba-4288-867b-8cb3cb42e44c');

    print('YEAH3');
    return context.read<GraphProvider>().graphData;
    // return Provider.of<DeviceProvider>(context, listen: false).devices;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GraphData>(
      future: _value,
      builder: (
        BuildContext context,
        AsyncSnapshot<GraphData> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  PageTitle(title: "Device: ${snapshot.data?.deviceName}"),
                  DateTimeLineChart(data: snapshot.data!.values)
                ],
              ),
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
