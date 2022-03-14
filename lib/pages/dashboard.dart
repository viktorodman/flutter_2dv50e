import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/components/main-area.dart';
import 'package:flutter_2dv50e/components/side-menu.dart';
import 'package:flutter_2dv50e/providers/device-provider.dart';
import 'package:flutter_2dv50e/providers/main-page-provider.dart';
import 'package:flutter_2dv50e/providers/store-provider.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Store(),
        ),
        ChangeNotifierProvider(
          create: (context) => DeviceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MainPageProvider(),
        ),
      ],
      child: Scaffold(
        body: Row(
          children: const [
            Expanded(
              child: SideMenu(),
            ),
            Expanded(
              flex: 4,
              child: MainArea(),
            )
          ],
        ),
      ),
    );
  }
}
