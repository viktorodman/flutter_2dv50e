import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/components/devices/devices-content.dart';
import 'package:flutter_2dv50e/components/graph.dart';
import 'package:flutter_2dv50e/components/maps/map.dart';
import 'package:flutter_2dv50e/components/stats/stats.dart';
import 'package:flutter_2dv50e/providers/main-page-provider.dart';
import 'package:provider/provider.dart';

class MainArea extends StatelessWidget {
  const MainArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (Provider.of<MainPageProvider>(context).state) {
      case MainPageState.none:
        print('none');
        return const Text('none');
      case MainPageState.devices:
        print('Devices');
        return const DevicesContent();
      case MainPageState.graph:
        print('Graph');
        return const GraphContent();
      case MainPageState.map:
        print('Map');
        return const DeviceMap();
      default:
        print('Default');
        return const Text('default');
    }
  }
}
