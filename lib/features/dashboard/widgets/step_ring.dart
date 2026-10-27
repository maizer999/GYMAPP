import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../core/constants/app_colors.dart';

/// The dashboard's centerpiece: today's steps vs. goal as a circular ring.
/// Built on `percent_indicator` rather than a hand-rolled CustomPainter —
/// it covers the same ground (animated arc, center child) with far less
/// code, and `flutter_animate` layers in the one-off "pop" when the ring
/// first renders so hitting a milestone later (100%) feels like an event.
class StepRing extends StatelessWidget {
  const StepRing({
    super.key,
    required this.steps,
    required this.goal,
    required this.progress,
  });

  final int steps;
  final int goal;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 110,
      lineWidth: 16,
      percent: progress,
      animation: true,
      animationDuration: 800,
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: AppColors.ringTrack,
      progressColor: AppColors.ringProgress,
      center: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$steps',
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'of $goal steps',
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).scale(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
          duration: 400.ms,
        );
  }
}
