import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';

import '../../core/database/activity_record.dart';
import '../../core/database/database_service.dart';

class HistoryPoint {
  const HistoryPoint({required this.date, required this.steps});
  final DateTime date;
  final int steps;
}

/// Reads already-persisted ActivityRecords rather than recomputing
/// anything — DashboardController is the only writer, so History just
/// asks Isar for the last N days and shapes them for the chart widgets.
class HistoryController {
  HistoryController(this._isar);
  final Isar _isar;

  Future<List<HistoryPoint>> lastDays(int count) async {
    final today = ActivityRecord.dayEpochFor(DateTime.now());
    final from = today - (count - 1);

    final records = await _isar.activityRecords
        .filter()
        .dayEpochGreaterThan(from - 1)
        .findAll();

    final byEpoch = {for (final r in records) r.dayEpoch: r};

    return [
      for (var epoch = from; epoch <= today; epoch++)
        HistoryPoint(
          date: ActivityRecord.dateFromEpoch(epoch),
          steps: byEpoch[epoch]?.steps ?? 0,
        ),
    ];
  }
}

final historyControllerProvider = Provider<HistoryController>((ref) {
  return HistoryController(ref.watch(isarProvider));
});

final weeklyHistoryProvider = FutureProvider<List<HistoryPoint>>((ref) {
  return ref.watch(historyControllerProvider).lastDays(7);
});

final monthlyHistoryProvider = FutureProvider<List<HistoryPoint>>((ref) {
  return ref.watch(historyControllerProvider).lastDays(30);
});
