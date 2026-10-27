/// Default values used until the user fills in their own profile
/// (Settings feature) or overrides a daily target. Keeping these in one
/// place means HealthCalculations, Settings, and the Dashboard ring all
/// agree on the same starting assumptions.
class Defaults {
  Defaults._();

  static const int dailyStepGoal = 10000;

  // Average adult stride length in meters — used to estimate distance
  // from step count until the user enters their real height (which
  // HealthCalculations uses to derive a more personal stride length).
  static const double averageStrideMeters = 0.762;

  static const double defaultHeightCm = 170;
  static const double defaultWeightKg = 70;

  // MET (Metabolic Equivalent of Task) value for brisk walking — the
  // baseline HealthCalculations uses for calorie burn when no faster
  // cadence data is available.
  static const double walkingMet = 3.5;
}
