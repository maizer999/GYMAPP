import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'exercise.dart';
import 'widgets/exercise_image.dart';

class ExerciseDetailPage extends StatelessWidget {
  const ExerciseDetailPage({super.key, required this.exercise});

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            ExerciseImage(path: exercise.imagePath, height: 240),
            const SizedBox(height: 16),
            _ChipsRow(
              chips: [
                _ChipData(
                  icon: Icons.build_rounded,
                  label: exercise.equipment,
                  color: AppColors.cyanSoft,
                ),
                _ChipData(
                  icon: Icons.trending_up_rounded,
                  label: exercise.difficulty.label,
                  color: AppColors.greenSoft,
                ),
                _ChipData(
                  icon: Icons.timer_rounded,
                  label: '${exercise.restSeconds} ث راحة',
                  color: AppColors.live,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _InfoCard(
              icon: Icons.repeat_rounded,
              iconColor: AppColors.cyanSoft,
              label: 'المجموعات والتكرارات',
              value: exercise.setsRepsLabel,
            ),
            if (exercise.tips.isNotEmpty) ...[
              const SizedBox(height: 12),
              _TipsCard(tips: exercise.tips),
            ],
            const SizedBox(height: 12),
            _InfoCard(
              icon: Icons.favorite_rounded,
              iconColor: AppColors.greenSoft,
              label: 'الفوائد',
              value: exercise.benefits,
            ),
            const SizedBox(height: 12),
            _InfoCard(
              icon: Icons.fitness_center_rounded,
              iconColor: AppColors.live,
              label: 'العضلة الأساسية',
              value: exercise.muscleGroup,
            ),
            if (exercise.secondaryMuscles.isNotEmpty) ...[
              const SizedBox(height: 12),
              _InfoCard(
                icon: Icons.group_rounded,
                iconColor: AppColors.cyanBright,
                label: 'العضلات المساعدة',
                value: exercise.secondaryMuscles.join(' • '),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
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

class _TipsCard extends StatelessWidget {
  const _TipsCard({required this.tips});

  final List<String> tips;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.cyan.withOpacity(0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.cyan.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.lightbulb_rounded,
                  color: AppColors.cyan,
                  size: 18,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'نقاط رئيسية للأداء',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final tip in tips) ...[
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 7),
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.cyan,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      tip,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ChipData {
  const _ChipData({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;
}

class _ChipsRow extends StatelessWidget {
  const _ChipsRow({required this.chips});

  final List<_ChipData> chips;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (final chip in chips)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: chip.color.withOpacity(0.14),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(chip.icon, color: chip.color, size: 14),
                const SizedBox(width: 6),
                Text(
                  chip.label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: chip.color,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
