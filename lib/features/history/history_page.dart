import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/constants/app_colors.dart';
import 'history_controller.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
            child: Text(
              'History',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.primary,
            tabs: const [
              Tab(text: 'Weekly'),
              Tab(text: 'Monthly'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _HistoryChart(provider: weeklyHistoryProvider, dateFormat: 'E'),
                _HistoryChart(provider: monthlyHistoryProvider, dateFormat: 'd'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryChart extends ConsumerWidget {
  const _HistoryChart({required this.provider, required this.dateFormat});

  final ProviderListenable<AsyncValue<List<HistoryPoint>>> provider;
  final String dateFormat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pointsAsync = ref.watch(provider);

    return pointsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text('Could not load history: $err')),
      data: (points) {
        if (points.every((p) => p.steps == 0)) {
          return const Center(
            child: Text(
              'No steps recorded yet for this period.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          );
        }

        final maxValue = points
            .map((p) => p.steps)
            .fold<int>(0, (a, b) => a > b ? a : b)
            .toDouble();
        final formatter = DateFormat(dateFormat);
        // Skip some labels on the monthly (30-bar) view so they don't
        // overlap — weekly (7 bars) can show every label.
        final labelStride = points.length > 10 ? 5 : 1;

        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
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
                    reservedSize: 28,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index % labelStride != 0 || index >= points.length) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          formatter.format(points[index].date),
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
                for (var i = 0; i < points.length; i++)
                  BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: points[i].steps.toDouble(),
                        color: AppColors.stepsColor,
                        width: points.length > 10 ? 6 : 14,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
