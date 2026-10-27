import 'dart:io' show Platform;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

/// Wraps the one permission the pedometer stream actually needs.
/// Android 10+ exposes it as ACTIVITY_RECOGNITION; iOS exposes the same
/// capability as Motion & Fitness, which permission_handler surfaces
/// under Permission.sensors (CMMotionActivityManager) — Permission.
/// activityRecognition has no handler on iOS at all and silently
/// returns denied without showing a dialog.
class PermissionService {
  Permission get _permission =>
      Platform.isIOS ? Permission.sensors : Permission.activityRecognition;

  Future<bool> hasActivityPermission() async {
    final status = await _permission.status;
    return status.isGranted;
  }

  Future<bool> requestActivityPermission() async {
    final status = await _permission.request();
    return status.isGranted;
  }

  Future<bool> isPermanentlyDenied() async {
    final status = await _permission.status;
    return status.isPermanentlyDenied;
  }

  Future<void> openSettings() => openAppSettings();
}

final permissionServiceProvider = Provider<PermissionService>((ref) {
  return PermissionService();
});
