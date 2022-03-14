import 'package:flutter/material.dart';
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
    await context.read<DeviceProvider>().getAllDevices();
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
            return Center(
              child: ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      subtitle: Text(snapshot.data![index].devaddr),
                      title: Text(snapshot.data![index].name),
                      trailing: Text(
                        'Created: ${time.convertDateTimeToString(snapshot.data![index].created)}',
                      ),
                    ),
                  );
                },
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
