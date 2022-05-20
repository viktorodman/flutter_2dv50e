import 'package:flutter/material.dart';

class DeviceInfoButton extends StatefulWidget {
  final String deviceName;
  final Future<Null> Function(double? lat, double? lng, String? desc) onUpdate;
  final double? currentLat;
  final double? currentLng;
  final String? description;
  const DeviceInfoButton({
    required this.deviceName,
    required this.currentLat,
    required this.currentLng,
    required this.onUpdate,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  State<DeviceInfoButton> createState() => _DeviceInfoButtonState();
}

class _DeviceInfoButtonState extends State<DeviceInfoButton> {
  late TextEditingController _latController;
  late TextEditingController _lngController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    _latController = TextEditingController(
        text: widget.currentLat == null ? "" : widget.currentLat.toString());

    _lngController = TextEditingController(
        text: widget.currentLng == null ? "" : widget.currentLng.toString());

    _descriptionController = TextEditingController(
        text: widget.description == null ? "" : widget.description.toString());
  }

  @override
  void dispose() {
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        width: 100,
        child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(96, 125, 139, 1)),
            onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(
                      "Device: ${widget.deviceName}",
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Latitude"),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: "Lat",
                              border: OutlineInputBorder(),
                            ),
                            controller: _latController,
                          ),
                        ),
                        const Text("Longitude"),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: TextField(
                            decoration: const InputDecoration(
                                labelText: "Lng", border: OutlineInputBorder()),
                            controller: _lngController,
                          ),
                        ),
                        const Text("Description"),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: TextField(
                            decoration: const InputDecoration(
                                labelText: "", border: OutlineInputBorder()),
                            controller: _descriptionController,
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          double convertedLng =
                              double.parse(_lngController.text);
                          double convertedLat =
                              double.parse(_latController.text);

                          widget.onUpdate(convertedLat, convertedLng,
                              _descriptionController.text);
                          Navigator.pop(context, 'Ok');
                        },
                        child: const Text("Uppdatera"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context, 'Avbryt');
                        },
                        child: const Text("Avbryt"),
                      ),
                    ],
                  ),
                ),
            icon: const Icon(Icons.sensors),
            label: const Text("info")),
      ),
    );
  }
}
