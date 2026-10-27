import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/defaults.dart';
import '../../core/utils/health_calculations.dart';
import 'history_controller.dart';

class DayDetailPage extends StatelessWidget {
  const DayDetailPage({super.key, required this.day});

  final HistoryDay day;

  @override
  Widget build(BuildContext context) {
    final isToday = DateUtils.isSameDay(day.date, DateTime.now());
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final isYesterday = DateUtils.isSameDay(day.date, yesterday);

    final weekdayAr = _arabicWeekday(day.date.weekday);
    final title = isToday
        ? 'اليوم'
        : isYesterday
            ? 'الأمس'
            : weekdayAr;
    final subtitle = DateFormat('d MMMM yyyy', 'ar').format(day.date);

    final progress =
        (day.steps / Defaults.dailyStepGoal).clamp(0.0, 1.0).toDouble();
    final distanceKm =
        HealthCalculations.metersToKilometers(day.distanceMeters);
    final peakHour = _peakHour(day.hourlySteps);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.w700)),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            _HeroCard(
              subtitle: subtitle,
              steps: day.steps,
              progress: progress,
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _MetricTile(
                    icon: Icons.route_rounded,
                    color: AppColors.cyanSoft,
                    label: 'المسافة',
                    value: distanceKm.toStringAsFixed(2),
                    unit: 'كم',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MetricTile(
                    icon: Icons.local_fire_department_rounded,
                    color: AppColors.live,
                    label: 'السعرات',
                    value: day.activeCalories.toStringAsFixed(0),
                    unit: 'سعرة',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (peakHour != null) ...[
              _PeakHourTag(hour: peakHour, steps: day.hourlySteps[peakHour]),
              const SizedBox(height: 14),
            ],
            const Padding(
              padding: EdgeInsets.only(right: 4, bottom: 10),
              child: Text(
                'تفاصيل كل ساعة',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _HourlyList(hourlySteps: day.hourlySteps),
          ],
        ),
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.subtitle,
    required this.steps,
    required this.progress,
  });

  final String subtitle;
  final int steps;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.cyan, AppColors.greenSoft],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyan.withOpacity(0.25),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 92,
            height: 92,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 92,
                  height: 92,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 8,
                    backgroundColor: Colors.white.withOpacity(0.18),
                    valueColor: const AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
                Text(
                  '${(progress * 100).round()}%',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  NumberFormat.decimalPattern('ar').format(steps),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'خطوة من ${NumberFormat.decimalPattern('ar').format(Defaults.dailyStepGoal)}',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
    required this.unit,
  });

  final IconData icon;
  final Color color;
  final String label;
  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                RichText(
                  text: TextSpan(
                    text: value,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                    children: [
                      TextSpan(
                        text: ' $unit',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PeakHourTag extends StatelessWidget {
  const _PeakHourTag({required this.hour, required this.steps});

  final int hour;
  final int steps;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.greenSoft.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.greenSoft.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.bolt_rounded,
              color: AppColors.greenSoft, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'الذروة في الساعة ${_hourLabel(hour)} · ${NumberFormat.decimalPattern('ar').format(steps)} خطوة',
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HourlyList extends StatelessWidget {
  const _HourlyList({required this.hourlySteps});

  final List<int> hourlySteps;

  @override
  Widget build(BuildContext context) {
    final maxValue =
        hourlySteps.fold<int>(0, (a, b) => a > b ? a : b).toDouble();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          for (var h = 0; h < 24; h++) ...[
            _HourRow(
              hour: h,
              steps: hourlySteps[h],
              fraction:
                  maxValue == 0 ? 0 : hourlySteps[h] / maxValue,
            ),
            if (h < 23)
              Divider(
                height: 1,
                color: Colors.white.withOpacity(0.04),
              ),
          ],
        ],
      ),
    );
  }
}

class _HourRow extends StatelessWidget {
  const _HourRow({
    required this.hour,
    required this.steps,
    required this.fraction,
  });

  final int hour;
  final int steps;
  final double fraction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: 54,
            child: Text(
              _hourLabel(hour),
              style: TextStyle(
                color: steps > 0
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Stack(
                children: [
                  Container(
                    height: 8,
                    color: AppColors.ringTrack,
                  ),
                  FractionallySizedBox(
                    widthFactor: fraction.clamp(0.0, 1.0),
                    child: Container(
                      height: 8,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.cyan, AppColors.greenSoft],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 56,
            child: Text(
              NumberFormat.decimalPattern('ar').format(steps),
              textAlign: TextAlign.end,
              style: TextStyle(
                color: steps > 0
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _arabicWeekday(int weekday) {
  const names = [
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
    'الأحد',
  ];
  return names[weekday - 1];
}

String _hourLabel(int hour) {
  return '${hour.toString().padLeft(2, '0')}:00';
}

int? _peakHour(List<int> hourly) {
  var best = -1;
  var bestVal = 0;
  for (var i = 0; i < hourly.length; i++) {
    if (hourly[i] > bestVal) {
      bestVal = hourly[i];
      best = i;
    }
  }
  return best < 0 ? null : best;
}
