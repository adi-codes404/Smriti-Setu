import 'package:flutter/material.dart';
import 'package:smriti_setu/app/theme/app_colors.dart';
import 'package:smriti_setu/app/theme/app_spacing.dart';
import 'package:smriti_setu/app/theme/app_typography.dart';

/// A high-contrast, large-touch-target action card built for accessibility.
///
/// Designed specifically for elderly and digitally excluded users:
/// - Prominent icon container
/// - Generous touch targets (>64px)
/// - High contrast borders and typography
/// - Clear visual hierarchy support via [isEmphasized]
class AccessibleActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback? onTap;
  final bool isEmphasized;
  final String? badgeText;
  final Color? iconColor;
  final Color? iconBackgroundColor;

  const AccessibleActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.onTap,
    this.isEmphasized = false,
    this.badgeText,
    this.iconColor,
    this.iconBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = isEmphasized
        ? AppColors.primaryTerracotta
        : AppColors.border;

    final effectiveBorderWidth = isEmphasized ? 2.5 : 1.5;

    final effectiveCardColor = isEmphasized
        ? AppColors.surfaceWhite
        : AppColors.surfaceWhite;

    final effectiveIconColor =
        iconColor ??
        (isEmphasized ? AppColors.primaryTerracotta : AppColors.secondaryGreen);

    final effectiveIconBg =
        iconBackgroundColor ??
        (isEmphasized ? AppColors.primaryLight : AppColors.secondaryGreenLight);

    return Semantics(
      button: true,
      enabled: onTap != null,
      label: '$title. $description${badgeText != null ? '. $badgeText' : ''}',
      child: Material(
        color: effectiveCardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: effectiveBorderColor,
            width: effectiveBorderWidth,
          ),
        ),
        elevation: isEmphasized ? 2 : 0,
        shadowColor: AppColors.primaryTerracotta.withValues(alpha: 0.15),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space20,
              vertical: AppSpacing.space20,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Prominent Icon Container (Min 56x56)
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: effectiveIconBg,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: effectiveBorderColor.withValues(alpha: 0.5),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Icon(icon, size: 32, color: effectiveIconColor),
                  ),
                ),
                AppSpacing.horizontalM,

                // Content (Title & Description)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (badgeText != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 3,
                          ),
                          margin: const EdgeInsets.only(bottom: 6),
                          decoration: BoxDecoration(
                            color: isEmphasized
                                ? AppColors.primaryTerracotta
                                : AppColors.surfaceSubtle,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            badgeText!,
                            style: AppTypography.caption.copyWith(
                              color: isEmphasized
                                  ? AppColors.surfaceWhite
                                  : AppColors.textSecondary,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                      Text(
                        title,
                        style: AppTypography.h3.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: isEmphasized
                              ? AppColors.primaryDark
                              : AppColors.textPrimary,
                        ),
                      ),
                      AppSpacing.verticalXs,
                      Text(
                        description,
                        style: AppTypography.body.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),

                // Trailing Arrow for affordance
                AppSpacing.horizontalS,
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                  color: isEmphasized
                      ? AppColors.primaryTerracotta
                      : AppColors.border,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
