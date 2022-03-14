import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/main.dart';
import 'package:flutter_2dv50e/models/device.dart';
import 'package:flutter_2dv50e/providers/device-provider.dart';
import 'package:flutter_2dv50e/providers/store-provider.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          DrawerHeader(child: Text('Header')),
          MenuItem(text: 'Get All Items'),
          MenuItem(text: '2'),
          MenuItem(text: '3'),
          MenuItem(text: '4'),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    required this.text,
    Key? key,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      onTap: () async {
        await context.read<DeviceProvider>().getAllDevices();
      },
    );
  }
}
