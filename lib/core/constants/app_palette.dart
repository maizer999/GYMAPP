import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Every colour that changes between the dark and light looks, kept in one
/// [ThemeExtension] so a theme switch cross-fades smoothly (MaterialApp
/// animates ThemeData, which lerps this extension too).
///
/// Dark is the reference design. Light is a hand-tuned counterpart: same
/// structure, but with darker accents where a pale green/cyan would
/// otherwise disappear against a bright surface.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.isDark,
    required this.backdrop,
    required this.background,
    required this.surface,
    required this.text,
    required this.muted,
    required this.mutedDim,
    required this.cardTop,
    required this.cardBottom,
    required this.cardStroke,
    required this.cardShadow,
    required this.cardHighlight,
    required this.frameShadow,
    required this.frameRing,
    required this.edgeGlow,
    required this.bloomScale,
    required this.navBackground,
    required this.navBorder,
    required this.navShadow,
    required this.navActiveLabel,
    required this.navActiveIcon,
    required this.accentText,
    required this.goalPillText,
    required this.badgeText,
    required this.liveText,
    required this.iconWell,
    required this.iconWellStroke,
    required this.ringTrack,
    required this.stepTextTop,
    required this.stepTextBottom,
    required this.tintAlpha,
    required this.accentDistance,
    required this.accentCalories,
    required this.accentActive,
    required this.accentPace,
    required this.barTop,
    required this.barBottom,
    required this.barEmpty,
  });

  final bool isDark;

  /// Area outside the phone-shaped frame on wide screens.
  final Color backdrop;

  /// Base colour of the app canvas.
  final Color background;

  /// Opaque stand-in for a glass card, used by dialogs and snack bars that
  /// can't be see-through.
  final Color surface;

  final Color text;
  final Color muted;
  final Color mutedDim;

  final Color cardTop;
  final Color cardBottom;
  final Color cardStroke;
  final Color cardShadow;
  final Color cardHighlight;

  final Color frameShadow;
  final Color frameRing;

  /// Faint inner glow hugging the edge of the canvas (dark theme only).
  final Color edgeGlow;

  /// Multiplier applied to the alpha of the ambient light blooms.
  final double bloomScale;

  final Color navBackground;
  final Color navBorder;
  final Color navShadow;
  final Color navActiveLabel;
  final Color navActiveIcon;

  /// Highlighted figures (percentages, list values, links).
  final Color accentText;
  final Color goalPillText;
  final Color badgeText;
  final Color liveText;

  final Color iconWell;
  final Color iconWellStroke;
  final Color ringTrack;

  /// Vertical gradient the big step count is painted with.
  final Color stepTextTop;
  final Color stepTextBottom;

  /// Alpha of the accent tint in the corner of each stat card.
  final double tintAlpha;

  final Color accentDistance;
  final Color accentCalories;
  final Color accentActive;
  final Color accentPace;

  final Color barTop;
  final Color barBottom;
  final Color barEmpty;

  static const dark = AppPalette(
    isDark: true,
    backdrop: Color(0xFF070B14),
    background: Color(0xFF0F172A),
    surface: Color(0xFF1A2338),
    text: Color(0xFFF1F5F9),
    muted: Color(0xFF94A3B8),
    mutedDim: Color(0xFF64748B),
    cardTop: Color.fromRGBO(255, 255, 255, .075),
    cardBottom: Color.fromRGBO(255, 255, 255, .028),
    cardStroke: Color.fromRGBO(255, 255, 255, .085),
    cardShadow: Color.fromRGBO(0, 0, 0, .9),
    cardHighlight: Color.fromRGBO(255, 255, 255, .06),
    frameShadow: Color.fromRGBO(0, 0, 0, .95),
    frameRing: Color.fromRGBO(255, 255, 255, .07),
    edgeGlow: Color.fromRGBO(6, 182, 212, .045),
    bloomScale: 1,
    navBackground: Color.fromRGBO(11, 18, 34, .82),
    navBorder: Color.fromRGBO(255, 255, 255, .07),
    navShadow: Color.fromRGBO(0, 0, 0, .9),
    navActiveLabel: Color(0xFFEAFFF5),
    navActiveIcon: Color(0xFF34D399),
    accentText: Color(0xFF34D399),
    goalPillText: Color(0xFFA7F3D0),
    badgeText: Color(0xFFD9F99D),
    liveText: Color(0xFFFECACA),
    iconWell: Color.fromRGBO(255, 255, 255, .06),
    iconWellStroke: Color.fromRGBO(255, 255, 255, .08),
    ringTrack: Color.fromRGBO(255, 255, 255, .07),
    stepTextTop: Color(0xFFFFFFFF),
    stepTextBottom: Color(0xFFB8F5D4),
    tintAlpha: .136,
    accentDistance: Color(0xFF38BDF8),
    accentCalories: Color(0xFF34D399),
    accentActive: Color(0xFF22D3EE),
    accentPace: Color(0xFF4ADE80),
    barTop: Color(0xFF34D399),
    barBottom: Color(0xFF06B6D4),
    barEmpty: Color.fromRGBO(255, 255, 255, .13),
  );

  static const light = AppPalette(
    isDark: false,
    backdrop: Color(0xFFE2E8F0),
    background: Color(0xFFF1F5F9),
    surface: Color(0xFFFFFFFF),
    text: Color(0xFF0F172A),
    muted: Color(0xFF475569),
    mutedDim: Color(0xFF5B6B81),
    cardTop: Color.fromRGBO(255, 255, 255, .9),
    cardBottom: Color.fromRGBO(255, 255, 255, .6),
    cardStroke: Color.fromRGBO(15, 23, 42, .08),
    cardShadow: Color.fromRGBO(15, 23, 42, .18),
    cardHighlight: Color.fromRGBO(255, 255, 255, .9),
    frameShadow: Color.fromRGBO(15, 23, 42, .35),
    frameRing: Color.fromRGBO(15, 23, 42, .06),
    edgeGlow: Color.fromRGBO(6, 182, 212, 0),
    bloomScale: .58,
    navBackground: Color.fromRGBO(255, 255, 255, .86),
    navBorder: Color.fromRGBO(15, 23, 42, .07),
    navShadow: Color.fromRGBO(15, 23, 42, .18),
    navActiveLabel: Color(0xFF0F172A),
    navActiveIcon: Color(0xFF059669),
    accentText: Color(0xFF047857),
    goalPillText: Color(0xFF047857),
    badgeText: Color(0xFF166534),
    liveText: Color(0xFFB91C1C),
    iconWell: Color.fromRGBO(15, 23, 42, .04),
    iconWellStroke: Color.fromRGBO(15, 23, 42, .07),
    ringTrack: Color.fromRGBO(15, 23, 42, .07),
    stepTextTop: Color(0xFF0F172A),
    stepTextBottom: Color(0xFF047857),
    tintAlpha: .12,
    accentDistance: Color(0xFF0284C7),
    accentCalories: Color(0xFF059669),
    accentActive: Color(0xFF0891B2),
    accentPace: Color(0xFF16A34A),
    barTop: Color(0xFF10B981),
    barBottom: Color(0xFF0891B2),
    barEmpty: Color.fromRGBO(15, 23, 42, .08),
  );

  @override
  AppPalette copyWith({
    bool? isDark,
    Color? backdrop,
    Color? background,
    Color? surface,
    Color? text,
    Color? muted,
    Color? mutedDim,
    Color? cardTop,
    Color? cardBottom,
    Color? cardStroke,
    Color? cardShadow,
    Color? cardHighlight,
    Color? frameShadow,
    Color? frameRing,
    Color? edgeGlow,
    double? bloomScale,
    Color? navBackground,
    Color? navBorder,
    Color? navShadow,
    Color? navActiveLabel,
    Color? navActiveIcon,
    Color? accentText,
    Color? goalPillText,
    Color? badgeText,
    Color? liveText,
    Color? iconWell,
    Color? iconWellStroke,
    Color? ringTrack,
    Color? stepTextTop,
    Color? stepTextBottom,
    double? tintAlpha,
    Color? accentDistance,
    Color? accentCalories,
    Color? accentActive,
    Color? accentPace,
    Color? barTop,
    Color? barBottom,
    Color? barEmpty,
  }) {
    return AppPalette(
      isDark: isDark ?? this.isDark,
      backdrop: backdrop ?? this.backdrop,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      text: text ?? this.text,
      muted: muted ?? this.muted,
      mutedDim: mutedDim ?? this.mutedDim,
      cardTop: cardTop ?? this.cardTop,
      cardBottom: cardBottom ?? this.cardBottom,
      cardStroke: cardStroke ?? this.cardStroke,
      cardShadow: cardShadow ?? this.cardShadow,
      cardHighlight: cardHighlight ?? this.cardHighlight,
      frameShadow: frameShadow ?? this.frameShadow,
      frameRing: frameRing ?? this.frameRing,
      edgeGlow: edgeGlow ?? this.edgeGlow,
      bloomScale: bloomScale ?? this.bloomScale,
      navBackground: navBackground ?? this.navBackground,
      navBorder: navBorder ?? this.navBorder,
      navShadow: navShadow ?? this.navShadow,
      navActiveLabel: navActiveLabel ?? this.navActiveLabel,
      navActiveIcon: navActiveIcon ?? this.navActiveIcon,
      accentText: accentText ?? this.accentText,
      goalPillText: goalPillText ?? this.goalPillText,
      badgeText: badgeText ?? this.badgeText,
      liveText: liveText ?? this.liveText,
      iconWell: iconWell ?? this.iconWell,
      iconWellStroke: iconWellStroke ?? this.iconWellStroke,
      ringTrack: ringTrack ?? this.ringTrack,
      stepTextTop: stepTextTop ?? this.stepTextTop,
      stepTextBottom: stepTextBottom ?? this.stepTextBottom,
      tintAlpha: tintAlpha ?? this.tintAlpha,
      accentDistance: accentDistance ?? this.accentDistance,
      accentCalories: accentCalories ?? this.accentCalories,
      accentActive: accentActive ?? this.accentActive,
      accentPace: accentPace ?? this.accentPace,
      barTop: barTop ?? this.barTop,
      barBottom: barBottom ?? this.barBottom,
      barEmpty: barEmpty ?? this.barEmpty,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;

    Color c(Color a, Color b) => Color.lerp(a, b, t)!;
    double d(double a, double b) => lerpDouble(a, b, t)!;

    return AppPalette(
      isDark: t < .5 ? isDark : other.isDark,
      backdrop: c(backdrop, other.backdrop),
      background: c(background, other.background),
      surface: c(surface, other.surface),
      text: c(text, other.text),
      muted: c(muted, other.muted),
      mutedDim: c(mutedDim, other.mutedDim),
      cardTop: c(cardTop, other.cardTop),
      cardBottom: c(cardBottom, other.cardBottom),
      cardStroke: c(cardStroke, other.cardStroke),
      cardShadow: c(cardShadow, other.cardShadow),
      cardHighlight: c(cardHighlight, other.cardHighlight),
      frameShadow: c(frameShadow, other.frameShadow),
      frameRing: c(frameRing, other.frameRing),
      edgeGlow: c(edgeGlow, other.edgeGlow),
      bloomScale: d(bloomScale, other.bloomScale),
      navBackground: c(navBackground, other.navBackground),
      navBorder: c(navBorder, other.navBorder),
      navShadow: c(navShadow, other.navShadow),
      navActiveLabel: c(navActiveLabel, other.navActiveLabel),
      navActiveIcon: c(navActiveIcon, other.navActiveIcon),
      accentText: c(accentText, other.accentText),
      goalPillText: c(goalPillText, other.goalPillText),
      badgeText: c(badgeText, other.badgeText),
      liveText: c(liveText, other.liveText),
      iconWell: c(iconWell, other.iconWell),
      iconWellStroke: c(iconWellStroke, other.iconWellStroke),
      ringTrack: c(ringTrack, other.ringTrack),
      stepTextTop: c(stepTextTop, other.stepTextTop),
      stepTextBottom: c(stepTextBottom, other.stepTextBottom),
      tintAlpha: d(tintAlpha, other.tintAlpha),
      accentDistance: c(accentDistance, other.accentDistance),
      accentCalories: c(accentCalories, other.accentCalories),
      accentActive: c(accentActive, other.accentActive),
      accentPace: c(accentPace, other.accentPace),
      barTop: c(barTop, other.barTop),
      barBottom: c(barBottom, other.barBottom),
      barEmpty: c(barEmpty, other.barEmpty),
    );
  }
}

extension AppPaletteContext on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>()!;
}
