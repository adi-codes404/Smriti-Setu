import 'package:flutter/material.dart';
import 'package:smriti_setu/app/theme/app_colors.dart';
import 'package:smriti_setu/app/theme/app_typography.dart';

/// Material 3 ThemeData setup for Smriti Setu.
///
/// Configured with high contrast, large touch targets (minimum 56px),
/// accessible typography, and warm earthen tones.
abstract final class AppTheme {
  static const double defaultCornerRadius = 16.0;
  static const double largeCornerRadius = 24.0;
  static const double minTouchTargetSize = 56.0;

  static ThemeData get lightTheme {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryTerracotta,
      onPrimary: AppColors.surfaceWhite,
      primaryContainer: AppColors.primaryLight,
      onPrimaryContainer: AppColors.primaryDark,
      secondary: AppColors.secondaryGreen,
      onSecondary: AppColors.surfaceWhite,
      secondaryContainer: AppColors.secondaryGreenLight,
      onSecondaryContainer: AppColors.secondaryGreen,
      error: AppColors.error,
      onError: AppColors.surfaceWhite,
      surface: AppColors.surfaceWhite,
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.surfaceSubtle,
      onSurfaceVariant: AppColors.textSecondary,
      outline: AppColors.border,
      outlineVariant: AppColors.border,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundCream,
      textTheme: AppTypography.createTextTheme(),

      // AppBar Styling
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundCream,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.h3,
        iconTheme: IconThemeData(color: AppColors.textPrimary, size: 28),
      ),

      // Card Styling
      cardTheme: CardThemeData(
        color: AppColors.surfaceWhite,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultCornerRadius),
          side: const BorderSide(color: AppColors.border, width: 1.5),
        ),
        margin: EdgeInsets.zero,
      ),

      // Filled Button Styling
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primaryTerracotta,
          foregroundColor: AppColors.surfaceWhite,
          minimumSize: const Size.fromHeight(minTouchTargetSize),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultCornerRadius),
          ),
          textStyle: AppTypography.button,
          elevation: 0,
        ),
      ),

      // Elevated Button Styling
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryTerracotta,
          foregroundColor: AppColors.surfaceWhite,
          minimumSize: const Size.fromHeight(minTouchTargetSize),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultCornerRadius),
          ),
          textStyle: AppTypography.button,
          elevation: 0,
        ),
      ),

      // Outlined Button Styling
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          minimumSize: const Size.fromHeight(minTouchTargetSize),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          side: const BorderSide(color: AppColors.border, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultCornerRadius),
          ),
          textStyle: AppTypography.button,
        ),
      ),

      // Text Button Styling
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryDark,
          minimumSize: const Size(minTouchTargetSize, minTouchTargetSize),
          textStyle: AppTypography.button,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),

      // SnackBar Styling
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: AppTypography.body.copyWith(
          color: AppColors.surfaceWhite,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),

      // Icon Theme
      iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 28),
    );
  }
}
