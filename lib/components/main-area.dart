import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/components/devices-content.dart';
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
        return const Text('none');
      case MainPageState.devices:
        return const DevicesContent();
      case MainPageState.stats:
        return const Text('stats');
      case MainPageState.map:
        return const Text('map');
      default:
        return const Text('default');
    }
  }
}
