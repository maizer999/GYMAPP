import 'package:isar_community/isar.dart';

part 'activity_record.g.dart';

/// One record per calendar day. The pedometer stream gives a running
/// cumulative count since boot/last-reset, so DashboardController reduces
/// that into a daily delta and upserts it here — this is what makes
/// history/weekly/monthly charts possible without re-querying the OS.
@collection
class ActivityRecord {
  Id id = Isar.autoIncrement;

  /// Stored as days-since-epoch (not a DateTime) so there's exactly one
  /// record per day and @Index(unique:true) can enforce that at the DB
  /// level instead of relying on application logic to avoid duplicates.
  @Index(unique: true, replace: true)
  late int dayEpoch;

  late int steps;
  late double distanceMeters;
  late double activeCalories;

  /// Hour-by-hour step deltas (24 entries, index = hour of day) — backs
  /// the dashboard's 24-hour bar chart without needing a separate table.
  List<int> hourlySteps = List.filled(24, 0);

  DateTime updatedAt = DateTime.now();

  static int dayEpochFor(DateTime date) {
    final utcMidnight = DateTime.utc(date.year, date.month, date.day);
    return utcMidnight.millisecondsSinceEpoch ~/ (1000 * 60 * 60 * 24);
  }

  static DateTime dateFromEpoch(int dayEpoch) {
    return DateTime.fromMillisecondsSinceEpoch(
      dayEpoch * 1000 * 60 * 60 * 24,
      isUtc: true,
    );
  }
}
