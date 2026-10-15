import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smriti_setu/app/theme/app_colors.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  void _hearOptions(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Send a message, receive and remember, or help someone record.',
        ),
        duration: Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF8F3),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            Row(
              children: [
                IconButton(
                  tooltip: 'Go back',
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/');
                    }
                  },
                  icon: const Icon(Icons.arrow_back_rounded),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () => _hearOptions(context),
                  icon: const Icon(Icons.volume_up_rounded, size: 20),
                  label: const Text('Hear these options'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.secondaryGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'How will you use Smriti Setu?',
              style: TextStyle(
                color: Color(0xFF1D1B18),
                fontSize: 27,
                height: 1.2,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Choose the option that fits you today.',
              style: TextStyle(
                color: Color(0xFF55433B),
                fontSize: 15,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 22),
            _RoleCard(
              icon: Icons.mic_rounded,
              title: 'SEND A MESSAGE',
              subtitle: 'Share your voice with your family.',
              color: const Color(0xFF964319),
              iconBackground: const Color(0xFFFFDBCD),
              emphasized: true,
              onTap: () => context.push('/elderly-home'),
            ),
            const SizedBox(height: 12),
            _RoleCard(
              icon: Icons.headphones_rounded,
              title: 'RECEIVE & REMEMBER',
              subtitle: 'Listen to messages and revisit memories.',
              color: const Color(0xFF44664D),
              iconBackground: const Color(0xFFC6ECCC),
              onTap: () => context.push('/archive'),
            ),
            const SizedBox(height: 12),
            _RoleCard(
              icon: Icons.people_alt_rounded,
              title: 'HELP SOMEONE',
              subtitle: 'Help a loved one use Smriti Setu.',
              color: const Color(0xFF44664D),
              iconBackground: const Color(0xFFC6ECCC),
              onTap: () => context.push('/help-someone'),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F3ED),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFDBC1B7)),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.volunteer_activism_rounded,
                    color: Color(0xFF44664D),
                    size: 24,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Need help? Tap “Help Someone” to see how you can '
                      'support a family member.',
                      style: TextStyle(
                        color: Color(0xFF55433B),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final Color iconBackground;
  final bool emphasized;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.iconBackground,
    required this.onTap,
    this.emphasized = false,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '$title. $subtitle',
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            constraints: const BoxConstraints(minHeight: 84),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: emphasized ? color : const Color(0xFFE6DED4),
                width: emphasized ? 1.8 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: iconBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: color,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Color(0xFF6F6A63),
                          fontSize: 13,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: color.withValues(alpha: 0.75),
                  size: 17,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
