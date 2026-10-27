import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:pedometer/pedometer.dart';

import '../../core/constants/defaults.dart';
import '../../core/database/activity_record.dart';
import '../../core/database/database_service.dart';
import '../../core/database/user_profile.dart';
import '../../core/services/health_service.dart';
import '../../core/services/pedometer_service.dart';
import '../../core/services/permission_service.dart';
import '../../core/utils/health_calculations.dart';

class DashboardUiState {
  const DashboardUiState({
    required this.steps,
    required this.distanceMeters,
    required this.activeCalories,
    required this.dailyGoal,
    required this.hourlySteps,
    required this.permissionGranted,
    required this.isLoading,
    this.errorMessage,
  });

  final int steps;
  final double distanceMeters;
  final double activeCalories;
  final int dailyGoal;
  final List<int> hourlySteps;
  final bool permissionGranted;
  final bool isLoading;
  final String? errorMessage;

  double get progress =>
      dailyGoal == 0 ? 0 : (steps / dailyGoal).clamp(0, 1).toDouble();

  DashboardUiState copyWith({
    int? steps,
    double? distanceMeters,
    double? activeCalories,
    int? dailyGoal,
    List<int>? hourlySteps,
    bool? permissionGranted,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DashboardUiState(
      steps: steps ?? this.steps,
      distanceMeters: distanceMeters ?? this.distanceMeters,
      activeCalories: activeCalories ?? this.activeCalories,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      hourlySteps: hourlySteps ?? this.hourlySteps,
      permissionGranted: permissionGranted ?? this.permissionGranted,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  static DashboardUiState initial() => DashboardUiState(
        steps: 0,
        distanceMeters: 0,
        activeCalories: 0,
        dailyGoal: Defaults.dailyStepGoal,
        hourlySteps: List.filled(24, 0),
        permissionGranted: false,
        isLoading: true,
      );
}

/// The one place that turns the OS's *cumulative* step count into
/// "steps today" and persists it. The pedometer plugin never resets its
/// counter at midnight on its own — this controller is what makes that
/// happen, by recording a baseline cumulative value the moment a new
/// calendar day is first observed.
class DashboardController extends StateNotifier<DashboardUiState>
    with WidgetsBindingObserver {
  DashboardController(this._ref) : super(DashboardUiState.initial()) {
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  final Ref _ref;
  StreamSubscription<StepCount>? _subscription;
  Timer? _midnightTicker;

  int? _cumulativeBaseline;
  int? _lastCumulative;
  int _startingStepsToday = 0;
  late int _currentDayEpoch;
  late UserProfile _profile;
  bool _healthReady = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _reconcileFromHealth();
    }
  }

  Future<void> _init() async {
    final isar = _ref.read(isarProvider);
    final permissionService = _ref.read(permissionServiceProvider);

    _profile = await isar.userProfiles.get(0) ?? UserProfile();
    _currentDayEpoch = ActivityRecord.dayEpochFor(DateTime.now());

    final existingToday = await isar.activityRecords
        .filter()
        .dayEpochEqualTo(_currentDayEpoch)
        .findFirst();

    _startingStepsToday = existingToday?.steps ?? 0;

    state = state.copyWith(
      dailyGoal: _profile.dailyStepGoal,
      steps: _startingStepsToday,
      distanceMeters: existingToday?.distanceMeters ?? 0,
      activeCalories: existingToday?.activeCalories ?? 0,
      hourlySteps: existingToday?.hourlySteps ?? List.filled(24, 0),
      isLoading: false,
    );

    final granted = await permissionService.hasActivityPermission();
    state = state.copyWith(permissionGranted: granted);

    if (granted) {
      _subscribeToPedometer();
    }

    await _setupHealth();
    await _reconcileFromHealth();
    _startMidnightTicker();
  }

  /// Fires every minute so an app sitting open through 00:00 (e.g. the
  /// user never backgrounded it) still swaps to the fresh day's zero.
  /// The pedometer stream alone can't be relied on here — if no step
  /// events arrive right around midnight, nothing else nudges the UI.
  void _startMidnightTicker() {
    _midnightTicker?.cancel();
    _midnightTicker = Timer.periodic(const Duration(minutes: 1), (_) {
      final nowEpoch = ActivityRecord.dayEpochFor(DateTime.now());
      if (nowEpoch != _currentDayEpoch) {
        _rolloverToNewDay(nowEpoch);
        _reconcileFromHealth();
      }
    });
  }

  void _rolloverToNewDay(int newDayEpoch) {
    _currentDayEpoch = newDayEpoch;
    _cumulativeBaseline = null;
    _lastCumulative = null;
    _startingStepsToday = 0;
    state = state.copyWith(
      steps: 0,
      distanceMeters: 0,
      activeCalories: 0,
      hourlySteps: List.filled(24, 0),
    );
  }

  Future<bool> requestPermission() async {
    final granted =
        await _ref.read(permissionServiceProvider).requestActivityPermission();
    state = state.copyWith(permissionGranted: granted);
    if (granted) {
      _subscribeToPedometer();
      await _setupHealth();
      await _reconcileFromHealth();
    }
    return granted;
  }

  Future<void> _setupHealth() async {
    if (_healthReady) return;
    final health = _ref.read(healthServiceProvider);
    final configured = await health.configure();
    if (!configured) return;
    final authorized = await health.requestAuthorization();
    _healthReady = authorized;
  }

  /// Pulls today's step total + hourly breakdown from HealthKit /
  /// Health Connect and merges it in when it's ahead of what we have.
  /// This is what covers steps taken while the app was backgrounded or
  /// killed — the OS keeps counting there even when our process isn't
  /// running, so on launch and on resume we backfill the gap.
  Future<void> _reconcileFromHealth() async {
    if (!_healthReady) return;

    final today = DateTime.now();
    final todayEpoch = ActivityRecord.dayEpochFor(today);
    final dayRolledOver = todayEpoch != _currentDayEpoch;
    if (dayRolledOver) {
      _rolloverToNewDay(todayEpoch);
      await _persistToday();
    }

    final health = _ref.read(healthServiceProvider);
    final osTotal = await health.stepsForDate(today);
    if (osTotal == null) return;
    // On a day rollover we always overwrite; otherwise only when the OS
    // store is ahead of our local tally (prevents a stale small value
    // from clobbering live stream increments).
    if (!dayRolledOver && osTotal <= state.steps) return;

    final hourly = await health.hourlyStepsForDate(today) ?? state.hourlySteps;

    final distance = HealthCalculations.distanceMeters(
      steps: osTotal,
      strideLengthMeters: _profile.strideLengthMeters,
    );
    final calories = HealthCalculations.activeCalories(
      steps: osTotal,
      weightKg: _profile.weightKg,
    );

    _startingStepsToday = osTotal;
    _cumulativeBaseline = null;
    _lastCumulative = null;

    state = state.copyWith(
      steps: osTotal,
      hourlySteps: hourly,
      distanceMeters: distance,
      activeCalories: calories,
    );

    await _persistToday();
  }

  void _subscribeToPedometer() {
    _subscription?.cancel();
    _subscription = _ref
        .read(pedometerServiceProvider)
        .stepCountStream
        .listen(_onStepCount, onError: (Object e) {
      state = state.copyWith(errorMessage: e.toString());
    });
  }

  Future<void> _onStepCount(StepCount event) async {
    final todayEpoch = ActivityRecord.dayEpochFor(event.timeStamp);

    // Midnight rolled over since the last reading — reset the baseline
    // so today starts counting from zero again, and let the previous
    // day's final tally stand untouched in Isar.
    if (todayEpoch != _currentDayEpoch) {
      _currentDayEpoch = todayEpoch;
      _cumulativeBaseline = event.steps;
      _lastCumulative = event.steps;
      _startingStepsToday = 0;
      state = state.copyWith(
        steps: 0,
        distanceMeters: 0,
        activeCalories: 0,
        hourlySteps: List.filled(24, 0),
      );
      return;
    }

    _cumulativeBaseline ??= event.steps;
    final previousCumulative = _lastCumulative ?? _cumulativeBaseline!;
    _lastCumulative = event.steps;

    final sessionSteps = (event.steps - _cumulativeBaseline!).clamp(0, 1 << 30);
    final todaySteps = _startingStepsToday + sessionSteps;
    final incrementalSteps =
        (event.steps - previousCumulative).clamp(0, 1 << 30);

    final hourlySteps = List<int>.from(state.hourlySteps);
    final hour = event.timeStamp.hour;
    hourlySteps[hour] += incrementalSteps;

    final distance = HealthCalculations.distanceMeters(
      steps: todaySteps,
      strideLengthMeters: _profile.strideLengthMeters,
    );
    final calories = HealthCalculations.activeCalories(
      steps: todaySteps,
      weightKg: _profile.weightKg,
    );

    state = state.copyWith(
      steps: todaySteps,
      distanceMeters: distance,
      activeCalories: calories,
      hourlySteps: hourlySteps,
    );

    await _persistToday();
  }

  Future<void> _persistToday() async {
    final isar = _ref.read(isarProvider);
    final record = ActivityRecord()
      ..dayEpoch = _currentDayEpoch
      ..steps = state.steps
      ..distanceMeters = state.distanceMeters
      ..activeCalories = state.activeCalories
      ..hourlySteps = state.hourlySteps
      ..updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.activityRecords.put(record);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _subscription?.cancel();
    _midnightTicker?.cancel();
    super.dispose();
  }
}

final dashboardControllerProvider =
    StateNotifierProvider<DashboardController, DashboardUiState>((ref) {
  return DashboardController(ref);
});
