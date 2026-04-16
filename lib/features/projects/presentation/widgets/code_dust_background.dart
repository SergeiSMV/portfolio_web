import 'package:flutter/material.dart';

/// Статичный фон для ProjectDetail: мягкое градиентное свечение из 3 цветов.
class CodeDustBackground extends StatelessWidget {
  const CodeDustBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final base = isDark ? const Color(0xFF090D15) : const Color(0xFFF5F8FF);
    final cyan = isDark ? const Color(0xFF7DF9FF) : const Color(0xFF2AA8FF);
    final violet = isDark ? const Color(0xFFB794FF) : const Color(0xFF7C5CFF);
    final mint = isDark ? const Color(0xFF39FFB6) : const Color(0xFF00C9A7);

    return Stack(
      fit: StackFit.expand,
      children: [
        ColoredBox(color: base),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(-0.15, -0.95),
              radius: 0.78,
              colors: [
                cyan.withValues(alpha: isDark ? 0.16 : 0.10),
                cyan.withValues(alpha: 0.0),
              ],
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0.62, -0.55),
              radius: 0.72,
              colors: [
                violet.withValues(alpha: isDark ? 0.13 : 0.09),
                violet.withValues(alpha: 0.0),
              ],
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0.35, 1.05),
              radius: 0.95,
              colors: [
                mint.withValues(alpha: isDark ? 0.12 : 0.08),
                mint.withValues(alpha: 0.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
