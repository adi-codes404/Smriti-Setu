import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smriti_setu/app/theme/app_colors.dart';
import 'package:smriti_setu/app/theme/app_spacing.dart';
import 'package:smriti_setu/app/theme/app_typography.dart';
import 'package:smriti_setu/core/widgets/app_brand_mark.dart';

/// Screen 1 — Splash / Brand
///
/// Communicates WHAT Smriti Setu is:
/// "A bridge for voices, memories and people."
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(
          CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
        );

    // Trigger subtle entrance animation
    _animController.forward();

    // Navigate to /role after ~1.5 seconds
    _navigationTimer = Timer(const Duration(milliseconds: 1600), () {
      if (mounted) {
        context.go('/role');
      }
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: AppSpacing.paddingScreen,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),

                    // Brand Mark: Voice -> Bridge -> Memory
                    const AppBrandMark(size: 110),
                    AppSpacing.verticalXl,

                    // Brand Name
                    Text(
                      'Smriti Setu',
                      style: AppTypography.display.copyWith(
                        color: AppColors.primaryTerracotta,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                    AppSpacing.verticalM,

                    // Brand Subtitle
                    Text(
                      'A bridge for voices, memories and people.',
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        height: 1.35,
                      ),
                    ),
                    AppSpacing.verticalS,

                    // Small supporting line
                    Text(
                      'Voice • Connect • Remember',
                      textAlign: TextAlign.center,
                      style: AppTypography.caption.copyWith(
                        color: AppColors.secondaryGreen,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const Spacer(),

                    // Bottom Calm Indicator
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.border,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    AppSpacing.verticalM,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
