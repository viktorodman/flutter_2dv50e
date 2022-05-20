import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/models/device.dart';

class MapsInfo extends StatelessWidget {
  final Map<String, Color> colorsMap;
  final List<Device>? devices;
  const MapsInfo({
    required this.colorsMap,
    required this.devices,
    Key? key,
  }) : super(key: key);

  List<Widget> _createCards() {
    List<Widget> cards = <Widget>[];
    colorsMap.entries.forEach((element) {
      cards.add(Card(
        child: Column(children: [
          Row(
            children: [
              Chip(
                label: Text(element.key),
                backgroundColor: element.value,
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ]),
      ));
    });

    return cards;
  }

  List<Widget> getDevices(String devType) {
    List<Widget> devs = <Widget>[];

    devices?.forEach((device) {
      if (device.deviceType == devType) {
        devs.add(Chip(label: Text(device.name)));
        devs.add(SizedBox(
          height: 5,
        ));
      }
    });

    return devs;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        color: Color.fromRGBO(96, 125, 139, 1),
        width: 200,
        /* child: Column(children: _createCards()), */
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: colorsMap.length,
                itemBuilder: (context, index) {
                  String key = colorsMap.keys.elementAt(index);
                  return ExpansionTile(
                    collapsedBackgroundColor: colorsMap[key],
                    backgroundColor: colorsMap[key],
                    title: Text(
                      key,
                      style: TextStyle(color: Colors.white),
                    ),
                    children: getDevices(key),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
