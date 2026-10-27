import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';

import '../../core/database/activity_record.dart';
import '../../core/database/database_service.dart';
import '../../core/database/user_profile.dart';
import 'milestone_definitions.dart';

class MilestoneProgress {
  const MilestoneProgress({
    required this.definition,
    required this.achieved,
    required this.currentValue,
  });

  final MilestoneDefinition definition;
  final bool achieved;
  final int currentValue;
}

/// Recomputes every badge's achieved/locked state from raw
/// ActivityRecord history on each read — there is no "achievements"
/// table to keep in sync, which means a badge can never drift out of
/// sync with the underlying step data.
class MilestonesController {
  MilestonesController(this._isar);
  final Isar _isar;

  Future<List<MilestoneProgress>> computeAll() async {
    final records = await _isar.activityRecords
        .where()
        .sortByDayEpoch()
        .findAll();
    final profile = await _isar.userProfiles.get(0) ?? UserProfile();

    final totalSteps = records.fold<int>(0, (sum, r) => sum + r.steps);
    final bestSingleDay =
        records.fold<int>(0, (max, r) => r.steps > max ? r.steps : max);

    final currentStreak = _longestTrailingStreak(records, profile.dailyStepGoal);

    return [
      for (final def in kMilestones)
        MilestoneProgress(
          definition: def,
          currentValue: switch (def.metric) {
            MilestoneMetric.totalSteps => totalSteps,
            MilestoneMetric.singleDayGoal => bestSingleDay,
            MilestoneMetric.streakDays => currentStreak,
          },
          achieved: switch (def.metric) {
            MilestoneMetric.totalSteps => totalSteps >= def.threshold,
            MilestoneMetric.singleDayGoal =>
              bestSingleDay >= profile.dailyStepGoal,
            MilestoneMetric.streakDays => currentStreak >= def.threshold,
          },
        ),
    ];
  }

  /// Longest run of consecutive days (anywhere in history, not just
  /// ending today) where steps met that day's goal. A simple pass is
  /// enough here since a user's full history is small (one row/day).
  int _longestTrailingStreak(List<ActivityRecord> records, int goal) {
    if (records.isEmpty) return 0;

    var longest = 0;
    var current = 0;
    int? previousEpoch;

    for (final record in records) {
      final isConsecutive =
          previousEpoch == null || record.dayEpoch == previousEpoch + 1;
      final metGoal = record.steps >= goal;

      if (isConsecutive && metGoal) {
        current += 1;
      } else {
        current = metGoal ? 1 : 0;
      }

      longest = current > longest ? current : longest;
      previousEpoch = record.dayEpoch;
    }

    return longest;
  }
}

final milestonesControllerProvider = Provider<MilestonesController>((ref) {
  return MilestonesController(ref.watch(isarProvider));
});

final milestonesProvider = FutureProvider<List<MilestoneProgress>>((ref) {
  return ref.watch(milestonesControllerProvider).computeAll();
});
