import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

/// 24 bars, one per hour, showing today's step distribution so far.
/// Horizontally scrollable so every hour label (0–23) fits without crowding.
class HourlyChart extends StatelessWidget {
  const HourlyChart({super.key, required this.hourlySteps});

  final List<int> hourlySteps;

  static const double _hourWidth = 28;

  @override
  Widget build(BuildContext context) {
    final maxValue = hourlySteps.isEmpty
        ? 1.0
        : hourlySteps.reduce((a, b) => a > b ? a : b).toDouble();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: hourlySteps.length * _hourWidth,
        child: BarChart(
          BarChartData(
            maxY: maxValue == 0 ? 10 : maxValue * 1.2,
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              leftTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 24,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        '${value.toInt()}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            barGroups: [
              for (var hour = 0; hour < hourlySteps.length; hour++)
                BarChartGroupData(
                  x: hour,
                  barRods: [
                    BarChartRodData(
                      toY: hourlySteps[hour].toDouble(),
                      color: AppColors.stepsColor,
                      width: 6,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
