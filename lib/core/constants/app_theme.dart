import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_palette.dart';

/// Builds the dark and light [ThemeData]. Almost everything on screen is
/// custom-painted from [AppPalette]; the ThemeData here mainly styles the
/// stock Material pieces that still appear (dialogs, text fields, snack
/// bars) so they match.
class AppTheme {
  AppTheme._();

  static ThemeData dark() => _build(AppPalette.dark);

  static ThemeData light() => _build(AppPalette.light);

  static ThemeData _build(AppPalette p) {
    final brightness = p.isDark ? Brightness.dark : Brightness.light;

    final scheme = ColorScheme.fromSeed(
      seedColor: AppColors.cyan,
      brightness: brightness,
    ).copyWith(
      primary: p.accentText,
      onPrimary: AppColors.onAccent,
      secondary: AppColors.green,
      surface: p.surface,
      onSurface: p.text,
      onSurfaceVariant: p.muted,
      outline: p.cardStroke,
      outlineVariant: p.cardStroke,
      error: p.isDark ? AppColors.live : const Color(0xFFDC2626),
    );

    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
    );

    final stroke = BorderSide(color: p.cardStroke);
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: stroke,
    );

    return base.copyWith(
      scaffoldBackgroundColor: p.background,
      canvasColor: p.surface,
      splashFactory: InkRipple.splashFactory,
      textTheme: base.textTheme.apply(
        bodyColor: p.text,
        displayColor: p.text,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.green,
        circularTrackColor: p.ringTrack,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: p.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: stroke,
        ),
        titleTextStyle: TextStyle(
          color: p.text,
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: -.01 * 16,
        ),
        contentTextStyle: TextStyle(
          color: p.muted,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: p.surface,
        contentTextStyle: TextStyle(
          color: p.text,
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: stroke,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: p.iconWell,
        hintStyle: TextStyle(color: p.mutedDim),
        labelStyle: TextStyle(color: p.muted),
        suffixStyle: TextStyle(color: p.muted, fontWeight: FontWeight.w600),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: inputBorder,
        enabledBorder: inputBorder,
        focusedBorder: inputBorder.copyWith(
          borderSide: const BorderSide(color: AppColors.green, width: 1.5),
        ),
        errorBorder: inputBorder.copyWith(
          borderSide: BorderSide(color: scheme.error),
        ),
        focusedErrorBorder: inputBorder.copyWith(
          borderSide: BorderSide(color: scheme.error, width: 1.5),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.green,
        selectionColor: AppColors.green.withValues(alpha: .3),
        selectionHandleColor: AppColors.green,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: p.accentText,
          textStyle: const TextStyle(fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.green,
          foregroundColor: AppColors.onAccent,
          textStyle: const TextStyle(fontWeight: FontWeight.w800),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      extensions: [p],
    );
  }
}
