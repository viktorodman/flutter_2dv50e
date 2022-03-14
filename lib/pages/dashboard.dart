import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/components/side-menu.dart';
import 'package:flutter_2dv50e/main.dart';
import 'package:flutter_2dv50e/models/user.dart';
import 'package:flutter_2dv50e/providers/device-provider.dart';
import 'package:flutter_2dv50e/providers/store-provider.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  String getStringFromDateTime(DateTime time) {
    final localDay = time.toLocal().toString();
    final splitted = localDay.split(' ');
    //return '${time.year.toString()}-${time.month.toString()}-${time.day.toString()}';
    return splitted.first;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Store(),
        ),
        ChangeNotifierProvider(
          create: (context) => DeviceProvider(),
        )
      ],
      child: Scaffold(
        body: Row(
          children: [
            const Expanded(
              child: SideMenu(),
            ),
            Expanded(
              flex: 4,
              child: Center(
                child: Container(
                  child: Consumer<DeviceProvider>(
                    builder: (context, value, child) {
                      return ListView.builder(
                        itemCount: value.devices.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              subtitle: Text(value.devices[index].devaddr),
                              title: Text(value.devices[index].name),
                              trailing: Text(
                                  'Created: ${getStringFromDateTime(value.devices[index].created)}'),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
