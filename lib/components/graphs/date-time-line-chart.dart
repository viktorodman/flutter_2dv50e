import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_2dv50e/models/graph-data.dart';

class DateTimeLineChart extends StatelessWidget {
  final List<Value> data;

  DateTimeLineChart({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Value, DateTime>> seriesHumid = [
      charts.Series(
          id: "humidity",
          data: data,
          domainFn: (Value series, _) => series.created,
          measureFn: (Value series, _) => series.humidity,
          colorFn: (Value series, _) => charts.Color.black),
    ];
    List<charts.Series<Value, DateTime>> seriesTemp = [
      charts.Series(
          id: "temperature",
          data: data,
          domainFn: (Value series, _) => series.created,
          measureFn: (Value series, _) => series.temperature,
          colorFn: (Value series, _) => charts.Color.black),
    ];

    List<charts.Series<Value, DateTime>> seriesPressure = [
      charts.Series(
          id: "pressure",
          data: data,
          domainFn: (Value series, _) => series.created,
          measureFn: (Value series, _) => series.pressure,
          colorFn: (Value series, _) => charts.Color.black)
    ];

    return Expanded(
      child: Row(
        children: [
          ChartData(seriesPressure: seriesTemp, title: "Temperature"),
          ChartData(seriesPressure: seriesHumid, title: "Humidity"),
          ChartData(seriesPressure: seriesPressure, title: 'Pressure'),
        ],
      ),
    );
  }
}

class ChartData extends StatelessWidget {
  const ChartData({
    Key? key,
    required this.seriesPressure,
    required this.title,
  }) : super(key: key);

  final List<charts.Series<Value, DateTime>> seriesPressure;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(title),
          Expanded(
            child: Card(
              margin: EdgeInsets.all(10),
              child: charts.TimeSeriesChart(
                seriesPressure,
                animate: true,
                defaultRenderer: charts.LineRendererConfig(),
                // Custom renderer configuration for the point series.
                customSeriesRenderers: [
                  charts.PointRendererConfig(customRendererId: 'customPoint')
                ],
                dateTimeFactory: const charts.LocalDateTimeFactory(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
