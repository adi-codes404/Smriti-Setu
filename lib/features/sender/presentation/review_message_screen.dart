import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smriti_setu/app/theme/app_colors.dart';
import 'package:smriti_setu/app/theme/app_spacing.dart';
import 'package:smriti_setu/app/theme/app_typography.dart';
import 'package:smriti_setu/features/sender/presentation/record_message_screen.dart';

/// Screen for reviewing a voice message before sending.
///
/// Provides a readable preview card, explicit "Demo message" labeling,
/// and Back, Edit Message, and Send Message actions.
class ReviewMessageScreen extends StatefulWidget {
  final String? initialMessage;

  const ReviewMessageScreen({super.key, this.initialMessage});

  @override
  State<ReviewMessageScreen> createState() => _ReviewMessageScreenState();
}

class _ReviewMessageScreenState extends State<ReviewMessageScreen> {
  late String _message;
  bool _isCustomEdited = false;

  @override
  void initState() {
    super.initState();
    _message = widget.initialMessage ?? RecordMessageScreen.sampleMessage;
  }

  void _handleBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/record');
    }
  }

  void _handleSend() {
    context.push('/confirmation', extra: _message);
  }

  Future<void> _handleEditMessage() async {
    final textController = TextEditingController(text: _message);

    final updated = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.backgroundCream,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Edit Message',
            style: AppTypography.h2.copyWith(color: AppColors.textPrimary),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Change your message text below:',
                  style: AppTypography.body.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                AppSpacing.verticalM,
                TextField(
                  controller: textController,
                  maxLines: 4,
                  autofocus: true,
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.surfaceWhite,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.border,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.primaryTerracotta,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'CANCEL',
                style: AppTypography.button.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            FilledButton(
              onPressed: () {
                final trimmed = textController.text.trim();
                Navigator.of(
                  dialogContext,
                ).pop(trimmed.isNotEmpty ? trimmed : _message);
              },
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primaryTerracotta,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text('SAVE'),
            ),
          ],
        );
      },
    );

    if (updated != null && updated != _message && mounted) {
      setState(() {
        _message = updated;
        _isCustomEdited = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Message updated successfully.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _hearScreen(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Review Screen. Your message is: "$_message". '
          'You can tap Send Message to send to your family, or tap Edit Message to change it.',
        ),
        duration: const Duration(seconds: 6),
        action: SnackBarAction(
          label: 'DISMISS',
          textColor: AppColors.primaryTerracotta,
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
        title: const Text('Review Message'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: 'Back to recording',
          onPressed: _handleBack,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.paddingScreen,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Text(
                'Review Your Message',
                style: AppTypography.h1.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 27,
                ),
              ),
              AppSpacing.verticalS,
              Text(
                'Please check your message before sending it to your family.',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 18,
                ),
              ),
              AppSpacing.verticalXl,

              // Readable Preview Card
              Container(
                padding: AppSpacing.paddingCard,
                decoration: BoxDecoration(
                  color: AppColors.surfaceWhite,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textPrimary.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge & Meta Row
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryLight,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.mic_rounded,
                            color: AppColors.primaryTerracotta,
                            size: 24,
                          ),
                        ),
                        AppSpacing.horizontalM,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Voice Message for Family',
                                style: AppTypography.h3.copyWith(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                'Recipients: Loved Ones',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.textSecondary,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Prominent "Demo message" badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: _isCustomEdited
                                ? AppColors.secondaryGreenLight
                                : AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: _isCustomEdited
                                  ? AppColors.secondaryGreen
                                  : AppColors.primaryTerracotta,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            _isCustomEdited ? 'Edited demo' : 'Demo message',
                            style: AppTypography.caption.copyWith(
                              color: _isCustomEdited
                                  ? AppColors.secondaryGreen
                                  : AppColors.primaryDark,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppSpacing.verticalL,
                    const Divider(color: AppColors.border, height: 1),
                    AppSpacing.verticalL,

                    // Transcription Message Text in generous, readable typography
                    Text(
                      '“$_message”',
                      style: AppTypography.h3.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 20,
                        height: 1.45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    AppSpacing.verticalL,

                    // Simulated Audio Waveform Bar Graphic
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundCream,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.play_arrow_rounded,
                            color: AppColors.primaryTerracotta,
                            size: 28,
                          ),
                          AppSpacing.horizontalS,
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                for (final height in [
                                  10.0,
                                  18.0,
                                  28.0,
                                  14.0,
                                  24.0,
                                  32.0,
                                  20.0,
                                  16.0,
                                  26.0,
                                  12.0,
                                  22.0,
                                  30.0,
                                  18.0,
                                  10.0,
                                ])
                                  Container(
                                    width: 4,
                                    height: height,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryTerracotta
                                          .withValues(alpha: 0.7),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          AppSpacing.horizontalS,
                          Text(
                            '0:15',
                            style: AppTypography.caption.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacing.verticalXxl,

              // Primary Action: SEND MESSAGE
              FilledButton.icon(
                onPressed: _handleSend,
                icon: const Icon(Icons.send_rounded, size: 24),
                label: const Text('SEND MESSAGE'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                  backgroundColor: AppColors.primaryTerracotta,
                  foregroundColor: AppColors.surfaceWhite,
                ),
              ),
              AppSpacing.verticalM,

              // Secondary Action: EDIT MESSAGE
              OutlinedButton.icon(
                onPressed: _handleEditMessage,
                icon: const Icon(
                  Icons.edit_note_rounded,
                  size: 24,
                  color: AppColors.primaryDark,
                ),
                label: Text(
                  'EDIT MESSAGE',
                  style: AppTypography.button.copyWith(
                    color: AppColors.primaryDark,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                  side: const BorderSide(
                    color: AppColors.primaryTerracotta,
                    width: 2,
                  ),
                  backgroundColor: AppColors.surfaceWhite,
                ),
              ),
              AppSpacing.verticalM,

              // Tertiary Action: BACK
              OutlinedButton.icon(
                onPressed: _handleBack,
                icon: const Icon(Icons.arrow_back_rounded, size: 24),
                label: const Text('BACK'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
              ),
              AppSpacing.verticalXl,

              // Accessibility: Hear this screen
              Center(
                child: Semantics(
                  button: true,
                  label: 'Hear this screen text read aloud',
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
              AppSpacing.verticalL,
            ],
          ),
        ),
      ),
    );
  }
}
