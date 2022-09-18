import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/api/device.dart';
import 'package:flutter_2dv50e/components/maps/maps-info.dart';
import 'package:flutter_2dv50e/models/device.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:flutter_2dv50e/providers/device-provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DeviceMap extends StatefulWidget {
  const DeviceMap({Key? key}) : super(key: key);

  @override
  State<DeviceMap> createState() => _DeviceMapState();
}

class _DeviceMapState extends State<DeviceMap> {
  late Future<List<Device>> _value;

  final Map<String, Color> _colors = {
    "WeatherObserved": Color.fromARGB(255, 96, 183, 151),
    "DistanceObserved": Color.fromRGBO(76, 134, 168, 1),
    "AirQualityObserved": Color.fromRGBO(224, 119, 125, 1),
    "WaterQualityObserved": Color.fromRGBO(225, 221, 143, 1),
    "Other": Color.fromRGBO(142, 59, 70, 1)
  };

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

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(56.667275626479274, 16.293136576664427),
    zoom: 16.0000,
    /* zoom: 15.4746, */
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(56.667029872081166, 16.292616617169944),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Set<Marker> _markers = <Marker>{};

  List<Widget> createDeviceDescription(
    String? description,
    Map<String, dynamic> properties,
  ) {
    List<Widget> deviceDescriptions = <Widget>[];
    final f = new DateFormat('yyyy-MM-dd hh:mm');
    DateTime date = DateTime.parse(properties["dateObserved"]);

    deviceDescriptions.add(Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$description",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          /* SizedBox(width: 20), */
          Text(
            "${f.format(date)}",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
        ],
      ),
    ));

    /* deviceDescriptions.add(Expanded(
      child: Divider(
        color: Colors.black12,
      ),
    )); */

    properties.entries.forEach((element) {
      if (element.key != "dateObserved") {
        deviceDescriptions.add(
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Text(
                "${element.key} : ${element.value}",
              ),
            ),
          ),
        );
        deviceDescriptions.add(SizedBox(
          height: 5,
        ));
      }
    });

    return deviceDescriptions;
  }

  createMarkers(List<Device>? devices) {
    devices?.forEach((element) {
      if (element.lat != null &&
          element.lng != null &&
          element.description != null) {
        _markers
            .addLabelMarker(
          LabelMarker(
              label: element.name,
              textStyle: TextStyle(fontSize: 14, color: Colors.white),
              markerId: MarkerId(element.id),
              position: LatLng(element.lat as double, element.lng as double),
              backgroundColor: _colors.containsKey(element.deviceType)
                  ? _colors[element.deviceType]!
                  : Colors.amber,
              onTap: () async {
                Map<String, dynamic> yeah = await DeviceService()
                    .getDeviceSensorData(
                        element.id, element.deviceType, null, null);
                showDialog(
                    context: context,
                    builder: (BuildContext context) => SimpleDialog(
                        titlePadding: EdgeInsets.all(8),
                        title: Container(
                          child: Text(
                            "Device: ${element.name}",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        children:
                            createDeviceDescription(element.description, yeah)
                        /* [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Container(
                                child: Text("1"),
                              ),
                            ),
                            Container(
                              child: Text("2"),
                            ),
                            Container(
                              child: Text("3"),
                            ),
                          ], */
                        )
                    /* AlertDialog(
                    title: Text("Device: ${element.name}"),
                    content: Container(

                      color: Colors.white,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: createDeviceDescription(element.description,
                              yeah) /* [
                          Text(" ${element.description}"),
                          Text(yeah.keys),
                        ], */
                          ),
                    ),
                  ), */
                    );
              }),
        )
            .then((value) {
          setState(() {});
        });
        ;
      }
    });
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
            createMarkers(snapshot.data);
            return Stack(
              children: [
                Container(
                  child: new GoogleMap(
                    mapType: MapType.hybrid,
                    initialCameraPosition: _kGooglePlex,
                    markers: _markers,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
                MapsInfo(colorsMap: _colors, devices: snapshot.data),
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
