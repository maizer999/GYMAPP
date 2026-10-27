import 'dart:math' as math;

import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.onFinish});

  final VoidCallback onFinish;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with TickerProviderStateMixin {
  late final AnimationController _intro;
  late final AnimationController _loop;
  late final AnimationController _outro;

  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<double> _glow;

  @override
  void initState() {
    super.initState();

    _intro = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _loop = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
    _outro = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    );

    _fade = CurvedAnimation(parent: _intro, curve: Curves.easeOut);
    _scale = Tween<double>(begin: 1.06, end: 1.0)
        .animate(CurvedAnimation(parent: _intro, curve: Curves.easeOutCubic));
    _glow = CurvedAnimation(parent: _loop, curve: Curves.easeInOut);

    _intro.forward();

    Future<void>.delayed(const Duration(milliseconds: 2600), () async {
      if (!mounted) return;
      await _outro.forward();
      if (!mounted) return;
      widget.onFinish();
    });
  }

  @override
  void dispose() {
    _intro.dispose();
    _loop.dispose();
    _outro.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A1030),
      body: AnimatedBuilder(
        animation: Listenable.merge([_intro, _loop, _outro]),
        builder: (context, _) {
          final outroT = _outro.value;
          return Opacity(
            opacity: 1 - outroT,
            child: Stack(
              fit: StackFit.expand,
              children: [
                _PulseGlow(t: _glow.value),
                Center(
                  child: FadeTransition(
                    opacity: _fade,
                    child: ScaleTransition(
                      scale: _scale,
                      child: Image.asset(
                        'assets/splash/splash.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 48,
                  child: Opacity(
                    opacity: _fade.value,
                    child: _ThreeDotLoader(t: _loop.value),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _PulseGlow extends StatelessWidget {
  const _PulseGlow({required this.t});

  final double t;

  @override
  Widget build(BuildContext context) {
    final pulse = (math.sin(t * math.pi * 2) + 1) / 2;
    return IgnorePointer(
      child: CustomPaint(
        painter: _GlowPainter(pulse: pulse),
      ),
    );
  }
}

class _GlowPainter extends CustomPainter {
  _GlowPainter({required this.pulse});

  final double pulse;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.38);
    final radius = size.shortestSide * (0.45 + pulse * 0.08);
    final shader = RadialGradient(
      colors: [
        const Color(0xFF22D3EE).withValues(alpha: 0.28 + pulse * 0.12),
        const Color(0xFF8B5CF6).withValues(alpha: 0.10),
        Colors.transparent,
      ],
      stops: const [0.0, 0.55, 1.0],
    ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(covariant _GlowPainter oldDelegate) =>
      oldDelegate.pulse != pulse;
}

class _ThreeDotLoader extends StatelessWidget {
  const _ThreeDotLoader({required this.t});

  final double t;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        final phase = (t + i * 0.22) % 1.0;
        final a = (math.sin(phase * math.pi * 2) + 1) / 2;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF22D3EE).withValues(alpha: 0.35 + a * 0.65),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF22D3EE).withValues(alpha: a * 0.6),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
