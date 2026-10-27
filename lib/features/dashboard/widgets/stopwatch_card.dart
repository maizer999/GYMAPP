import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

/// Lightweight stopwatch: Start / Pause / Reset. State is kept locally
/// in this widget — it isn't persisted across app restarts because the
/// stopwatch is for ad-hoc timing (a quick walk, a stretch set), not a
/// long-running session the user needs to recover.
class StopwatchCard extends StatefulWidget {
  const StopwatchCard({super.key});

  @override
  State<StopwatchCard> createState() => _StopwatchCardState();
}

class _StopwatchCardState extends State<StopwatchCard> {
  final Stopwatch _stopwatch = Stopwatch();
  Timer? _ticker;

  void _toggle() {
    setState(() {
      if (_stopwatch.isRunning) {
        _stopwatch.stop();
        _ticker?.cancel();
        _ticker = null;
      } else {
        _stopwatch.start();
        _ticker = Timer.periodic(const Duration(milliseconds: 50), (_) {
          if (mounted) setState(() {});
        });
      }
    });
  }

  void _reset() {
    setState(() {
      _stopwatch.stop();
      _stopwatch.reset();
      _ticker?.cancel();
      _ticker = null;
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  String _format(Duration d) {
    final mm = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final ss = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final cs = ((d.inMilliseconds.remainder(1000)) ~/ 10)
        .toString()
        .padLeft(2, '0');
    if (d.inHours > 0) {
      final hh = d.inHours.toString().padLeft(2, '0');
      return '$hh:$mm:$ss';
    }
    return '$mm:$ss.$cs';
  }

  @override
  Widget build(BuildContext context) {
    final running = _stopwatch.isRunning;
    final elapsed = _stopwatch.elapsed;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: running
              ? AppColors.greenSoft.withOpacity(0.45)
              : Colors.white.withOpacity(0.04),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (running ? AppColors.greenSoft : AppColors.textSecondary)
                  .withOpacity(0.14),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.timer_outlined,
              size: 20,
              color: running ? AppColors.greenSoft : AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _format(elapsed),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    fontFeatures: [FontFeature.tabularFigures()],
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  running ? 'Running' : 'Stopwatch',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          _CircleButton(
            icon: running ? Icons.pause_rounded : Icons.play_arrow_rounded,
            color: AppColors.greenSoft,
            onTap: _toggle,
          ),
          const SizedBox(width: 8),
          _CircleButton(
            icon: Icons.refresh_rounded,
            color: AppColors.live,
            onTap: _reset,
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withOpacity(0.14),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.35)),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
      ),
    );
  }
}
