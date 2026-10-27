import 'package:isar_community/isar.dart';
import '../constants/defaults.dart';

part 'user_profile.g.dart';

/// Single-row "table" — the app is single-user and local-only, so there's
/// always exactly one UserProfile (id fixed at 0). Settings reads/writes
/// this directly instead of going through a repository abstraction that
/// would be overkill for one row.
@collection
class UserProfile {
  Id id = 0;

  double heightCm = Defaults.defaultHeightCm;
  double weightKg = Defaults.defaultWeightKg;
  int dailyStepGoal = Defaults.dailyStepGoal;

  /// Derived from height in HealthCalculations.strideLengthFor(), but
  /// cached here so it survives without recomputing on every app boot.
  double strideLengthMeters = Defaults.averageStrideMeters;

  /// Appearance preference. Stored as "light" rather than "dark" so records
  /// written before this field existed (which read back as false) keep the
  /// app's default dark look.
  bool lightTheme = false;
}
