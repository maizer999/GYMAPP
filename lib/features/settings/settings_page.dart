import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/database/user_profile.dart';
import 'settings_controller.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _goalController = TextEditingController();
  bool _initialized = false;

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _goalController.dispose();
    super.dispose();
  }

  void _populateFrom(UserProfile profile) {
    if (_initialized) return;
    _heightController.text = profile.heightCm.toStringAsFixed(0);
    _weightController.text = profile.weightKg.toStringAsFixed(0);
    _goalController.text = profile.dailyStepGoal.toString();
    _initialized = true;
  }

  Future<void> _save() async {
    final height = double.tryParse(_heightController.text);
    final weight = double.tryParse(_weightController.text);
    final goal = int.tryParse(_goalController.text);

    if (height == null || weight == null || goal == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid numbers.')),
      );
      return;
    }

    await ref.read(settingsControllerProvider.notifier).save(
          heightCm: height,
          weightKg: weight,
          dailyStepGoal: goal,
        );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(settingsControllerProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: profileAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Center(child: Text('Could not load: $err')),
                data: (profile) {
                  _populateFrom(profile);
                  return ListView(
                    children: [
                      _LabeledField(
                        label: 'Height (cm)',
                        controller: _heightController,
                      ),
                      const SizedBox(height: 16),
                      _LabeledField(
                        label: 'Weight (kg)',
                        controller: _weightController,
                      ),
                      const SizedBox(height: 16),
                      _LabeledField(
                        label: 'Daily step goal',
                        controller: _goalController,
                      ),
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: _save,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Center(child: Text('Save profile')),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({required this.label, required this.controller});

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.surface,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
