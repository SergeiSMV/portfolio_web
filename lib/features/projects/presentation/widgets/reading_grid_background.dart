import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Тонкий анимированный "reading grid" фон для страниц с длинным контентом.
///
/// Сетка движется очень медленно и имеет низкую контрастность, чтобы не
/// мешать чтению текста.
class ReadingGridBackground extends StatefulWidget {
  const ReadingGridBackground({super.key});

  @override
  State<ReadingGridBackground> createState() => _ReadingGridBackgroundState();
}

class _ReadingGridBackgroundState extends State<ReadingGridBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _tick;

  @override
  void initState() {
    super.initState();
    _tick = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _tick.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_tick.isAnimating) _tick.repeat();

    return AnimatedBuilder(
      animation: _tick,
      builder: (context, _) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return CustomPaint(
              size: Size(constraints.maxWidth, constraints.maxHeight),
              painter: _ReadingGridPainter(
                brightness: Theme.of(context).brightness,
                phase: _tick.value,
              ),
            );
          },
        );
      },
    );
  }
}

class _ReadingGridPainter extends CustomPainter {
  _ReadingGridPainter({
    required this.brightness,
    required this.phase,
  });

  final Brightness brightness;
  final double phase;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final isDark = brightness == Brightness.dark;
    final drift = phase * 240.0;

    _drawBackground(canvas, size, isDark);
    _drawGrid(canvas, size, drift, isDark);
  }

  void _drawBackground(Canvas canvas, Size size, bool isDark) {
    final bg = Paint()
      ..shader = RadialGradient(
        center: isDark ? const Alignment(0.0, -0.95) : const Alignment(0.1, -1),
        radius: 1.25,
        colors: isDark
            ? const [Color(0xFF0B101A), Color(0xFF090D15), Color(0xFF080B12)]
            : const [Color(0xFFF7F9FF), Color(0xFFF1F5FF), Color(0xFFF8FAFF)],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    // Мягкий акцент сверху, чтобы фон не выглядел "плоским".
    final glow = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0, -1.05),
        radius: 0.9,
        colors: isDark
            ? [
                const Color(0xFF7DF9FF).withValues(alpha: 0.16),
                const Color(0xFF7DF9FF).withValues(alpha: 0.0),
              ]
            : [
                const Color(0xFF2AA8FF).withValues(alpha: 0.11),
                const Color(0xFF2AA8FF).withValues(alpha: 0.0),
              ],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, glow);
  }

  void _drawGrid(Canvas canvas, Size size, double drift, bool isDark) {
    final majorColor = isDark
        ? const Color(0xFF7DF9FF).withValues(alpha: 0.30)
        : const Color(0xFF2AA8FF).withValues(alpha: 0.22);
    final minorColor = isDark
        ? const Color(0xFFB794FF).withValues(alpha: 0.16)
        : const Color(0xFF7C5CFF).withValues(alpha: 0.11);

    final majorPaint = Paint()
      ..color = majorColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;
    final minorPaint = Paint()
      ..color = minorColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.95;

    const majorStep = 96.0;
    const minorStep = 32.0;
    final angle = -math.pi / 30;
    final shiftX = math.cos(angle) * drift;
    final shiftY = math.sin(angle) * drift;

    canvas.save();
    canvas.translate(shiftX, shiftY);

    _drawLines(canvas, size, minorStep, minorPaint);
    _drawLines(canvas, size, majorStep, majorPaint);
    _drawAccentSweep(canvas, size, drift, isDark);

    canvas.restore();
  }

  void _drawLines(Canvas canvas, Size size, double step, Paint paint) {
    for (double x = -size.height; x <= size.width + size.height; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x - size.height * 0.25, size.height), paint);
    }
    for (double y = -size.width * 0.2; y <= size.height + size.width * 0.2; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y + size.width * 0.12), paint);
    }
  }

  void _drawAccentSweep(Canvas canvas, Size size, double drift, bool isDark) {
    final x = (drift * 0.45) % (size.width + 220) - 110;
    final sweep = Paint()
      ..color = (isDark ? const Color(0xFF39FFB6) : const Color(0xFF00C9A7))
          .withValues(alpha: isDark ? 0.16 : 0.10)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(x, -20), Offset(x - 140, size.height + 20), sweep);
  }

  @override
  bool shouldRepaint(covariant _ReadingGridPainter oldDelegate) {
    return oldDelegate.brightness != brightness ||
        oldDelegate.phase != phase;
  }
}
