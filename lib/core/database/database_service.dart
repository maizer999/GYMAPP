import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'activity_record.dart';
import 'user_profile.dart';

/// Opens (or reuses) the single Isar instance for the app. Call
/// DatabaseService.open() once in main() before runApp — every other
/// provider in the app depends on isarProvider resolving synchronously
/// via overrideWithValue, rather than each screen awaiting its own
/// Isar.open() call.
class DatabaseService {
  DatabaseService._();

  static Future<Isar> open() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isNotEmpty) {
      return Isar.getInstance()!;
    }

    return Isar.open(
      [ActivityRecordSchema, UserProfileSchema],
      directory: dir.path,
      name: 'stepz',
    );
  }
}

/// Overridden in main() with the real, already-opened Isar instance.
/// Left unimplemented here (rather than defaulted to null) so a missing
/// override fails loudly instead of silently crashing deep in a widget.
final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError(
    'isarProvider must be overridden in main() after DatabaseService.open()',
  );
});
