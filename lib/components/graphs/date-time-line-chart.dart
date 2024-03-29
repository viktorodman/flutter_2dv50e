import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class PointsLineChart extends StatelessWidget {
  final List<charts.Series<dynamic, DateTime>> seriesList;
  final String propTitle;
  final bool animate;
  final String firstTitle;
  final String secondTitle;

  PointsLineChart(this.seriesList,
      {required this.firstTitle,
      required this.secondTitle,
      required this.animate,
      required this.propTitle});

  /// Creates a [LineChart] with sample data and no transition.
  factory PointsLineChart.withSampleData() {
    return new PointsLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
      propTitle: "test",
      firstTitle: "Start title",
      secondTitle: "End title",
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      behaviors: [
        charts.ChartTitle(firstTitle,
            behaviorPosition: charts.BehaviorPosition.start,
            titleStyleSpec: charts.TextStyleSpec(
              color: charts.Color.fromHex(code: '#3a1eeb'),
            ),
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
        charts.ChartTitle(secondTitle,
            behaviorPosition: charts.BehaviorPosition.end,
            titleStyleSpec: charts.TextStyleSpec(
              color: charts.Color.fromHex(code: '#cf2f1d'),
            ),
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
      ],
      primaryMeasureAxis: charts.NumericAxisSpec(
          tickProviderSpec:
              const charts.BasicNumericTickProviderSpec(desiredTickCount: 5)),
      secondaryMeasureAxis: charts.NumericAxisSpec(
          tickProviderSpec:
              charts.BasicNumericTickProviderSpec(desiredTickCount: 5)),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<DeviceSensorData, DateTime>> _createSampleData() {
    final globalSalesData = [
      DeviceSensorData(DateTime(2014), 5000),
      DeviceSensorData(DateTime(2015), 25000),
      DeviceSensorData(DateTime(2016), 100000),
      DeviceSensorData(DateTime(2017), 750000),
      DeviceSensorData(DateTime(2018), 750000),
      DeviceSensorData(DateTime(2019), 750000),
      DeviceSensorData(DateTime(2020), 750000),
    ];

    final losAngelesSalesData = [
      DeviceSensorData(DateTime(2013), 10),
      DeviceSensorData(DateTime(2014), 20),
      DeviceSensorData(DateTime(2015), 30),
      DeviceSensorData(DateTime(2016), 40),
      DeviceSensorData(DateTime(2017), 50),
    ];

    return [
      charts.Series<DeviceSensorData, DateTime>(
        id: 'first device',
        domainFn: (DeviceSensorData device, _) => device.date,
        measureFn: (DeviceSensorData device, _) => device.data,
        data: globalSalesData,
      ),
      charts.Series<DeviceSensorData, DateTime>(
        id: 'second device',
        domainFn: (DeviceSensorData device, _) => device.date,
        measureFn: (DeviceSensorData device, _) => device.data,
        data: losAngelesSalesData,
      )..setAttribute(
          charts.measureAxisIdKey, charts.Axis.secondaryMeasureAxisId)
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}

class DeviceSensorData {
  final DateTime date;
  final double data;

  DeviceSensorData(this.date, this.data);
}
