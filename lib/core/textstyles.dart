// typography_styles.dart

import 'package:flutter/material.dart';

class AppTextStyles {

  // ─── Display (Primary) ──────────────────────────────
  static const TextStyle displayLarge = TextStyle(
    fontFamily: 'Roboto', fontSize: 57, height: 64/57,
    fontWeight: FontWeight.w400, letterSpacing: -0.25,
  );
  static const TextStyle displayMedium = TextStyle(
    fontFamily: 'Roboto', fontSize: 45, height: 52/45,
    fontWeight: FontWeight.w400, letterSpacing: 0,
  );
  static const TextStyle displaySmall = TextStyle(
    fontFamily: 'Roboto', fontSize: 36, height: 44/36,
    fontWeight: FontWeight.w400, letterSpacing: 0,
  );

  // ─── Display (Emphasized) ───────────────────────────
  static const TextStyle displayLargeEmphasized = TextStyle(
    fontFamily: 'Roboto', fontSize: 57, height: 64/57,
    fontWeight: FontWeight.w500, letterSpacing: -0.25,
  );
  static const TextStyle displayMediumEmphasized = TextStyle(
    fontFamily: 'Roboto', fontSize: 45, height: 52/45,
    fontWeight: FontWeight.w500, letterSpacing: 0,
  );
  static const TextStyle displaySmallEmphasized = TextStyle(
    fontFamily: 'Roboto', fontSize: 36, height: 44/36,
    fontWeight: FontWeight.w500, letterSpacing: 0,
  );

  // ─── Headline (Primary) ─────────────────────────────
  static const TextStyle headlineLarge = TextStyle(
    fontFamily: 'Roboto', fontSize: 32, height: 40/32,
    fontWeight: FontWeight.w400, letterSpacing: 0,
  );
  static const TextStyle headlineMedium = TextStyle(
    fontFamily: 'Roboto', fontSize: 28, height: 36/28,
    fontWeight: FontWeight.w400, letterSpacing: 0,
  );
  static const TextStyle headlineSmall = TextStyle(
    fontFamily: 'Roboto', fontSize: 24, height: 32/24,
    fontWeight: FontWeight.w400, letterSpacing: 0,
  );

  // ─── Headline (Emphasized) ──────────────────────────
  static const TextStyle headlineLargeEmphasized = TextStyle(
    fontFamily: 'Roboto', fontSize: 32, height: 40/32,
    fontWeight: FontWeight.w500, letterSpacing: 0,
  );
  static const TextStyle headlineMediumEmphasized = TextStyle(
    fontFamily: 'Roboto', fontSize: 28, height: 36/28,
    fontWeight: FontWeight.w500, letterSpacing: 0,
  );
  static const TextStyle headlineSmallEmphasized = TextStyle(
    fontFamily: 'Roboto', fontSize: 24, height: 32/24,
    fontWeight: FontWeight.w500, letterSpacing: 0,
  );

  // ─── Title (Primary) ────────────────────────────────
  static const TextStyle titleLarge = TextStyle(
    fontFamily: 'Roboto', fontSize: 22, height: 28/22,
    fontWeight: FontWeight.w400, letterSpacing: 0,
  );
  static const TextStyle titleMedium = TextStyle(
    fontFamily: 'Roboto', fontSize: 16, height: 24/16,
    fontWeight: FontWeight.w500, letterSpacing: 0.15,
  );
  static const TextStyle titleSmall = TextStyle(
    fontFamily: 'Roboto', fontSize: 14, height: 20/14,
    fontWeight: FontWeight.w500, letterSpacing: 0.1,
  );

  // ─── Title (Emphasized) ─────────────────────────────
  static const TextStyle titleLargeEmphasized = TextStyle(
    fontFamily: 'Roboto', fontSize: 22, height: 28/22,
    fontWeight: FontWeight.w500, letterSpacing: 0,
  );
  static const TextStyle titleMediumEmphasized = TextStyle(
    fontFamily: 'Roboto', fontSize: 16, height: 24/16,
    fontWeight: FontWeight.w600, letterSpacing: 0.15,
  );
  static const TextStyle titleSmallEmphasized = TextStyle(
    fontFamily: 'Roboto', fontSize: 14, height: 20/14,
    fontWeight: FontWeight.w600, letterSpacing: 0.1,
  );

  // ─── Label (Primary) ────────────────────────────────
  static const TextStyle labelLarge = TextStyle(
    fontFamily: 'Roboto', fontSize: 14, height: 20/14,
    fontWeight: FontWeight.w500, letterSpacing: 0.1,
  );
  static const TextStyle labelMedium = TextStyle(
    fontFamily: 'Roboto', fontSize: 12, height: 16/12,
    fontWeight: FontWeight.w500, letterSpacing: 0.5,
  );
  static const TextStyle labelSmall = TextStyle(
    fontFamily: 'Roboto', fontSize: 11, height: 16/11,
    fontWeight: FontWeight.w500, letterSpacing: 0.5,
  );

  // ─── Label (Emphasized) ─────────────────────────────
  static const TextStyle labelLargeEmphasized = TextStyle(
    fontFamily: 'Roboto', fontSize: 14, height: 20/14,
    fontWeight: FontWeight.w600, letterSpacing: 0.1,
  );
  static const TextStyle labelMediumEmphasized = TextStyle(
    fontFamily: 'Roboto', fontSize: 12, height: 16/12,
    fontWeight: FontWeight.w600, letterSpacing: 0.5,
  );
  static const TextStyle labelSmallEmphasized = TextStyle(
    fontFamily: 'Roboto', fontSize: 11, height: 16/11,
    fontWeight: FontWeight.w600, letterSpacing: 0.5,
  );

  // ─── Body (Primary) ─────────────────────────────────
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Roboto', fontSize: 16, height: 24/16,
    fontWeight: FontWeight.w400, letterSpacing: 0.5,
  );
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Roboto', fontSize: 14, height: 20/14,
    fontWeight: FontWeight.w400, letterSpacing: 0.25,
  );
  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'Roboto', fontSize: 12, height: 16/12,
    fontWeight: FontWeight.w400, letterSpacing: 0.4,
  );

  // ─── Body (Emphasized) ──────────────────────────────
  static const TextStyle bodyLargeEmphasized = TextStyle(
    fontFamily: 'Roboto', fontSize: 16, height: 24/16,
    fontWeight: FontWeight.w500, letterSpacing: 0.5,
  );
  static const TextStyle bodyMediumEmphasized = TextStyle(
    fontFamily: 'Roboto', fontSize: 14, height: 20/14,
    fontWeight: FontWeight.w500, letterSpacing: 0.25,
  );
  static const TextStyle bodySmallEmphasized = TextStyle(
    fontFamily: 'Roboto', fontSize: 12, height: 16/12,
    fontWeight: FontWeight.w500, letterSpacing: 0.4,
  );
}