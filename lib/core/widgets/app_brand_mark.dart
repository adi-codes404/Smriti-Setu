import 'package:flutter/material.dart';
import 'package:smriti_setu/app/theme/app_colors.dart';

/// A custom-drawn vector brand mark for Smriti Setu.
///
/// Symbolizes:
/// - Voice: The dynamic sound waveform bars.
/// - Bridge (Setu): The graceful arch connecting two sides.
/// - Memory (Smriti): The lasting anchor points and grounding resonance.
class AppBrandMark extends StatelessWidget {
  final double size;
  final Color primaryColor;
  final Color secondaryColor;

  const AppBrandMark({
    super.key,
    this.size = 100.0,
    this.primaryColor = AppColors.primaryTerracotta,
    this.secondaryColor = AppColors.secondaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Smriti Setu brand emblem representing voice, bridge, and memory',
      child: CustomPaint(
        size: Size(size, size),
        painter: _BrandMarkPainter(
          primaryColor: primaryColor,
          secondaryColor: secondaryColor,
        ),
      ),
    );
  }
}

class _BrandMarkPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;

  _BrandMarkPainter({required this.primaryColor, required this.secondaryColor});

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // Bridge Arch (Setu)
    final bridgePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.055
      ..strokeCap = StrokeCap.round;

    final bridgePath = Path();
    // Gentle parabolic arch spanning across the lower center
    final startPoint = Offset(w * 0.12, h * 0.76);
    final controlPoint = Offset(w * 0.50, h * 0.44);
    final endPoint = Offset(w * 0.88, h * 0.76);

    bridgePath.moveTo(startPoint.dx, startPoint.dy);
    bridgePath.quadraticBezierTo(
      controlPoint.dx,
      controlPoint.dy,
      endPoint.dx,
      endPoint.dy,
    );
    canvas.drawPath(bridgePath, bridgePaint);

    // Ground / Water Resonance Baseline
    final baseLinePaint = Paint()
      ..color = secondaryColor.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.03
      ..strokeCap = StrokeCap.round;

    final basePath = Path();
    basePath.moveTo(w * 0.22, h * 0.84);
    basePath.quadraticBezierTo(w * 0.50, h * 0.88, w * 0.78, h * 0.84);
    canvas.drawPath(basePath, baseLinePaint);

    // Anchor Nodes at Bridge Pillars
    final nodePaint = Paint()
      ..color = secondaryColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(w * 0.12, h * 0.76), w * 0.045, nodePaint);
    canvas.drawCircle(Offset(w * 0.88, h * 0.76), w * 0.045, nodePaint);

    // Voice Waveform Bars rising above the bridge
    // 7 symmetrical bars representing speech, sound, and dialogue
    final barFractions = [0.28, 0.45, 0.70, 1.0, 0.70, 0.45, 0.28];
    final double barSpacing = w * 0.09;
    final double barWidth = w * 0.042;
    final double startX = w * 0.50 - (barSpacing * 3);
    final double baselineY = h * 0.56;

    for (int i = 0; i < barFractions.length; i++) {
      final double fraction = barFractions[i];
      final double x = startX + (i * barSpacing);
      final double barHeight = h * 0.36 * fraction;
      final double topY = baselineY - barHeight;

      // Color gradation: center bar in prominent terracotta, outer bars in secondary green
      final Color barColor = (i == 3)
          ? primaryColor
          : (i == 2 || i == 4)
          ? Color.lerp(primaryColor, secondaryColor, 0.4)!
          : secondaryColor;

      final wavePaint = Paint()
        ..color = barColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = barWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(
        Offset(x, topY),
        Offset(x, baselineY - (h * 0.04 * (1 - fraction))),
        wavePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BrandMarkPainter oldDelegate) {
    return oldDelegate.primaryColor != primaryColor ||
        oldDelegate.secondaryColor != secondaryColor;
  }
}
