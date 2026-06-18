import 'dart:math';
import 'package:flutter/material.dart';

/// CustomPainter that draws comic-style chaos doodles across the background.
/// Creates a hand-drawn, energetic feel with scattered shapes, hatching,
/// and comic symbols (stars, spirals, exclamation marks, zigzags).
class ChaosBackgroundPainter extends CustomPainter {
  final Color lineColor;
  final double opacity;

  ChaosBackgroundPainter({
    this.lineColor = Colors.black,
    this.opacity = 0.06,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor.withValues(alpha: opacity)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..color = lineColor.withValues(alpha: opacity * 0.5)
      ..style = PaintingStyle.fill;

    final random = Random(42); // Fixed seed for consistent pattern

    // === Diagonal hatching lines (subtle background texture) ===
    _drawHatchingLines(canvas, size, paint, random);

    // === Scattered comic doodles ===
    _drawScatteredDoodles(canvas, size, paint, fillPaint, random);
  }

  void _drawHatchingLines(Canvas canvas, Size size, Paint paint, Random random) {
    final hatchPaint = Paint()
      ..color = lineColor.withValues(alpha: opacity * 0.4)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    // Diagonal lines from top-left to bottom-right
    for (double i = -size.height; i < size.width + size.height; i += 28) {
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        hatchPaint,
      );
    }
  }

  void _drawScatteredDoodles(
      Canvas canvas, Size size, Paint paint, Paint fillPaint, Random random) {
    // Generate deterministic positions for doodles
    final doodleCount = 18;

    for (int i = 0; i < doodleCount; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final type = random.nextInt(7);
      final doodleSize = 8.0 + random.nextDouble() * 16;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(random.nextDouble() * pi * 2);

      switch (type) {
        case 0:
          _drawStar(canvas, doodleSize, paint);
          break;
        case 1:
          _drawSpiral(canvas, doodleSize, paint);
          break;
        case 2:
          _drawExclamation(canvas, doodleSize, paint);
          break;
        case 3:
          _drawZigzag(canvas, doodleSize, paint);
          break;
        case 4:
          _drawSmallCircle(canvas, doodleSize, paint);
          break;
        case 5:
          _drawCross(canvas, doodleSize, paint);
          break;
        case 6:
          _drawQuestionMark(canvas, doodleSize, paint);
          break;
      }

      canvas.restore();
    }
  }

  void _drawStar(Canvas canvas, double size, Paint paint) {
    final path = Path();
    final spikes = 4;
    final outerRadius = size;
    final innerRadius = size * 0.4;

    for (int i = 0; i < spikes * 2; i++) {
      final angle = (i * pi / spikes) - pi / 2;
      final radius = i.isEven ? outerRadius : innerRadius;
      final x = cos(angle) * radius;
      final y = sin(angle) * radius;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawSpiral(Canvas canvas, double size, Paint paint) {
    final path = Path();
    for (double t = 0; t < 3 * pi; t += 0.2) {
      final r = (t / (3 * pi)) * size;
      final x = cos(t) * r;
      final y = sin(t) * r;
      if (t == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  void _drawExclamation(Canvas canvas, double size, Paint paint) {
    // Exclamation bar
    canvas.drawLine(Offset(0, -size), Offset(0, size * 0.3), paint);
    // Dot
    canvas.drawCircle(Offset(0, size * 0.7), size * 0.15, paint);
  }

  void _drawZigzag(Canvas canvas, double size, Paint paint) {
    final path = Path();
    path.moveTo(-size, 0);
    for (int i = 0; i < 4; i++) {
      final x = -size + (i + 0.5) * (size * 2 / 4);
      final y = (i.isEven ? -1 : 1) * size * 0.4;
      path.lineTo(x, y);
    }
    path.lineTo(size, 0);
    canvas.drawPath(path, paint);
  }

  void _drawSmallCircle(Canvas canvas, double size, Paint paint) {
    canvas.drawCircle(Offset.zero, size * 0.5, paint);
  }

  void _drawCross(Canvas canvas, double size, Paint paint) {
    canvas.drawLine(Offset(-size * 0.5, -size * 0.5),
        Offset(size * 0.5, size * 0.5), paint);
    canvas.drawLine(Offset(size * 0.5, -size * 0.5),
        Offset(-size * 0.5, size * 0.5), paint);
  }

  void _drawQuestionMark(Canvas canvas, double size, Paint paint) {
    final path = Path();
    // Arc of question mark
    path.addArc(
        Rect.fromCircle(center: Offset(0, -size * 0.3), radius: size * 0.4),
        pi,
        -pi * 1.3);
    // Stem
    path.lineTo(0, size * 0.2);
    canvas.drawPath(path, paint);
    // Dot
    canvas.drawCircle(Offset(0, size * 0.5), size * 0.1, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
