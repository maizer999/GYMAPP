import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';

import '../../core/database/activity_record.dart';
import '../../core/database/database_service.dart';

class HistoryDay {
  const HistoryDay({
    required this.date,
    required this.steps,
    required this.distanceMeters,
    required this.activeCalories,
    required this.hourlySteps,
  });

  final DateTime date;
  final int steps;
  final double distanceMeters;
  final double activeCalories;
  final List<int> hourlySteps;

  factory HistoryDay.empty(DateTime date) => HistoryDay(
        date: date,
        steps: 0,
        distanceMeters: 0,
        activeCalories: 0,
        hourlySteps: List<int>.filled(24, 0),
      );
}

/// Reads already-persisted ActivityRecords rather than recomputing
/// anything — DashboardController is the only writer, so History just
/// asks Isar for the last N days and shapes them for the chart widgets.
class HistoryController {
  HistoryController(this._isar);
  final Isar _isar;

  Future<List<HistoryDay>> recentDays(int count) async {
    final today = ActivityRecord.dayEpochFor(DateTime.now());
    final from = today - (count - 1);

    final records = await _isar.activityRecords
        .filter()
        .dayEpochGreaterThan(from - 1)
        .findAll();

    final byEpoch = {for (final r in records) r.dayEpoch: r};

    final days = <HistoryDay>[];
    for (var epoch = today; epoch >= from; epoch--) {
      final r = byEpoch[epoch];
      final date = ActivityRecord.dateFromEpoch(epoch);
      days.add(
        r == null
            ? HistoryDay.empty(date)
            : HistoryDay(
                date: date,
                steps: r.steps,
                distanceMeters: r.distanceMeters,
                activeCalories: r.activeCalories,
                hourlySteps: r.hourlySteps,
              ),
      );
    }
    return days;
  }
}

final historyControllerProvider = Provider<HistoryController>((ref) {
  return HistoryController(ref.watch(isarProvider));
});

final recentDaysProvider = FutureProvider<List<HistoryDay>>((ref) {
  return ref.watch(historyControllerProvider).recentDays(60);
});
