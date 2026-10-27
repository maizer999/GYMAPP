import 'package:flutter/material.dart';

enum MilestoneMetric { totalSteps, streakDays, singleDayGoal }

class MilestoneDefinition {
  const MilestoneDefinition({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.metric,
    required this.threshold,
  });

  final String id;
  final String title;
  final String description;
  final IconData icon;
  final MilestoneMetric metric;
  final int threshold;
}

/// Static badge catalog. Kept as plain data (not persisted) since
/// "achieved or not" is always recomputed from ActivityRecord history —
/// there's nothing here that needs its own database row.
const kMilestones = <MilestoneDefinition>[
  MilestoneDefinition(
    id: 'first_steps',
    title: 'First Steps',
    description: 'Log your very first steps',
    icon: Icons.emoji_flags_outlined,
    metric: MilestoneMetric.totalSteps,
    threshold: 1,
  ),
  MilestoneDefinition(
    id: 'ten_k_lifetime',
    title: '10K Club',
    description: 'Reach 10,000 lifetime steps',
    icon: Icons.military_tech_outlined,
    metric: MilestoneMetric.totalSteps,
    threshold: 10000,
  ),
  MilestoneDefinition(
    id: 'hundred_k_lifetime',
    title: 'Century Walker',
    description: 'Reach 100,000 lifetime steps',
    icon: Icons.workspace_premium_outlined,
    metric: MilestoneMetric.totalSteps,
    threshold: 100000,
  ),
  MilestoneDefinition(
    id: 'million_lifetime',
    title: 'Millionaire Mover',
    description: 'Reach 1,000,000 lifetime steps',
    icon: Icons.stars_outlined,
    metric: MilestoneMetric.totalSteps,
    threshold: 1000000,
  ),
  MilestoneDefinition(
    id: 'goal_day',
    title: 'Goal Getter',
    description: 'Hit your daily step goal once',
    icon: Icons.flag_outlined,
    metric: MilestoneMetric.singleDayGoal,
    threshold: 1,
  ),
  MilestoneDefinition(
    id: 'streak_3',
    title: '3-Day Streak',
    description: 'Hit your goal 3 days in a row',
    icon: Icons.local_fire_department_outlined,
    metric: MilestoneMetric.streakDays,
    threshold: 3,
  ),
  MilestoneDefinition(
    id: 'streak_7',
    title: 'Week Warrior',
    description: 'Hit your goal 7 days in a row',
    icon: Icons.whatshot_outlined,
    metric: MilestoneMetric.streakDays,
    threshold: 7,
  ),
  MilestoneDefinition(
    id: 'streak_30',
    title: 'Habit Formed',
    description: 'Hit your goal 30 days in a row',
    icon: Icons.auto_awesome_outlined,
    metric: MilestoneMetric.streakDays,
    threshold: 30,
  ),
];
