import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class PointsLineChart extends StatelessWidget {
  final List<charts.Series<dynamic, DateTime>> seriesList;
  final String propTitle;
  final bool animate;

  PointsLineChart(this.seriesList,
      {required this.animate, required this.propTitle});

  /// Creates a [LineChart] with sample data and no transition.
  factory PointsLineChart.withSampleData() {
    return new PointsLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
      propTitle: "test",
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      behaviors: [
        charts.ChartTitle('Start title',
            behaviorPosition: charts.BehaviorPosition.start,
            titleStyleSpec: charts.TextStyleSpec(
              color: charts.Color.fromHex(code: '#3a1eeb'),
            ),
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
        charts.ChartTitle('End title',
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
        id: 'Global Revenue',
        domainFn: (DeviceSensorData sales, _) => sales.year,
        measureFn: (DeviceSensorData sales, _) => sales.sales,
        data: globalSalesData,
      ),
      charts.Series<DeviceSensorData, DateTime>(
        id: 'Los Angeles Revenue',
        domainFn: (DeviceSensorData sales, _) => sales.year,
        measureFn: (DeviceSensorData sales, _) => sales.sales,
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
  final DateTime year;
  final double sales;

  DeviceSensorData(this.year, this.sales);
}
