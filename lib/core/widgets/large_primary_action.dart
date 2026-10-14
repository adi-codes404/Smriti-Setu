import 'package:flutter/material.dart';
import 'package:smriti_setu/app/theme/app_colors.dart';
import 'package:smriti_setu/app/theme/app_spacing.dart';
import 'package:smriti_setu/app/theme/app_typography.dart';

/// A prominent, large circular action button designed for elderly accessibility.
///
/// Features:
/// - Generous touch target (>= 120px diameter, default 140px)
/// - High-contrast terracotta palette with depth cues
/// - Large iconic typography and supporting description
/// - Full accessibility semantics for screen readers
class LargePrimaryAction extends StatefulWidget {
  final IconData icon;
  final String label;
  final String supportingText;
  final VoidCallback onTap;
  final double diameter;
  final Color backgroundColor;
  final Color iconColor;

  const LargePrimaryAction({
    super.key,
    required this.icon,
    required this.label,
    required this.supportingText,
    required this.onTap,
    this.diameter = 140.0,
    this.backgroundColor = AppColors.primaryTerracotta,
    this.iconColor = AppColors.surfaceWhite,
  });

  @override
  State<LargePrimaryAction> createState() => _LargePrimaryActionState();
}

class _LargePrimaryActionState extends State<LargePrimaryAction> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '${widget.label}. ${widget.supportingText}',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Circular Button with tactile feedback
          GestureDetector(
            onTapDown: (_) => setState(() => _isPressed = true),
            onTapUp: (_) {
              setState(() => _isPressed = false);
              widget.onTap();
            },
            onTapCancel: () => setState(() => _isPressed = false),
            child: AnimatedScale(
              scale: _isPressed ? 0.94 : 1.0,
              duration: const Duration(milliseconds: 120),
              curve: Curves.easeInOut,
              child: Container(
                width: widget.diameter,
                height: widget.diameter,
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primaryDark, width: 3.5),
                  boxShadow: [
                    BoxShadow(
                      color: widget.backgroundColor.withValues(alpha: 0.35),
                      blurRadius: 18,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    widget.icon,
                    size: widget.diameter * 0.44,
                    color: widget.iconColor,
                  ),
                ),
              ),
            ),
          ),
          AppSpacing.verticalM,

          // Clear, bold primary action label
          Text(
            widget.label,
            textAlign: TextAlign.center,
            style: AppTypography.h2.copyWith(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: 0.5,
            ),
          ),
          AppSpacing.verticalXs,

          // Clear supporting text
          Text(
            widget.supportingText,
            textAlign: TextAlign.center,
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
              fontSize: 18,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
