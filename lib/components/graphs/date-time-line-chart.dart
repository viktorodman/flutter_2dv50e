import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class PointsLineChart extends StatelessWidget {
  final List<charts.Series<dynamic, DateTime>> seriesList;
  final bool animate;

  PointsLineChart(this.seriesList, {required this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory PointsLineChart.withSampleData() {
    return new PointsLineChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      /* defaultRenderer: new charts.LineRendererConfig(includePoints: true) */
      primaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec:
              new charts.BasicNumericTickProviderSpec(desiredTickCount: 5)),
      secondaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec:
              new charts.BasicNumericTickProviderSpec(desiredTickCount: 5)),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, DateTime>> _createSampleData() {
    final globalSalesData = [
      new OrdinalSales(DateTime(2014), 5000),
      new OrdinalSales(DateTime(2015), 25000),
      new OrdinalSales(DateTime(2016), 100000),
      new OrdinalSales(DateTime(2017), 750000),
    ];

    final losAngelesSalesData = [
      new OrdinalSales(DateTime(2014), 25),
      new OrdinalSales(DateTime(2015), 50),
      new OrdinalSales(DateTime(2016), 10),
      new OrdinalSales(DateTime(2017), 20),
    ];

    return [
      new charts.Series<OrdinalSales, DateTime>(
        id: 'Global Revenue',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: globalSalesData,
      ),
      new charts.Series<OrdinalSales, DateTime>(
        id: 'Los Angeles Revenue',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
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

class OrdinalSales {
  final DateTime year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
