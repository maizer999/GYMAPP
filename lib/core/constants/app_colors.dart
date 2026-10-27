import 'package:flutter/material.dart';

/// Brand accents that look the same in both themes. Anything that has to
/// change with the theme (text, surfaces, strokes, glows…) lives in
/// [AppPalette] instead.
class AppColors {
  AppColors._();

  static const cyan = Color(0xFF06B6D4);
  static const cyanBright = Color(0xFF22D3EE);
  static const cyanSoft = Color(0xFF38BDF8);
  static const green = Color(0xFF22C55E);
  static const greenSoft = Color(0xFF34D399);
  static const greenLime = Color(0xFF4ADE80);

  /// "Recording" red used while a walk session is running.
  static const live = Color(0xFFF87171);

  /// Text/icon colour placed on top of the cyan → green gradient fills.
  static const onAccent = Color(0xFF04140C);

  // Static aliases used by feature screens before the AppPalette migration.
  // The pages pass these into `const` TextStyle/BoxDecoration constructors,
  // so they must stay compile-time constants. Values match AppPalette.dark.
  static const primary = green;
  static const textPrimary = Color(0xFFF1F5F9);
  static const textSecondary = Color(0xFF94A3B8);
  static const surface = Color(0xFF1A2338);
  static const ringTrack = Color.fromRGBO(255, 255, 255, .07);
  static const ringProgress = greenSoft;
  static const distanceColor = cyanSoft;
  static const caloriesColor = greenSoft;
  static const stepsColor = green;
}
