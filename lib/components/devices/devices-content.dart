import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/api/request.dart';
import 'package:flutter_2dv50e/components/devices/device-tile.dart';
import 'package:flutter_2dv50e/components/page-title.dart';
import 'package:flutter_2dv50e/models/device.dart';
import 'package:flutter_2dv50e/providers/device-provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter_2dv50e/utils/time.dart' as time;

class DevicesContent extends StatefulWidget {
  const DevicesContent({Key? key}) : super(key: key);

  @override
  State<DevicesContent> createState() => _DevicesContentState();
}

class _DevicesContentState extends State<DevicesContent> {
  late Future<List<Device>> _value;

  @override
  initState() {
    super.initState();
    _value = getValue();
  }

  Future<List<Device>> getValue() async {
    print('YEAH2');
    await context.read<DeviceProvider>().getAllDevices();

    print('YEAH3');
    return context.read<DeviceProvider>().devices;
    // return Provider.of<DeviceProvider>(context, listen: false).devices;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Device>>(
      future: _value,
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
            return Column(
              children: [
                const PageTitle(title: 'Devices'),
                Text('Number of devices: ${snapshot.data?.length}'),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                    child: Center(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: DeviceTile(
                                device: snapshot.data![index],
                              ));
                        },
                      ),
                    ),
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
