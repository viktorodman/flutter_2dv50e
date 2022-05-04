import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_2dv50e/models/test-thing.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';

class DeviceMap extends StatefulWidget {
  const DeviceMap({Key? key}) : super(key: key);

  @override
  State<DeviceMap> createState() => _DeviceMapState();
}

class _DeviceMapState extends State<DeviceMap> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(56.667275626479274, 16.293136576664427),
    zoom: 17.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(56.667029872081166, 16.292616617169944),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Set<Marker> _markers = <Marker>{};

  final List<TestThing> _testThings = <TestThing>[
    TestThing(deviceName: "dist-10", lat: 56.667596, lng: 16.290749, id: "1"),
    TestThing(deviceName: "Weather-3", lat: 56.665387, lng: 16.291752, id: "2"),
  ];

  @override
  Widget build(BuildContext context) {
    _testThings.forEach((thing) {
      _markers
          .addLabelMarker(
        LabelMarker(
          label: thing.deviceName,
          textStyle: TextStyle(fontSize: 14, color: Colors.white),
          markerId: MarkerId(thing.id),
          position: LatLng(thing.lat, thing.lng),
          backgroundColor: Color.fromRGBO(96, 125, 139, 1),
          /* onTap: () {
              Navigator.of(context).restorablePush(_dialogBuilder);
            } */
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text("Device: ${thing.deviceName}"),
            ),
          ),
        ),
      )
          .then((value) {
        setState(() {});
      });
      ;
    });
    /* _markers
        .addLabelMarker(
      LabelMarker(
        label: "19.4C",
        textStyle: TextStyle(fontSize: 14),
        markerId: MarkerId("idString"),
        position: LatLng(56.667596, 16.290749),
        backgroundColor: Colors.green,
        /* onTap: () {
              Navigator.of(context).restorablePush(_dialogBuilder);
            } */
        onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Text("test"),
          ),
        ),
      ),
    )
        .then((value) {
      setState(() {});
    });
    ; */
    return Container(
      child: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
