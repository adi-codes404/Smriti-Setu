import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smriti_setu/app/theme/app_colors.dart';

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        title: const Text('Setup & Permissions'),
        backgroundColor: AppColors.backgroundCream,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Icon(
              Icons.shield_outlined,
              size: 64,
              color: AppColors.secondaryGreen,
            ),
            const SizedBox(height: 20),
            Text(
              'Let’s get ready',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Smriti Setu may need access to your microphone to record '
              'a voice message. You should review the permission request '
              'shown by your device when recording begins.',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 17,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            _SetupTile(
              icon: Icons.mic_none_rounded,
              title: 'Microphone',
              detail: 'Needed to capture a voice message.',
            ),
            _SetupTile(
              icon: Icons.volume_up_rounded,
              title: 'Audio playback',
              detail: 'Use your device volume to hear recordings.',
            ),
            _SetupTile(
              icon: Icons.wifi_rounded,
              title: 'Sharing',
              detail: 'Sending to family may require a connected service.',
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.secondaryGreenLight,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.secondaryGreen.withValues(alpha: 0.3),
                ),
              ),
              child: const Text(
                'Permission status is not checked on this screen. '
                'This prototype does not request or change device permissions.',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 58,
              child: FilledButton.icon(
                onPressed: () => context.push('/record'),
                icon: const Icon(Icons.arrow_forward_rounded),
                label: const Text('Continue to recording'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primaryTerracotta,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => context.go('/role'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
              ),
              child: const Text('Back to options'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SetupTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;

  const _SetupTile({
    required this.icon,
    required this.title,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryLight,
          child: Icon(icon, color: AppColors.primaryDark),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            detail,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 15,
              height: 1.35,
            ),
          ),
        ),
      ),
    );
  }
}
