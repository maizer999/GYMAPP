import '../constants/defaults.dart';

/// Deterministic, fully offline step → distance/calorie conversions.
/// No network call and no third-party estimation service — everything
/// here is a published formula, which is what lets the app work with
/// zero backend dependency (per the architecture's "offline-first" goal).
class HealthCalculations {
  HealthCalculations._();

  /// Height-based stride estimate (Grieve & Gear, widely used in pedometer
  /// apps as a lightweight approximation): roughly 0.413 × height for
  /// women, 0.415 × height for men. Without a stated sex on file, this
  /// uses the midpoint multiplier — good enough for an MVP; a future
  /// Settings field could refine it per-user.
  static double strideLengthFor({required double heightCm}) {
    const multiplier = 0.414;
    final strideCm = heightCm * multiplier;
    return strideCm / 100; // → meters
  }

  static double distanceMeters({
    required int steps,
    double strideLengthMeters = Defaults.averageStrideMeters,
  }) {
    return steps * strideLengthMeters;
  }

  /// Calories burned via the standard MET formula:
  ///   kcal = MET × weight(kg) × duration(hours)
  /// Duration is derived from steps at an assumed cadence (steps/min)
  /// rather than wall-clock time, since the pedometer stream gives a
  /// cumulative count, not a session duration.
  static double activeCalories({
    required int steps,
    required double weightKg,
    double met = Defaults.walkingMet,
    double stepsPerMinute = 100,
  }) {
    if (steps <= 0) return 0;
    final minutes = steps / stepsPerMinute;
    final hours = minutes / 60;
    return met * weightKg * hours;
  }

  static double metersToKilometers(double meters) => meters / 1000;

  static double metersToMiles(double meters) => meters / 1609.344;
}
