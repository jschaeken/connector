import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeBuilder {
  static ThemeData get lightTheme => ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromARGB(255, 5, 109, 0),
          onPrimary: Color(0xFFFFFFFF),
          primaryContainer: Color.fromARGB(255, 0, 179, 39),
          onPrimaryContainer: Color(0xFFFFFFFF),
          secondary: Color(0xFF03DAC6),
          onSecondary: Color(0xFF000000),
          secondaryContainer: Color(0xFF018786),
          onSecondaryContainer: Color(0xFF000000),
          tertiary: Color(0xFF03DAC6),
          onTertiary: Color(0xFF000000),
          tertiaryContainer: Colors.white,
          error: Color.fromARGB(255, 255, 107, 97),
          onError: Colors.white,
          surface: Color.fromARGB(255, 255, 255, 255),
          onSurface: Colors.black,
        ),
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(),
      );

  static ThemeData get darkTheme => ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color.fromARGB(255, 0, 107, 194),
          onPrimary: Color(0xFF000000),
          primaryContainer: Color(0xFF3700B3),
          onPrimaryContainer: Color(0xFFFFFFFF),
          secondary: Color(0xFF03DAC6),
          onSecondary: Color.fromARGB(255, 174, 113, 113),
          secondaryContainer: Color(0xFF018786),
          onSecondaryContainer: Color(0xFF000000),
          tertiary: Color(0xFF03DAC6),
          onTertiary: Color(0xFF000000),
          tertiaryContainer: Colors.white,
          error: Color.fromARGB(255, 255, 107, 97),
          onError: Colors.white,
          // Background
          surface: Color.fromARGB(255, 0, 0, 0),
          onSurface: Colors.white,
        ),
        textTheme: GoogleFonts.jetBrainsMonoTextTheme(),
      );

  static LineChartData getLineChartData({
    required BuildContext ctx,
    required int xAxisMax,
    required int xAxisMin,
    required int yAxisMax,
    required int yAxisMin,
    required double yAxisInterval,
    required double xAxisInterval,
    required Map<int, double> data,
    List<String> beforeAfterValueModifierLeft = const ['', ''],
    List<String> beforeAfterValueModifierBottom = const ['', ''],
    List<Color> gradientColors = const [Colors.green, Colors.blue],
  }) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 5,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Theme.of(ctx).colorScheme.onSurface,
            strokeWidth: .2,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Theme.of(ctx).colorScheme.onSurface,
            strokeWidth: .2,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: xAxisInterval,
              getTitlesWidget: (value, x) {
                return Text(
                  '${beforeAfterValueModifierBottom[0]}${value.toInt()}${beforeAfterValueModifierBottom[1]}',
                  style: TextStyle(
                    color: Theme.of(ctx).colorScheme.primary,
                    fontSize: 10,
                  ),
                );
              }),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: yAxisInterval,
            getTitlesWidget: (value, x) {
              return Text(
                '${beforeAfterValueModifierLeft[0]}${value.toInt()}${beforeAfterValueModifierLeft[1]}', // Multiplying each step by the interval to reflect thousands in revenue
                style: TextStyle(
                  color: Theme.of(ctx).colorScheme.primary,
                  fontSize: 10,
                ),
              );
            },
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: xAxisMin.toDouble(),
      maxX: xAxisMax.toDouble(),
      minY: yAxisMin.toDouble(),
      maxY: yAxisMax.toDouble(),
      lineBarsData: [
        LineChartBarData(
          spots: data.entries
              .map((e) => FlSpot(e.key.toDouble(), e.value))
              .toList(),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 1.5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
              show: true, gradient: LinearGradient(colors: gradientColors)),
        ),
      ],
    );
  }
}
