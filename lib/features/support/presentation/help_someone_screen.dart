import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smriti_setu/app/theme/app_colors.dart';

class HelpSomeoneScreen extends StatelessWidget {
  const HelpSomeoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      appBar: AppBar(
        title: const Text('Help Someone'),
        backgroundColor: AppColors.backgroundCream,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Icon(
              Icons.volunteer_activism_rounded,
              size: 64,
              color: AppColors.secondaryGreen,
            ),
            const SizedBox(height: 20),
            Text(
              'A little help means a lot.',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Help a family member record a voice message '
              'and share a memory with someone they love.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 28),
            _StepTile(
              number: '1',
              title: 'Get comfortable',
              description: 'Help them sit comfortably and decide what to say.',
            ),
            _StepTile(
              number: '2',
              title: 'Record their voice',
              description: 'Open the recording screen and follow the prompts.',
            ),
            _StepTile(
              number: '3',
              title: 'Review together',
              description: 'Listen or review the message before continuing.',
            ),
            _StepTile(
              number: '4',
              title: 'Continue to sharing',
              description: 'Follow the confirmation screen to finish the demo.',
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 60,
              child: FilledButton.icon(
                onPressed: () => context.push('/record'),
                icon: const Icon(Icons.mic_rounded, size: 26),
                label: const Text('Start recording'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primaryTerracotta,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => context.push('/permissions'),
              icon: const Icon(Icons.settings_outlined),
              label: const Text('Check setup and permissions'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(56),
                foregroundColor: AppColors.primaryDark,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Demo note: message delivery and device permissions '
              'may not be connected in this prototype.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  final String number;
  final String title;
  final String description;

  const _StepTile({
    required this.number,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.secondaryGreenLight,
            child: Text(
              number,
              style: const TextStyle(
                color: AppColors.secondaryGreen,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
