import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/responsive/breakpoints.dart';

/// Анимированный фон из "лент света" для страницы проектов.
///
/// Ленты рисуются в 2 слоя:
/// - широкий blur-слой для неонового ореола;
/// - тонкий яркий слой для четкого "ядра" линии.
class AuroraBandsBackground extends StatefulWidget {
  const AuroraBandsBackground({super.key});

  @override
  State<AuroraBandsBackground> createState() => _AuroraBandsBackgroundState();
}

class _AuroraBandsBackgroundState extends State<AuroraBandsBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _tick;

  late bool _isMobile;

  @override
  void initState() {
    super.initState();
    _tick = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _tick.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isMobile = context.screenSize == ScreenSize.mobile;
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    if (reduceMotion) {
      if (_tick.isAnimating) _tick.stop();
    } else {
      if (!_tick.isAnimating) _tick.repeat();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: _AuroraBandsPainter(
            isMobile: _isMobile,
            brightness: Theme.of(context).brightness,
            animate: !reduceMotion,
            repaint: reduceMotion ? null : _tick,
          ),
        );
      },
    );
  }
}

class _AuroraBandsPainter extends CustomPainter {
  _AuroraBandsPainter({
    required this.brightness,
    required this.animate,
    required this.isMobile,
    super.repaint,
  });

  final Brightness brightness;
  final bool animate;
  final bool isMobile;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final isDark = brightness == Brightness.dark;
    final now = animate ? DateTime.now().millisecondsSinceEpoch / 1000.0 : 0.0;

    _drawBackground(canvas, size, isDark);
    _drawBands(canvas, size, now, isDark);
  }

  void _drawBackground(Canvas canvas, Size size, bool isDark) {
    final background = Paint()
      ..shader = RadialGradient(
        center: isDark ? const Alignment(-0.1, -0.9) : const Alignment(0.1, -1),
        radius: 1.25,
        colors: isDark
            ? const [Color(0xFF111022), Color(0xFF0D1018), Color(0xFF0A0E14)]
            : const [Color(0xFFF6F8FF), Color(0xFFEEF3FF), Color(0xFFF7FAFF)],
        stops: const [0.0, 0.42, 1.0],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, background);
  }

  void _drawBands(Canvas canvas, Size size, double now, bool isDark) {
    final palette = isDark
        ? const [Color(0xFF7DF9FF), Color(0xFFB794FF), Color(0xFF39FFB6)]
        : const [Color(0xFF2AA8FF), Color(0xFF7C5CFF), Color(0xFF00C9A7)];

    final t = now * 0.5;

    for (var i = 0; i < palette.length; i++) {
      final phase = i * 1.25;
      final centerY = size.height * (0.22 + i * 0.24);
      final waveAmp = size.height * (0.055 + i * 0.01);
      final sweep = size.width * 0.08;

      final path = Path()..moveTo(-size.width * 0.1, centerY);
      for (double x = -size.width * 0.1; x <= size.width * 1.1; x += 12) {
        final y =
            centerY +
            math.sin((x / size.width) * 2.6 + t * (1.4 + i * 0.28) + phase) *
                waveAmp +
            math.cos((x / size.width) * 1.2 - t * 0.65 + phase * 0.6) * sweep;
        path.lineTo(x, y);
      }

      final glowPaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = isDark ? 30 : 24
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 22)
        ..color = palette[i].withValues(alpha: isDark ? 0.5 : 0.12);
      canvas.drawPath(path, glowPaint);

      final corePaint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = isDark ? 4.0 : 2.4
        ..strokeCap = StrokeCap.round
        ..color = palette[i].withValues(
          alpha: isDark ? (isMobile ? 0.1 : 0.74) : 0.58,
        );
      canvas.drawPath(path, corePaint);
    }
  }

  @override
  bool shouldRepaint(covariant _AuroraBandsPainter oldDelegate) {
    return oldDelegate.brightness != brightness ||
        oldDelegate.animate != animate;
  }
}
