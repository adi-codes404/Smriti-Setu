import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smriti_setu/app/theme/app_colors.dart';
import 'package:smriti_setu/app/theme/app_spacing.dart';
import 'package:smriti_setu/app/theme/app_typography.dart';
import 'package:smriti_setu/features/archive/data/demo_memories.dart';
import 'package:smriti_setu/features/archive/domain/memory_message.dart';

/// Screen displaying the list of voice memories in the archive.
///
/// Features:
/// - Screen title: “Memory Archive”
/// - Realistic sample messages with title, sender, and date
/// - Transparent "demo data" labeling
/// - Card tap opens detail view
class MemoryArchiveScreen extends StatelessWidget {
  const MemoryArchiveScreen({super.key});

  void _handleBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/elderly-home');
    }
  }

  void _openDetail(BuildContext context, MemoryMessage memory) {
    context.push('/archive/detail?id=${memory.id}', extra: memory);
  }

  void _hearScreen(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Memory Archive screen. You have 4 demo messages from your family. '
          'Tap any message to read and listen to the full memory.',
        ),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'DISMISS',
          textColor: AppColors.secondaryGreen,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        title: const Text('Memory Archive'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: 'Back to home',
          onPressed: () => _handleBack(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Screen Header
              Text(
                'Memory Archive',
                style: AppTypography.h1.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 27,
                ),
              ),
              AppSpacing.verticalS,
              Text(
                'Listen to and read messages shared by your family.',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 18,
                ),
              ),
              AppSpacing.verticalM,

              // Demo Disclaimer Banner
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space16,
                  vertical: AppSpacing.s,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondaryGreenLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.secondaryGreen.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.secondaryGreen,
                      size: 24,
                    ),
                    AppSpacing.horizontalM,
                    Expanded(
                      child: Text(
                        'Demo Archive • Sample messages shown for testing. Audio playback is not active in this demo.',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.secondaryGreen,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.verticalXl,

              // Memory collection heading
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Your Family Memories',
                      style: AppTypography.h2.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryGreenLight,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${kDemoMemories.length} memories',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.secondaryGreen,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacing.verticalL,

              // List of Sample Messages
              for (final memory in kDemoMemories) ...[
                _buildMemoryCard(context, memory),
                AppSpacing.verticalL,
              ],

              AppSpacing.verticalM,

              // Accessibility: Hear this screen
              Center(
                child: Semantics(
                  button: true,
                  label: 'Hear this screen read out loud',
                  child: OutlinedButton.icon(
                    onPressed: () => _hearScreen(context),
                    icon: const Icon(
                      Icons.volume_up_rounded,
                      size: 24,
                      color: AppColors.primaryDark,
                    ),
                    label: Text(
                      'Hear this screen',
                      style: AppTypography.button.copyWith(
                        color: AppColors.primaryDark,
                        fontSize: 16,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: AppColors.border,
                        width: 1.5,
                      ),
                      backgroundColor: AppColors.surfaceWhite,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
              AppSpacing.verticalL,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMemoryCard(BuildContext context, MemoryMessage memory) {
    return Semantics(
      button: true,
      label:
          '${memory.title}. From ${memory.sender}. Date: ${memory.date}. Tap to open full message.',
      child: Material(
        color: AppColors.surfaceWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide(
            color: AppColors.border.withValues(alpha: 0.8),
            width: 1,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => _openDetail(context, memory),
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryGreenLight,
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: const Icon(
                        Icons.favorite_rounded,
                        color: AppColors.secondaryGreen,
                        size: 27,
                      ),
                    ),
                    AppSpacing.horizontalM,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            memory.sender,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.h3.copyWith(
                              color: AppColors.textPrimary,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            memory.relationship,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.caption.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceSubtle,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'SAMPLE',
                        style: AppTypography.caption.copyWith(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  memory.title,
                  style: AppTypography.h3.copyWith(
                    fontSize: 20,
                    height: 1.25,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryDark,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  memory.preview,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.body.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 15,
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 1,
                  color: AppColors.border.withValues(alpha: 0.6),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 16,
                  runSpacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.calendar_today_rounded,
                          size: 15,
                          color: AppColors.textMuted,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          memory.date,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.textMuted,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.graphic_eq_rounded,
                          size: 17,
                          color: AppColors.secondaryGreen,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          memory.duration,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.secondaryGreen,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    const Icon(
                      Icons.menu_book_rounded,
                      size: 19,
                      color: AppColors.primaryTerracotta,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Read memory',
                        style: AppTypography.button.copyWith(
                          color: AppColors.primaryTerracotta,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundCream,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_forward_rounded,
                        size: 19,
                        color: AppColors.primaryTerracotta,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
