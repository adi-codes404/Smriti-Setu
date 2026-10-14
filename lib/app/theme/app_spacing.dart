import 'package:flutter/material.dart';

/// Centralized 8-point grid spacing system for Smriti Setu.
///
/// Follows: 4, 8, 16, 24, 32, 40, 48, 64
abstract final class AppSpacing {
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space16 = 16.0;
  static const double space24 = 24.0;
  static const double space32 = 32.0;
  static const double space40 = 40.0;
  static const double space48 = 48.0;
  static const double space64 = 64.0;

  // Semantic aliases
  static const double xs = space4;
  static const double s = space8;
  static const double m = space16;
  static const double l = space24;
  static const double xl = space32;
  static const double xxl = space40;
  static const double xxxl = space48;
  static const double huge = space64;

  // Standard Edge Insets
  static const EdgeInsets paddingScreen = EdgeInsets.symmetric(
    horizontal: space24,
    vertical: space24,
  );

  static const EdgeInsets paddingCard = EdgeInsets.all(space20);
  static const double space20 = 20.0;

  static const EdgeInsets paddingButton = EdgeInsets.symmetric(
    horizontal: space24,
    vertical: space16,
  );

  // Common SizedBox spacers
  static const SizedBox verticalXs = SizedBox(height: xs);
  static const SizedBox verticalS = SizedBox(height: s);
  static const SizedBox verticalM = SizedBox(height: m);
  static const SizedBox verticalL = SizedBox(height: l);
  static const SizedBox verticalXl = SizedBox(height: xl);
  static const SizedBox verticalXxl = SizedBox(height: xxl);
  static const SizedBox verticalHuge = SizedBox(height: huge);

  static const SizedBox horizontalXs = SizedBox(width: xs);
  static const SizedBox horizontalS = SizedBox(width: s);
  static const SizedBox horizontalM = SizedBox(width: m);
  static const SizedBox horizontalL = SizedBox(width: l);
  static const SizedBox horizontalXl = SizedBox(width: xl);
}
