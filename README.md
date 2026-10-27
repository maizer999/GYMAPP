# Stepz — Pedometer & Activity Tracker (Flutter MVP)

## ⚠️ What this is — and isn't — yet

This is **hand-written source code only** — `lib/` + `pubspec.yaml`.
There is **no `android/`, `ios/`, or `web/` folder**, and **nothing here
has been compiled, analyzed, or run**. I built this in a cloud sandbox
that cannot reach `storage.googleapis.com` (where the Flutter/Dart SDK
engine artifacts live), so `flutter pub get` / `flutter analyze` could
never actually execute on my end. Treat every file as a strong first
draft, not verified-working code, until you've run the steps below
yourself.

## Setup (run these on your Mac, where Flutter is already installed)

```bash
cd stepz_pedometer

# 1. Generates the missing android/ios/web platform folders. Safe to run
#    on an existing lib/+pubspec.yaml — it does not overwrite your code.
flutter create .

# 2. Installs the dependencies listed in pubspec.yaml
flutter pub get

# 3. Generates activity_record.g.dart / user_profile.g.dart (Isar's
#    codegen) — the app will not compile until this runs once.
dart run build_runner build --delete-conflicting-outputs

# 4. Run on a PHYSICAL device — the iOS Simulator and most Android
#    emulators have no motion/step sensors, so the pedometer stream
#    will simply never emit anything there.
flutter run
```

## Native permission setup (required, not automatic)

Installing the `pedometer`, `permission_handler`, and `health` packages
does **not** by itself add the permission entries their native code
needs — that's a manual step `flutter create` + `pub get` doesn't do
for you:

**Android** — add to `android/app/src/main/AndroidManifest.xml`, inside
`<manifest>`:
```xml
<uses-permission android:name="android.permission.ACTIVITY_RECOGNITION" />
```
(Required on Android 10 / API 29+. Below that, step counting works
without a runtime permission prompt.)

**iOS** — add to `ios/Runner/Info.plist`:
```xml
<key>NSMotionUsageDescription</key>
<string>Stepz uses motion data to count your steps.</string>
```
If you want the optional HealthKit sync (`HealthService`) to actually
work rather than silently no-op, you also need to:
1. In Xcode, select the Runner target → Signing & Capabilities → **+
   Capability** → add **HealthKit**.
2. Add to `Info.plist`:
   ```xml
   <key>NSHealthShareUsageDescription</key>
   <string>Stepz reads your step history from Health.</string>
   <key>NSHealthUpdateUsageDescription</key>
   <string>Stepz can write workout data to Health.</string>
   ```

Without these, the app's core loop (pedometer → Isar → dashboard ring)
still works — `HealthService` is designed to fail soft and fall back to
the local step count (see its docstring) — but you'll see a permission
dialog that never resolves, or a silent no-op, until the manifest
entries are in place.

## Architecture (matches the original scope's Clean Architecture spec)

```
lib/
├── core/
│   ├── constants/   — AppColors, AppTheme, Defaults (goal, stride, MET)
│   ├── database/    — Isar schemas (ActivityRecord, UserProfile) + DatabaseService
│   ├── services/    — PermissionService, PedometerService, HealthService
│   └── utils/       — HealthCalculations (distance/calorie formulas)
└── features/
    ├── dashboard/   — step ring, metric cards, 24h hourly chart
    ├── history/     — weekly/monthly bar charts (fl_chart)
    ├── milestones/  — badges + streak tracking, recomputed from history
    └── settings/    — height/weight/goal profile form
```

**Key design decision**: `DashboardController` (in `features/dashboard/`)
is the only place that converts the OS's *cumulative* step count (what
the `pedometer` plugin actually streams) into "steps today." It tracks
a baseline cumulative value per calendar day and persists the daily
delta to Isar — `HistoryController` and `MilestonesController` only
ever read what's already been persisted; they never touch the raw
sensor stream.

## Honest gaps (MVP scope, not yet built)

- No onboarding flow — first launch goes straight to the permission
  prompt on the Dashboard tab.
- Milestone "achieved" badges don't currently trigger a celebratory
  animation/toast the moment they're crossed — they just render as
  unlocked next time the Milestones tab is opened.
- `HealthService` syncs *from* HealthKit/Health Connect for display
  context, but the app doesn't write its own data back to either.
- No tests written yet.written≥≥≥≥≥≥written≥≥≥≥≥≥≥≥≥≥≥≥tests≥≥≥≥≥≥≥≥≥tests≥≥yet≥yet≥to≥back
