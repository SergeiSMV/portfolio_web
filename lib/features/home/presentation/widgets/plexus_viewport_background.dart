import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Фон «plexus»: узлы (частицы) + линии между близкими парами.
///
/// Рисуется [CustomPainter] на весь viewport. В [HomePage] лежит в [Stack]
/// под [SingleChildScrollView] с [IgnorePointer], чтобы не перехватывать
/// жесты. Анимация идёт за счёт [AnimationController]: он только даёт
/// тики перерисовки; реальное время берётся в [paint] через `DateTime.now()`
/// (иначе при тике без rebuild виджет «замораживал» бы время).
class PlexusViewportBackground extends StatefulWidget {
  const PlexusViewportBackground({super.key});

  @override
  State<PlexusViewportBackground> createState() =>
      _PlexusViewportBackgroundState();
}

class _PlexusViewportBackgroundState extends State<PlexusViewportBackground>
    with SingleTickerProviderStateMixin {
  /// Тикер перерисовки: значение контроллера не используется, важны только
  /// уведомления слушателям → [CustomPainter] с [repaint: _tick] снова
  /// вызывает [paint].
  late final AnimationController _tick;

  /// Список частиц фиксируется один раз в [initState] (стабильная сеть).
  late final List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    // Фиксированный seed → одна и та же «карта» частиц после hot restart.
    final rnd = math.Random(42);
    // Первый аргумент List.generate — количество частиц (нагрузка ~ n² на рёбра).
    _particles = List.generate(
      130,
      (_) => _Particle(
        // Нормализованные координаты центра траектории [0..1].
        baseX: rnd.nextDouble(),
        baseY: rnd.nextDouble(),
        // Сдвиг фазы синусов — разные частицы двигаются не в унисон.
        phase: rnd.nextDouble() * 2 * math.pi,
        // «Скорость» колебаний по X/Y: чем больше, тем быстрее дрейф при том же t.
        wx: 0.35 + rnd.nextDouble() * 0.55,
        wy: 0.30 + rnd.nextDouble() * 0.55,
        // Амплитуда отклонения от base в долях экрана [0..1].
        amp: 0.07 + rnd.nextDouble() * 0.11,
      ),
    );
    _tick = AnimationController(
      vsync: this,
      // Длительность одного цикла значения не важна: стоит repeat().
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _tick.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Системная настройка доступности: без анимации — останавливаем тикер.
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    if (reduceMotion) {
      if (_tick.isAnimating) _tick.stop();
    } else {
      if (!_tick.isAnimating) _tick.repeat();
    }
    // От темы зависят цвета фона, линий и узлов.
    final brightness = Theme.of(context).brightness;

    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomPaint(
          // Явный размер: иначе в Stack без дочернего виджета могли бы быть нули.
          size: Size(constraints.maxWidth, constraints.maxHeight),
          painter: _PlexusPainter(
            particles: _particles,
            brightness: brightness,
            animate: !reduceMotion,
            // Пока не reduce motion — каждый тик _tick перерисовывает canvas.
            repaint: reduceMotion ? null : _tick,
          ),
        );
      },
    );
  }
}

/// Одна частица: параметрическое колебание вокруг (baseX, baseY).
class _Particle {
  const _Particle({
    required this.baseX,
    required this.baseY,
    required this.phase,
    required this.wx,
    required this.wy,
    required this.amp,
  });

  /// Центр «орбиты» по горизонтали, доля ширины [0..1].
  final double baseX;

  /// Центр «орбиты» по вертикали, доля высоты [0..1].
  final double baseY;

  /// Начальная фаза волны (радианы).
  final double phase;

  /// Частота по X: множитель у аргумента `t * wx` в sin.
  final double wx;

  /// Частота по Y: множитель у `t * wy` в cos.
  final double wy;

  /// Насколько далеко частица отходит от base (в тех же долях [0..1]).
  final double amp;

  /// Позиция в пикселях при «глобальном» времени движения [t] и размере [size].
  /// [t] сюда обычно передают уже замедленное/масштабированное (см. [tMotion] в painter).
  Offset at(double t, Size size) {
    // Две синусоиды по X и две по Y — траектория чуть богаче, чем простой эллипс.
    final nx =
        (baseX +
                amp * math.sin(t * wx + phase) +
                amp * 0.35 * math.sin(t * wx * 0.37 + phase * 1.7))
            .clamp(0.02, 0.98);
    final ny =
        (baseY +
                amp * math.cos(t * wy + phase * 1.1) +
                amp * 0.3 * math.cos(t * wy * 0.41 + phase))
            .clamp(0.02, 0.98);
    return Offset(nx * size.width, ny * size.height);
  }
}

class _PlexusPainter extends CustomPainter {
  _PlexusPainter({
    required this.particles,
    required this.brightness,
    required this.animate,
    super.repaint,
  });

  final List<_Particle> particles;
  final Brightness brightness;

  /// Если false — один статичный кадр (reduce motion), [now] = 0.
  final bool animate;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    // Секунды с эпохи; при animate == false зафиксируем кадр в t = 0.
    final now = animate ? DateTime.now().millisecondsSinceEpoch / 1000.0 : 0.0;

    /// Множитель к [now]: меньше → медленнее дрейф частиц (см. [_Particle.at]).
    final tMotion = now * 0.1;

    final isDark = brightness == Brightness.dark;

    // Слой 1: градиентный фон под сетью (не зависит от частиц).
    if (isDark) {
      final bg = Paint()
        ..shader = RadialGradient(
          center: const Alignment(0, -0.85),
          radius: 1.15,
          // Прозрачность цветов градиента — насыщенность «пятна» сверху.
          colors: [
            const Color(0xFF2A0F35).withValues(alpha: 0.95),
            const Color(0xFF12081A).withValues(alpha: 0.92),
            const Color(0xFF0E0F13),
          ],
          stops: const [0.0, 0.42, 1.0],
        ).createShader(Offset.zero & size);
      canvas.drawRect(Offset.zero & size, bg);
    } else {
      final bg = Paint()
        ..shader = RadialGradient(
          center: const Alignment(0.15, -0.9),
          radius: 1.2,
          colors: [
            const Color(0xFFE8EEFF).withValues(alpha: 0.55),
            const Color(0xFFF4F6FB),
            const Color(0xFFF7F7F8),
          ],
          stops: const [0.0, 0.38, 1.0],
        ).createShader(Offset.zero & size);
      canvas.drawRect(Offset.zero & size, bg);
    }

    // Слой 2: текущие позиции всех частиц (зависят от [tMotion] и [size]).
    final positions = particles.map((p) => p.at(tMotion, size)).toList();

    // Макс. длина ребра в px: если расстояние между парой меньше — рисуем линию.
    // Зависит от [size.shortestSide] — на мобиле чуть меньше порог, на десктопе больше.
    final connect = (132 * (size.shortestSide / 720)).clamp(80.0, 158.0);

    // Базовый цвет узла и линии (альфа для линий задаётся отдельно ниже).
    final nodeColor = isDark
        ? const Color(0xFFFFE8F4)
        : const Color(0xFF5B8DEF);
    final lineBase = isDark ? const Color(0xFFFFC8EC) : const Color(0xFF5B8DEF);

    final linePaint = Paint()
      ..strokeWidth = 1.1
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // O(n²): каждая пара; при росте числа частиц сильно растёт нагрузка.
    for (var i = 0; i < positions.length; i++) {
      for (var j = i + 1; j < positions.length; j++) {
        final d = (positions[i] - positions[j]).distance;
        if (d >= connect) continue;
        // edge = 1 у самых близких соседей, → 0 у порога [connect].
        final edge = 1.0 - (d / connect);
        // Чуть выпрямляем кривую «яркость vs расстояние» (степень < квадрата).
        final shaped = math.pow(edge, 1.08).toDouble();
        // Итоговая альфа линии: множители 0.48 / 0.26 — «громкость» сети в теме;
        // clamp верх — чтобы дальние рёбра не перебивали контент.
        final a = (shaped * (isDark ? 0.48 : 0.26)).clamp(0.0, 0.62);
        linePaint.color = lineBase.withValues(alpha: a);
        canvas.drawLine(positions[i], positions[j], linePaint);
      }
    }

    // Слой 3: узлы поверх линий (мягкое свечение + ядро).
    final nodeR = isDark ? 2.1 : 1.8;
    final glow = Paint()..style = PaintingStyle.fill;
    for (final o in positions) {
      // Внешний полупрозрачный диск — «ореол».
      glow.color = nodeColor.withValues(alpha: isDark ? 0.14 : 0.08);
      canvas.drawCircle(o, nodeR * 2.4, glow);
      // Яркое ядро точки.
      glow.color = nodeColor.withValues(alpha: isDark ? 0.55 : 0.35);
      canvas.drawCircle(o, nodeR, glow);
    }
  }

  @override
  bool shouldRepaint(covariant _PlexusPainter oldDelegate) {
    // При смене темы / списка / режима анимации пересоздаём картину.
    // Покадровую смену времени обрабатывает [repaint], сюда время не передаём.
    return oldDelegate.brightness != brightness ||
        oldDelegate.animate != animate ||
        oldDelegate.particles != particles;
  }
}
