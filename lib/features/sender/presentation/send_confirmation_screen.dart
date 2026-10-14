import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smriti_setu/app/theme/app_colors.dart';
import 'package:smriti_setu/app/theme/app_spacing.dart';
import 'package:smriti_setu/app/theme/app_typography.dart';
import 'package:smriti_setu/features/sender/presentation/record_message_screen.dart';

/// Screen displayed after a message is sent.
///
/// Features:
/// - Reassuring check icon and warm typography
/// - Clear confirmation: “Your message is ready for your family.”
/// - Transparent local demo explanation (no actual message transmitted)
/// - Prominent Return Home button
class SendConfirmationScreen extends StatelessWidget {
  final String? sentMessage;

  const SendConfirmationScreen({super.key, this.sentMessage});

  void _returnHome(BuildContext context) {
    context.go('/elderly-home');
  }

  void _hearScreen(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Confirmation screen. Your message is ready for your family. '
          'Please note that this is a local demo and no message was actually transmitted. '
          'Press the Return Home button to go back to the home screen.',
        ),
        duration: const Duration(seconds: 6),
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
    final displayMessage = sentMessage ?? RecordMessageScreen.sampleMessage;

    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: AppSpacing.paddingScreen,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppSpacing.verticalL,

                // Big Warm Check Icon Container
                Center(
                  child: Semantics(
                    label: 'Success check icon',
                    child: Container(
                      width: 104,
                      height: 104,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryGreenLight,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.secondaryGreen,
                          width: 3.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.secondaryGreen.withValues(
                              alpha: 0.2,
                            ),
                            blurRadius: 18,
                            spreadRadius: 2,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check_rounded,
                          size: 58,
                          color: AppColors.secondaryGreen,
                        ),
                      ),
                    ),
                  ),
                ),
                AppSpacing.verticalXl,

                // Warm Confirmation Headline
                Text(
                  'Your message is ready for your family.',
                  textAlign: TextAlign.center,
                  style: AppTypography.h1.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                    height: 1.3,
                  ),
                ),
                AppSpacing.verticalM,

                // Warm Reassurance Subtitle
                Text(
                  'Your warm words and memory have been prepared with love.',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textSecondary,
                    fontSize: 18,
                    height: 1.4,
                  ),
                ),
                AppSpacing.verticalXl,

                // Sent Message Preview Box
                Container(
                  padding: AppSpacing.paddingCard,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceWhite,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border, width: 1.5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.format_quote_rounded,
                            color: AppColors.secondaryGreen,
                            size: 22,
                          ),
                          AppSpacing.horizontalXs,
                          Text(
                            'Recorded Content',
                            style: AppTypography.caption.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.secondaryGreen,
                            ),
                          ),
                        ],
                      ),
                      AppSpacing.verticalS,
                      Text(
                        '“$displayMessage”',
                        style: AppTypography.body.copyWith(
                          color: AppColors.textPrimary,
                          fontSize: 17,
                          fontStyle: FontStyle.italic,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.verticalL,

                // Local Demo Explanation Banner
                Container(
                  padding: const EdgeInsets.all(AppSpacing.space16),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceSubtle,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColors.border.withValues(alpha: 0.8),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.info_outline_rounded,
                        color: AppColors.primaryTerracotta,
                        size: 24,
                      ),
                      AppSpacing.horizontalM,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Local Demo Notice',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.primaryDark,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                            AppSpacing.verticalXs,
                            Text(
                              'This is a local demonstration. No audio or message has actually been transmitted over the network or saved to an external server.',
                              style: AppTypography.caption.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpacing.verticalXxl,

                // Return Home Button
                FilledButton.icon(
                  onPressed: () => _returnHome(context),
                  icon: const Icon(Icons.home_rounded, size: 26),
                  label: const Text('RETURN HOME'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    backgroundColor: AppColors.primaryTerracotta,
                    foregroundColor: AppColors.surfaceWhite,
                  ),
                ),
                AppSpacing.verticalL,

                // Accessibility: Hear this screen
                Center(
                  child: Semantics(
                    button: true,
                    label: 'Hear confirmation instructions',
                    child: TextButton.icon(
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
                    ),
                  ),
                ),
                AppSpacing.verticalM,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
