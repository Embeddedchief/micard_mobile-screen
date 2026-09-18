import 'dart:math' as math;

import 'package:flutter/material.dart';

class MyBackground extends StatefulWidget {
  const MyBackground({super.key});

  @override
  State<MyBackground> createState() => _MobileDeveloperBackgroundState();
}

class _MobileDeveloperBackgroundState extends State<MyBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return CustomPaint(
              painter: _DeveloperBackgroundPainter(progress: _controller.value),
              size: Size.infinite,
            );
          },
        ),
      ),
    );
  }
}

class _DeveloperBackgroundPainter extends CustomPainter {
  final double progress;

  _DeveloperBackgroundPainter({required this.progress});

  static const Color accent = Color(0xFFF0441A);
  static const Color white = Color(0xFFF7F7F7);
  static const Color muted = Color(0xFF8B8B8B);

  double _ease(double t) {
    return Curves.easeInOutCubic.transform(t.clamp(0.0, 1.0));
  }

  double _phase(double start, double end) {
    double t = ((progress - start) / (end - start)) % 1.0;
    if (t < 0) t += 1.0;
    return _ease(t);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Base.
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.black);

    _drawAmbientGrid(canvas, size);
    _drawConnectionLines(canvas, size);

    // Main product phone.
    _drawPhone(canvas, size, opacity: 0.94);

    _drawCard(
      canvas,
      size,
      Offset(w * 0.06, h * 0.13),
      width: w * 0.29,
      title: 'FLUTTER',
      subtitle: 'CROSS-PLATFORM',
      icon: 'F',
      phase: 0.06,
    );

    _drawCard(
      canvas,
      size,
      Offset(w * 0.67, h * 0.18),
      width: w * 0.27,
      title: 'API',
      subtitle: 'CONNECTED',
      icon: '↔',
      phase: 0.19,
    );

    _drawMetricCard(
      canvas,
      size,
      Offset(w * 0.08, h * 0.67),
      width: w * 0.31,
      phase: 0.35,
    );

    _drawStatusCard(
      canvas,
      size,
      Offset(w * 0.67, h * 0.68),
      width: w * 0.27,
      phase: 0.50,
    );

    _drawBottomWords(canvas, size);
  }

  void _drawAmbientGrid(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF171717)
      ..strokeWidth = 0.6;

    const gap = 28.0;

    for (double x = 0; x <= size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y <= size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Very subtle moving scan line.
    final scanX = size.width * progress;
    final scanPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.transparent,
          accent.withOpacity(0.12),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(scanX - 70, 0, 140, size.height));

    canvas.drawRect(Rect.fromLTWH(scanX - 70, 0, 140, size.height), scanPaint);
  }

  void _drawConnectionLines(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = accent.withOpacity(0.22)
      ..strokeWidth = 1.1
      ..style = PaintingStyle.stroke;

    final p1 = Offset(size.width * 0.24, size.height * 0.28);
    final p2 = Offset(size.width * 0.42, size.height * 0.28);
    final p3 = Offset(size.width * 0.74, size.height * 0.32);
    final p4 = Offset(size.width * 0.67, size.height * 0.74);

    canvas.drawLine(p1, p2, paint);
    canvas.drawLine(p2, p3, paint);
    canvas.drawLine(p3, p4, paint);

    final dotT = (progress * 2.0) % 1.0;
    final dotX = p2.dx + (p3.dx - p2.dx) * dotT;
    final dotY = p2.dy + (p3.dy - p2.dy) * dotT;

    canvas.drawCircle(Offset(dotX, dotY), 2.6, Paint()..color = accent);
  }

  void _drawPhone(Canvas canvas, Size size, {required double opacity}) {
    final w = size.width;
    final h = size.height;

    final entrance = _phase(0.0, 0.20);
    final float = math.sin(progress * math.pi * 2) * 2.0;

    // Keep the phone slightly to the right so the profile image can overlap
    // without hiding the whole composition.
    final phoneW = w * 0.43;
    final phoneH = h * 0.88;

    final left = w * 0.30 + (1.0 - entrance) * w * 0.12;
    final top = h * 0.07 + float;

    final phoneRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(left, top, phoneW, phoneH),
      const Radius.circular(28),
    );

    // Soft shadow/glow.
    canvas.drawRRect(
      phoneRect.shift(const Offset(0, 5)),
      Paint()
        ..color = Colors.white.withOpacity(0.05)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16),
    );

    canvas.drawRRect(phoneRect, Paint()..color = const Color(0xFF0B0B0B));

    canvas.drawRRect(
      phoneRect,
      Paint()
        ..color = const Color(0xFF3A3A3A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );

    final screen = RRect.fromRectAndRadius(
      Rect.fromLTWH(left + 7, top + 7, phoneW - 14, phoneH - 14),
      const Radius.circular(23),
    );

    canvas.drawRRect(screen, Paint()..color = const Color(0xFF101010));

    // Dynamic island.
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left + phoneW * 0.31, top + 14, phoneW * 0.38, 17),
        const Radius.circular(20),
      ),
      Paint()..color = Colors.black,
    );

    // Header.
    _text(
      canvas,
      '09:41',
      Offset(left + 19, top + 18),
      9,
      white.withOpacity(0.8),
      weight: FontWeight.w600,
    );

    _text(
      canvas,
      'PRODUCT',
      Offset(left + 18, top + phoneH * 0.13),
      7.5,
      muted,
      weight: FontWeight.w700,
      letterSpacing: 1.5,
    );

    _text(
      canvas,
      'Build something',
      Offset(left + 18, top + phoneH * 0.17),
      14,
      white,
      weight: FontWeight.w700,
    );

    _text(
      canvas,
      'people love to use.',
      Offset(left + 18, top + phoneH * 0.21),
      14,
      white,
      weight: FontWeight.w700,
    );

    // Hero metric.
    final metricRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(left + 16, top + phoneH * 0.29, phoneW - 32, phoneH * 0.20),
      const Radius.circular(15),
    );

    canvas.drawRRect(metricRect, Paint()..color = const Color(0xFF181818));

    _text(
      canvas,
      'APP PERFORMANCE',
      Offset(left + 28, top + phoneH * 0.32),
      6.5,
      muted,
      weight: FontWeight.w700,
      letterSpacing: 1.1,
    );

    _text(
      canvas,
      '98.6',
      Offset(left + 28, top + phoneH * 0.355),
      22,
      white,
      weight: FontWeight.w700,
    );

    _text(
      canvas,
      '%',
      Offset(left + 74, top + phoneH * 0.375),
      8,
      accent,
      weight: FontWeight.w700,
    );

    // Animated graph.
    final graph = Path();
    for (int i = 0; i <= 22; i++) {
      final x = left + 28 + i * (phoneW - 60) / 22;
      final wave = math.sin((i / 3.3) + progress * math.pi * 2) * 3.5;
      final y = top + phoneH * 0.445 - wave - i * 0.22;

      if (i == 0) {
        graph.moveTo(x, y);
      } else {
        graph.lineTo(x, y);
      }
    }

    canvas.drawPath(
      graph,
      Paint()
        ..color = accent
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );

    // App modules.
    final modules = [
      ['UI / UX', 'INTUITIVE'],
      ['API', 'CONNECTED'],
      ['STATE', 'MANAGED'],
    ];

    for (int i = 0; i < modules.length; i++) {
      final y = top + phoneH * 0.56 + i * 45;

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(left + 16, y, phoneW - 32, 34),
          const Radius.circular(10),
        ),
        Paint()..color = const Color(0xFF171717),
      );

      canvas.drawCircle(
        Offset(left + 29, y + 17),
        4,
        Paint()..color = i == 1 ? accent : const Color(0xFF5E5E5E),
      );

      _text(
        canvas,
        modules[i][0],
        Offset(left + 42, y + 8),
        7,
        white,
        weight: FontWeight.w600,
      );

      _text(
        canvas,
        modules[i][1],
        Offset(left + phoneW - 82, y + 8),
        6,
        muted,
        weight: FontWeight.w600,
      );
    }

    // Tiny developer signature.
    _text(
      canvas,
      'MOBILE SYSTEM',
      Offset(left + 18, top + phoneH - 24),
      5.5,
      accent,
      weight: FontWeight.w700,
      letterSpacing: 1.4,
    );
  }

  void _drawCard(
    Canvas canvas,
    Size size,
    Offset position, {
    required double width,
    required String title,
    required String subtitle,
    required String icon,
    required double phase,
  }) {
    final h = 58.0;
    final local = ((progress + phase) % 1.0);
    final opacity = (math.sin(local * math.pi)).clamp(0.0, 1.0) * 0.65 + 0.25;
    final drift = math.sin((progress + phase) * math.pi * 2) * 4;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(position.dx, position.dy + drift, width, h),
      const Radius.circular(13),
    );

    canvas.drawRRect(
      rect,
      Paint()..color = const Color(0xFF151515).withOpacity(opacity),
    );

    canvas.drawRRect(
      rect,
      Paint()
        ..color = Colors.white.withOpacity(0.09)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.7,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(position.dx + 10, position.dy + 13 + drift, 30, 30),
        const Radius.circular(8),
      ),
      Paint()..color = accent.withOpacity(0.12),
    );

    _text(
      canvas,
      icon,
      Offset(position.dx + 19, position.dy + 18 + drift),
      12,
      accent,
      weight: FontWeight.w800,
    );

    _text(
      canvas,
      title,
      Offset(position.dx + 48, position.dy + 13 + drift),
      8,
      white.withOpacity((opacity + 0.2).clamp(0.0, 1.0)),
      weight: FontWeight.w700,
      letterSpacing: 0.8,
    );

    _text(
      canvas,
      subtitle,
      Offset(position.dx + 48, position.dy + 29 + drift),
      5.5,
      muted.withOpacity((opacity + 0.15).clamp(0.0, 1.0)),
      weight: FontWeight.w600,
      letterSpacing: 0.7,
    );
  }

  void _drawMetricCard(
    Canvas canvas,
    Size size,
    Offset position, {
    required double width,
    required double phase,
  }) {
    final h = 67.0;
    final drift = math.sin((progress + phase) * math.pi * 2) * 3;
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(position.dx, position.dy + drift, width, h),
      const Radius.circular(13),
    );

    canvas.drawRRect(
      rect,
      Paint()
        ..color = const Color(0xFF141414).withOpacity(0.88).clamp(0.0, 1.0),
    );

    _text(
      canvas,
      'STATE MANAGEMENT',
      Offset(position.dx + 12, position.dy + 12 + drift),
      6,
      muted,
      weight: FontWeight.w700,
      letterSpacing: 1,
    );

    _text(
      canvas,
      'Provider',
      Offset(position.dx + 12, position.dy + 29 + drift),
      9,
      white,
      weight: FontWeight.w700,
    );

    // Progress bar.
    final bar = Rect.fromLTWH(
      position.dx + 12,
      position.dy + 48 + drift,
      width - 24,
      4,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(bar, const Radius.circular(4)),
      Paint()..color = const Color(0xFF2A2A2A),
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          bar.left,
          bar.top,
          bar.width * (0.72 + 0.08 * math.sin(progress * math.pi * 2)),
          bar.height,
        ),
        const Radius.circular(4),
      ),
      Paint()..color = accent,
    );
  }

  void _drawStatusCard(
    Canvas canvas,
    Size size,
    Offset position, {
    required double width,
    required double phase,
  }) {
    final h = 67.0;
    final pulse = 0.5 + 0.5 * math.sin((progress + phase) * math.pi * 2);

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(position.dx, position.dy, width, h),
      const Radius.circular(13),
    );

    canvas.drawRRect(
      rect,
      Paint()..color = const Color(0xFF141414).withOpacity(0.88),
    );

    canvas.drawCircle(
      Offset(position.dx + 17, position.dy + 19),
      4 + pulse,
      Paint()..color = accent.withOpacity(0.45),
    );

    _text(
      canvas,
      'BACKEND',
      Offset(position.dx + 29, position.dy + 13),
      6,
      muted,
      weight: FontWeight.w700,
      letterSpacing: 1,
    );

    _text(
      canvas,
      'ONLINE',
      Offset(position.dx + 12, position.dy + 35),
      9,
      white,
      weight: FontWeight.w700,
    );

    _text(
      canvas,
      '142ms',
      Offset(position.dx + width - 47, position.dy + 36),
      6,
      accent,
      weight: FontWeight.w700,
    );

    _text(
      canvas,
      'SECURE  •  SYNCED  •  READY',
      Offset(position.dx + 12, position.dy + 52),
      4.7,
      muted,
      weight: FontWeight.w600,
      letterSpacing: 0.45,
    );
  }

  void _drawBottomWords(Canvas canvas, Size size) {
    final words = ['DART', 'FLUTTER', 'UI/UX', 'API', 'CLEAN CODE'];

    final spacing = size.width / (words.length + 1);

    for (int i = 0; i < words.length; i++) {
      final reveal = _phase(0.62 + i * 0.025, 0.82 + i * 0.025);
      _text(
        canvas,
        words[i],
        Offset(spacing * (i + 1) - (words[i].length * 1.9), size.height * 0.94),
        5.2,
        muted.withOpacity(0.35 + reveal * 0.35),
        weight: FontWeight.w700,
        letterSpacing: 0.7,
      );
    }
  }

  void _text(
    Canvas canvas,
    String text,
    Offset offset,
    double fontSize,
    Color color, {
    FontWeight weight = FontWeight.w400,
    double letterSpacing = 0,
  }) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: weight,
          letterSpacing: letterSpacing,
          fontFamily: 'Arial',
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    painter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant _DeveloperBackgroundPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
