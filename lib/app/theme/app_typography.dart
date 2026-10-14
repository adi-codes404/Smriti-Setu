import 'package:flutter/material.dart';
import 'package:smriti_setu/app/theme/app_colors.dart';

/// Centralized typography definitions for Smriti Setu.
///
/// Designed with generous sizing and clear line-heights for enhanced readability
/// by elderly users and those with low digital literacy.
abstract final class AppTypography {
  // Configurable font family for future addition of Inter / Noto Sans Devanagari
  static const String? primaryFontFamily = null;

  static const TextStyle display = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.25,
  );

  static const TextStyle h1 = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
    height: 1.3,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
    height: 1.35,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.1,
    height: 1.4,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.45,
  );

  static const TextStyle body = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle button = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
    height: 1.3,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.2,
    height: 1.4,
  );

  /// Builds a complete Material 3 [TextTheme] based on our typography definitions.
  static TextTheme createTextTheme() {
    return const TextTheme(
      displayLarge: display,
      headlineLarge: h1,
      headlineMedium: h2,
      headlineSmall: h3,
      bodyLarge: bodyLarge,
      bodyMedium: body,
      labelLarge: button,
      bodySmall: caption,
    );
  }
}
