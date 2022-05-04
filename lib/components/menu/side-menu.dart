import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/components/menu/menu-item.dart';
import 'package:flutter_2dv50e/providers/main-page-provider.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: const [
          DrawerHeader(
            child: Text(
              'Kalmar Dämme',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          MenuItem(
            text: 'Devices',
            pageState: MainPageState.devices,
            icon: Icons.sensors,
          ),
          MenuItem(
            text: 'Graph',
            pageState: MainPageState.graph,
            icon: Icons.device_hub_outlined,
          ),
          MenuItem(text: 'Map', pageState: MainPageState.map, icon: Icons.map),
          /* MenuItem(
            text: 'None',
            pageState: MainPageState.none,
            icon: Icons.mic_none,
          ), */
        ],
      ),
    );
  }
}
