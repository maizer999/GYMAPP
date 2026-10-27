import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

/// Shows the exercise GIF/image, with a graceful fallback to a dumbbell
/// icon when the asset isn't bundled yet — so the page still renders
/// cleanly before the artwork is dropped into assets/images/exercises/.
class ExerciseImage extends StatelessWidget {
  const ExerciseImage({
    super.key,
    required this.path,
    this.height = 180,
    this.borderRadius = 16,
  });

  final String path;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: height,
        width: double.infinity,
        color: AppColors.surface,
        child: Image.asset(
          path,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const _Fallback(),
        ),
      ),
    );
  }
}

class _Fallback extends StatelessWidget {
  const _Fallback();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxHeight < 110;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.fitness_center,
                size: compact ? 28 : 48,
                color: AppColors.textSecondary.withOpacity(0.6),
              ),
              if (!compact) ...[
                const SizedBox(height: 8),
                const Text(
                  'الصورة قريبًا',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
