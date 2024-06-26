import 'package:fl_chart/fl_chart.dart';

class Insight {
  final String id;
  final String title;
  final String? description;
  final String? mainValue;
  final String? changeValue;
  final String? changeColorHex;
  final LineChartData? chartData;

  const Insight({
    required this.id,
    required this.title,
    this.description,
    this.mainValue,
    this.changeValue,
    this.changeColorHex,
    this.chartData,
  });
}
