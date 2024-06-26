import 'package:connector/core/common/theme/theme.dart';
import 'package:connector/features/insights/domain/entities/insight.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class InsightsView extends StatefulWidget {
  const InsightsView({super.key});

  @override
  State<InsightsView> createState() => _InsightsViewState();
}

class _InsightsViewState extends State<InsightsView> {
  late final List<Insight> insightDataDemo;

  @override
  void initState() {
    super.initState();
    var lineChartData = ThemeBuilder.getLineChartData(
      ctx: context,
      beforeAfterValueModifierBottom: ['', ''],
      beforeAfterValueModifierLeft: ['\$', 'k'],
      xAxisMax: 31,
      xAxisMin: 0,
      yAxisMax: 50,
      yAxisMin: 0,
      yAxisInterval: 10,
      xAxisInterval: 1,
      gradientColors: [
        Colors.blue.withOpacity(.4),
        Colors.green.withOpacity(.6)
      ],
      data: {
        0: 1,
        1: 2.4,
        2: 3.8,
        3: 4.9,
        4: 6.3,
        5: 7.8,
        6: 8.6,
        7: 7.4,
        8: 8.2,
        9: 9,
        10: 9.8,
        11: 11.2,
        12: 12.4,
        13: 13.8,
        14: 14.9,
        15: 16.3,
        16: 17.8,
        17: 18.6,
        18: 17.4,
        19: 18.2,
        20: 19,
        21: 21.2,
        22: 22.4,
        23: 23.8,
        24: 24.9,
        25: 26.3,
        26: 27.8,
        27: 28.6,
        28: 27.4,
        29: 28.2,
        30: 29,
        31: 31.2,
      },
    );
    insightDataDemo = [
      Insight(
        id: '1',
        title: 'Daily Active Users',
        description: 'This is the number of users who have logged in today.',
        mainValue: '4,934',
        changeValue: '+126%',
        changeColorHex: '0xFF4CAF50', // Green for growth
        chartData: lineChartData,
      ),
      Insight(
        id: '2',
        title: 'Revenue in June',
        description: 'Total revenue generated this month.',
        mainValue: '\$15,200',
        changeValue: '+34%',
        changeColorHex: '0xFF4CAF50', // Green for growth
        chartData: lineChartData,
      ),
      Insight(
        id: '3',
        title: 'New Signups',
        description: 'Number of new users who registered today.',
        mainValue: '789',
        changeValue: '+50%',
        changeColorHex: '0xFF4CAF50', // Green for growth
        chartData: lineChartData,
      ),
      Insight(
        id: '4',
        title: 'App Crashes',
        description: 'Number of times the app crashed today.',
        mainValue: '3',
        changeValue: '-75%',
        changeColorHex: '0xFF4CAF50', // Green for growth
        chartData: lineChartData,
      ),
      Insight(
        id: '5',
        title: 'Active Sessions',
        description: 'Average number of active sessions per user today.',
        mainValue: '2.4',
        changeValue: '+20%',
        changeColorHex: '0xFF4CAF50', // Green for growth
        chartData: lineChartData,
      ),
      Insight(
        id: '6',
        title: 'Average Session Length',
        description: 'Average length of a user session in minutes.',
        mainValue: '15 mins',
        changeValue: '+5%',
        changeColorHex: '0xFF4CAF50', // Green for growth
        chartData: lineChartData,
      ),
      Insight(
        id: '6',
        title: 'Average Session Length',
        description: 'Average length of a user session in minutes.',
        mainValue: '15 mins',
        changeValue: '+5%',
        changeColorHex: '0xFF4CAF50', // Green for growth\
        chartData: lineChartData,
      ),
      Insight(
        id: '7',
        title: 'Customer Satisfaction',
        description: 'Average customer satisfaction rating out of 5.',
        mainValue: '4.2',
        changeValue: '+0.1',
        changeColorHex: '0xFF4CAF50', // Green for growth
        chartData: lineChartData,
      ),
      Insight(
        id: '8',
        title: 'Conversion Rate',
        description: 'Percentage of users who made a purchase.',
        mainValue: '3.8%',
        changeValue: '+15%',
        changeColorHex: '0xFF4CAF50', // Green for growth
        chartData: lineChartData,
      ),
      Insight(
        id: '9',
        title: 'Churn Rate',
        description: 'Percentage of users who stopped using the app.',
        mainValue: '1.2%',
        changeValue: '-20%',
        changeColorHex: '0xFFE57373',
        chartData: lineChartData,
      ),
      Insight(
        id: '10',
        title: 'Page Views Per Visit',
        description: 'Average number of page views per visit.',
        mainValue: '8.4',
        changeValue: '+30%',
        changeColorHex: '0xFF4CAF50', // Green for growth
        chartData: lineChartData,
      ),
      Insight(
        id: '11',
        title: 'Retention Rate',
        description: 'Percentage of users returning after their first visit.',
        mainValue: '67%',
        changeValue: '+5%',
        changeColorHex: '0xFF4CAF50', // Green for growth
        chartData: lineChartData,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: GridView.builder(
            itemCount: 10,
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemBuilder: (context, index) {
              return InsightCard(
                insightData: insightDataDemo[index],
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.3,
            ),
          ),
        ),
      ],
    ));
  }
}

class InsightCard extends StatelessWidget {
  final Insight insightData;

  const InsightCard({
    super.key,
    required this.insightData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary,
            blurRadius: 15.5,
            offset: const Offset(0, 6),
            // spreadRadius: 0,
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        insightData.mainValue ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        insightData.changeValue ?? '',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Color(
                                    int.tryParse(insightData.changeColorHex!) ??
                                        0xFFFFFFFF,
                                  ),
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // Chart
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: insightData.chartData != null
                          ? LineChart(
                              duration: const Duration(milliseconds: 2500),
                              insightData.chartData!,
                            )
                          : const SizedBox.shrink(),
                    ),
                  )
                ],
              ),
            ),
            Text(
              insightData.title,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
