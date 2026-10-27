import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health/health.dart';

/// Optional sync layer against Apple HealthKit / Google Health Connect.
/// Deliberately best-effort: the app's own pedometer stream + local Isar
/// storage is the source of truth for the MVP, so if HealthKit/Health
/// Connect authorization is denied or the plugin throws on an
/// unsupported device, callers should treat `false`/`null` as "just use
/// the local step count" rather than a hard failure.
class HealthService {
  final Health _health = Health();

  static const _types = [
    HealthDataType.STEPS,
    HealthDataType.DISTANCE_WALKING_RUNNING,
    HealthDataType.ACTIVE_ENERGY_BURNED,
  ];

  Future<bool> configure() async {
    try {
      await _health.configure();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<bool> requestAuthorization() async {
    try {
      return await _health.requestAuthorization(_types);
    } catch (_) {
      return false;
    }
  }

  /// Returns the platform's own step total for [date] if available, or
  /// null if unauthorized/unsupported — callers fall back to the local
  /// pedometer-derived count in that case.
  Future<int?> stepsForDate(DateTime date) async {
    try {
      final midnight = DateTime(date.year, date.month, date.day);
      final nextMidnight = midnight.add(const Duration(days: 1));

      final steps = await _health.getTotalStepsInInterval(
        midnight,
        nextMidnight,
      );

      return steps;
    } catch (_) {
      return null;
    }
  }

  /// 24 hourly buckets of steps for [date]. Returns null if the platform
  /// store is unavailable or unauthorized — callers should fall back to
  /// their local hourly tally. This is what lets us reconstruct steps
  /// taken while the app was backgrounded or killed on iOS, since
  /// HealthKit keeps counting 24/7 even when our process isn't running.
  Future<List<int>?> hourlyStepsForDate(DateTime date) async {
    try {
      final midnight = DateTime(date.year, date.month, date.day);
      final buckets = List<int>.filled(24, 0);
      for (var hour = 0; hour < 24; hour++) {
        final start = midnight.add(Duration(hours: hour));
        final end = start.add(const Duration(hours: 1));
        final steps = await _health.getTotalStepsInInterval(start, end);
        buckets[hour] = steps ?? 0;
      }
      return buckets;
    } catch (_) {
      return null;
    }
  }
}

final healthServiceProvider = Provider<HealthService>((ref) {
  return HealthService();
});
