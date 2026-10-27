import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/utils/health_calculations.dart';
import 'dashboard_controller.dart';
import 'widgets/clock_card.dart';
import 'widgets/hourly_chart.dart';
import 'widgets/metric_card.dart';
import 'widgets/step_ring.dart';
import 'widgets/stopwatch_card.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardControllerProvider);

    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!state.permissionGranted) {
      return _PermissionPrompt(
        onGrant: () => ref.read(dashboardControllerProvider.notifier).requestPermission(),
      );
    }

    final distanceKm = HealthCalculations.metersToKilometers(state.distanceMeters);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
        children: [
          const ClockCard(),
          const SizedBox(height: 12),
          const StopwatchCard(),
          const SizedBox(height: 20),
          Text(
            'Today',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 20),
          Center(
            child: StepRing(
              steps: state.steps,
              goal: state.dailyGoal,
              progress: state.progress,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: MetricCard(
                  label: 'Distance',
                  value: distanceKm.toStringAsFixed(2),
                  unit: 'km',
                  icon: Icons.route_outlined,
                  accentColor: AppColors.distanceColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: MetricCard(
                  label: 'Active calories',
                  value: state.activeCalories.toStringAsFixed(0),
                  unit: 'kcal',
                  icon: Icons.local_fire_department_outlined,
                  accentColor: AppColors.caloriesColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text(
            'Hourly breakdown',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 180,
            child: HourlyChart(hourlySteps: state.hourlySteps),
          ),
        ],
      ),
    );
  }
}

class _PermissionPrompt extends StatelessWidget {
  const _PermissionPrompt({required this.onGrant});

  final VoidCallback onGrant;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.directions_walk,
              size: 56,
              color: AppColors.primary,
            ),
            const SizedBox(height: 16),
            const Text(
              'Allow step tracking',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'StepPulse needs physical activity permission to count your '
              'steps in real time. Nothing leaves your device.',
              style: TextStyle(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: onGrant,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Text('Grant permission'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
