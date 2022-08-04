import 'package:flutter/material.dart';

class SensorDialog extends StatefulWidget {
  const SensorDialog({required this.props, required this.selectProp, Key? key})
      : super(key: key);

  final Map<String, dynamic> props;
  final void Function(String?) selectProp;

  @override
  State<SensorDialog> createState() => _SensorDialogState();
}

class _SensorDialogState extends State<SensorDialog> {
  int selectedProp = 0;
  _createListTile() {}

  List<Widget> createSensorProps(Map<String, dynamic>? props) {
    List<Widget> widgetList = <Widget>[];

    props!.entries.forEach((element) {
      if (element.key != "dateObserved") {
        widgetList.add(
            /*  Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              /* crossAxisAlignment: CrossAxisAlignment.start, */
              children: [
                Radio(
                  value: widgetList.length,
                  groupValue: selectedProp,
                  onChanged: (int? val) {
                    setState(() {
                      selectedProp = val!;
                    });
                    widget.selectProp(element.key);
                  },
                ),
                Expanded(child: Text(element.key))
              ],
            ),
          ), */
            ListTile(
          minVerticalPadding: 0,
          title: Text(element.key),
          trailing: Radio(
            activeColor: Color.fromRGBO(96, 125, 139, 1),
            groupValue: selectedProp,
            value: widgetList.length,
            onChanged: (int? val) {
              setState(() {
                selectedProp = val!;
              });
              widget.selectProp(element.key);
            },
          ),
        ));
        widgetList.add(Divider(
          color: Color.fromRGBO(96, 125, 139, 1),
          thickness: 2,
        ));
      }
    });

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[200],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Select Sensor Value',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
              ),
              Container(
                margin: const EdgeInsets.only(top: 24, right: 24, bottom: 10),
                width: 25,
                height: 25,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(96, 125, 139, 1)),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Center(
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          for (var wid in createSensorProps(widget.props)) wid,
          Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                    width: 160,
                    height: 40,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(96, 125, 139, 1),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: const Center(
                      child: Text('Select Sensor',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
