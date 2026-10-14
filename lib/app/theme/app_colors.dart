import 'package:flutter/material.dart';

/// Centralized color palette for Smriti Setu.
///
/// Designed with warm, human, trustworthy tones optimized for high-contrast
/// accessibility and readability by elderly users.
abstract final class AppColors {
  // Brand Primary & Accents
  static const Color primaryTerracotta = Color(0xFFC96A3D);
  static const Color primaryDark = Color(0xFF9E4D2D);
  static const Color primaryLight = Color(
    0xFFF7ECE4,
  ); // Warm tint for highlights

  // Secondary & Supporting
  static const Color secondaryGreen = Color(0xFF52745A);
  static const Color secondaryGreenLight = Color(
    0xFFEAF1EB,
  ); // Tint for secondary highlights

  // Background & Surfaces
  static const Color backgroundCream = Color(0xFFFAF7F2);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color surfaceSubtle = Color(0xFFF3ECE1);

  // Typography & Text
  static const Color textPrimary = Color(0xFF272522);
  static const Color textSecondary = Color(0xFF6F6A63);
  static const Color textMuted = Color(0xFF8F8A83);

  // Structural & Borders
  static const Color border = Color(0xFFE6DED4);
  static const Color borderFocused = Color(0xFFC96A3D);

  // Semantic Status Colors
  static const Color error = Color(0xFFB84C45);
  static const Color warning = Color(0xFFC68A32);
  static const Color success = Color(0xFF52745A);
}
