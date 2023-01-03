/// Bar chart example
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_web_dashbard/controllers/product_controller.dart';
import 'package:get/get.dart';

class SimpleBarChart extends StatelessWidget {
  final bool animate;

  const SimpleBarChart({
    required this.animate,
    super.key,
  });

  /// Creates a [BarChart] with sample data and no transition.
  // factory SimpleBarChart.withSampleData() {
  //   return SimpleBarChart(
  //     _createSampleData(controller),
  //     // Disable animations for image tests.
  //     animate: true,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(
      builder: (controller) => charts.BarChart(
        _createSampleData(controller),
        animate: animate,
      ),
    );
  }

  static String date(int preMonth) =>
      '${DateTime(DateTime.now().year, DateTime.now().month - preMonth, DateTime.now().day)}'
          .substring(0, 7);

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData(
    ProductController controller,
  ) {
    final data = [
      OrdinalSales(date(3), controller.salaryLast3Month),
      OrdinalSales(date(2), controller.salaryLast2Month),
      OrdinalSales(date(1), controller.salaryLastMonth),
      OrdinalSales(date(0), controller.salaryThisMonth),
    ];

    return [
      charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
