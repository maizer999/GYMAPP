import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedometer/pedometer.dart';

/// Thin wrapper over the `pedometer` plugin's StepCount stream. The
/// stream the OS gives back is a *cumulative* count since the device's
/// last boot or sensor reset — not "steps today" — so this service
/// exposes exactly that raw stream, and DashboardController is the layer
/// responsible for turning cumulative counts into a daily delta stored
/// in Isar. Keeping that conversion out of this class means a future
/// swap to a different sensor plugin only touches this one file.
class PedometerService {
  Stream<StepCount> get stepCountStream => Pedometer.stepCountStream;

  /// Separate from stepCountStream: some devices report a pedestrian
  /// status (walking/stopped) the UI can use for a "currently active"
  /// indicator, independent of the cumulative count itself.
  Stream<PedestrianStatus> get pedestrianStatusStream =>
      Pedometer.pedestrianStatusStream;
}

final pedometerServiceProvider = Provider<PedometerService>((ref) {
  return PedometerService();
});

/// Raw cumulative step stream, exposed as a StreamProvider so any widget
/// can `ref.watch(stepCountStreamProvider)` without caring whether it's
/// the first reading or a live update.
final stepCountStreamProvider = StreamProvider<StepCount>((ref) {
  return ref.watch(pedometerServiceProvider).stepCountStream;
});

final pedestrianStatusStreamProvider = StreamProvider<PedestrianStatus>((ref) {
  return ref.watch(pedometerServiceProvider).pedestrianStatusStream;
});
