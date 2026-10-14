import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smriti_setu/app/theme/app_colors.dart';
import 'package:smriti_setu/app/theme/app_spacing.dart';
import 'package:smriti_setu/app/theme/app_typography.dart';
import 'package:smriti_setu/features/archive/data/demo_memories.dart';
import 'package:smriti_setu/features/archive/domain/memory_message.dart';

/// Detail screen displaying the full sample message and simulated audio player.
class MemoryDetailScreen extends StatelessWidget {
  final MemoryMessage? memory;
  final String? memoryId;

  const MemoryDetailScreen({super.key, this.memory, this.memoryId});

  MemoryMessage _resolveMemory() {
    if (memory != null) return memory!;
    if (memoryId != null) {
      return kDemoMemories.firstWhere(
        (m) => m.id == memoryId,
        orElse: () => kDemoMemories.first,
      );
    }
    return kDemoMemories.first;
  }

  void _handlePlayPressed(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Audio playback is simulated in this demo. Please read the full message below.',
        ),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'OK',
          textColor: AppColors.secondaryGreen,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void _hearFullMessage(BuildContext context, MemoryMessage resolved) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Message from ${resolved.sender}: "${resolved.fullText}"',
        ),
        duration: const Duration(seconds: 8),
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
    final resolved = _resolveMemory();

    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        title: const Text('Memory Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: 'Back to archive',
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/archive');
            }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sender & Metadata Header Card
              Container(
                padding: AppSpacing.paddingCard,
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: const BoxDecoration(
                            color: AppColors.secondaryGreenLight,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person_rounded,
                            color: AppColors.secondaryGreen,
                            size: 28,
                          ),
                        ),
                        AppSpacing.horizontalM,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                resolved.sender,
                                style: AppTypography.h2.copyWith(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                resolved.relationship,
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryGreenLight,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.secondaryGreen,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            'Demo Data',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.secondaryGreen,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.verticalM,
                    const Divider(color: AppColors.border, height: 1),
                    AppSpacing.verticalM,
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today_rounded,
                          size: 18,
                          color: AppColors.textSecondary,
                        ),
                        AppSpacing.horizontalS,
                        Text(
                          resolved.date,
                          style: AppTypography.caption.copyWith(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        AppSpacing.horizontalL,
                        const Icon(
                          Icons.timer_outlined,
                          size: 18,
                          color: AppColors.textSecondary,
                        ),
                        AppSpacing.horizontalS,
                        Text(
                          '${resolved.duration} minutes',
                          style: AppTypography.caption.copyWith(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppSpacing.verticalL,

              // Simulated Audio Player
              Container(
                padding: const EdgeInsets.all(AppSpacing.space20),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border, width: 1.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.graphic_eq_rounded,
                          color: AppColors.secondaryGreen,
                          size: 24,
                        ),
                        AppSpacing.horizontalS,
                        Text(
                          'A Voice From Family',
                          style: AppTypography.caption.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.secondaryGreen,
                            fontSize: 14,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          resolved.duration,
                          style: AppTypography.caption.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.verticalM,

                    // Audio Waveform Visual Bar Graphic
                    Row(
                      children: [
                        Semantics(
                          button: true,
                          label: 'Simulated audio play button',
                          child: InkWell(
                            onTap: () => _handlePlayPressed(context),
                            borderRadius: BorderRadius.circular(28),
                            child: Container(
                              width: 56,
                              height: 56,
                              decoration: const BoxDecoration(
                                color: AppColors.secondaryGreen,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: AppColors.surfaceWhite,
                                size: 36,
                              ),
                            ),
                          ),
                        ),
                        AppSpacing.horizontalM,
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              for (final height in [
                                12.0,
                                20.0,
                                34.0,
                                26.0,
                                14.0,
                                28.0,
                                40.0,
                                30.0,
                                16.0,
                                24.0,
                                36.0,
                                22.0,
                                14.0,
                                30.0,
                                18.0,
                                10.0,
                              ])
                                Container(
                                  width: 4.5,
                                  height: height,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryGreen.withValues(
                                      alpha: 0.75,
                                    ),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.verticalM,

                    // Player Notice
                    Text(
                      'This is a sample memory. The written message is available below; audio playback is not active yet.',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.textMuted,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.verticalL,

              // Full Message Transcription Card
              Container(
                padding: const EdgeInsets.all(AppSpacing.space24),
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppColors.primaryTerracotta.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.format_quote_rounded,
                          color: AppColors.primaryTerracotta,
                          size: 26,
                        ),
                        AppSpacing.horizontalS,
                        Text(
                          'A Message to Remember',
                          style: AppTypography.h3.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.verticalM,
                    Text(
                      resolved.fullText,
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 19,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.verticalXxl,

              // Accessibility: Hear message read aloud
              Center(
                child: Semantics(
                  button: true,
                  label: 'Hear message read out loud',
                  child: OutlinedButton.icon(
                    onPressed: () => _hearFullMessage(context, resolved),
                    icon: const Icon(
                      Icons.volume_up_rounded,
                      size: 24,
                      color: AppColors.secondaryGreen,
                    ),
                    label: Text(
                      'Hear this message',
                      style: AppTypography.button.copyWith(
                        color: AppColors.secondaryGreen,
                        fontSize: 16,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: AppColors.secondaryGreen,
                        width: 1.5,
                      ),
                      backgroundColor: AppColors.surfaceWhite,
                      minimumSize: const Size.fromHeight(56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
              AppSpacing.verticalM,

              // Back to Archive Button
              OutlinedButton.icon(
                onPressed: () {
                  if (context.canPop()) {
                    context.pop();
                  } else {
                    context.go('/archive');
                  }
                },
                icon: const Icon(Icons.arrow_back_rounded, size: 24),
                label: const Text('BACK TO ARCHIVE'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
              ),
              AppSpacing.verticalL,
            ],
          ),
        ),
      ),
    );
  }
}
