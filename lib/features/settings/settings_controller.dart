import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';

import '../../core/database/database_service.dart';
import '../../core/database/user_profile.dart';
import '../../core/utils/health_calculations.dart';

class SettingsController extends StateNotifier<AsyncValue<UserProfile>> {
  SettingsController(this._isar) : super(const AsyncValue.loading()) {
    _load();
  }

  final Isar _isar;

  Future<void> _load() async {
    final profile = await _isar.userProfiles.get(0) ?? UserProfile();
    state = AsyncValue.data(profile);
  }

  /// Recomputes strideLengthMeters from the new height every time it's
  /// saved, so Dashboard/History distance figures update immediately —
  /// there's no separate "recalculate" step for the user to remember.
  Future<void> save({
    required double heightCm,
    required double weightKg,
    required int dailyStepGoal,
  }) async {
    final profile = UserProfile()
      ..heightCm = heightCm
      ..weightKg = weightKg
      ..dailyStepGoal = dailyStepGoal
      ..strideLengthMeters =
          HealthCalculations.strideLengthFor(heightCm: heightCm);

    await _isar.writeTxn(() async {
      await _isar.userProfiles.put(profile);
    });

    state = AsyncValue.data(profile);
  }
}

final settingsControllerProvider =
    StateNotifierProvider<SettingsController, AsyncValue<UserProfile>>((ref) {
  return SettingsController(ref.watch(isarProvider));
});
