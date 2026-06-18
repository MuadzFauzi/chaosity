import 'dart:math';
import 'package:flutter/material.dart';

/// A comic-panel style mascot placeholder that looks way more interesting
/// than a plain icon in a box. Draws a layered composition with:
/// - A tilted comic panel frame
/// - A face character with expressive features
/// - Floating chaos symbols around it
/// - A speech bubble
class MascotPlaceholder extends StatelessWidget {
  const MascotPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      width: 220,
      child: CustomPaint(
        painter: _MascotPainter(),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Main face area
              Container(
                width: 130,
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 3.5),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Comic halftone dots in corner
                    Positioned(
                      right: 4,
                      bottom: 4,
                      child: CustomPaint(
                        size: const Size(40, 40),
                        painter: _HalftonePainter(),
                      ),
                    ),
                    // The face
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Eyes - wide and chaotic
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildEye(isLeft: true),
                            const SizedBox(width: 16),
                            _buildEye(isLeft: false),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Wobbly smile
                        CustomPaint(
                          size: const Size(50, 20),
                          painter: _WobblySmilePainter(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEye({required bool isLeft}) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2.5),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Transform.translate(
          offset: Offset(isLeft ? -2 : 2, -1),
          child: Container(
            width: 12,
            height: 12,
            decoration: const BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            // Tiny white reflection dot
            child: Align(
              alignment: const Alignment(0.4, -0.4),
              child: Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Draws floating chaos symbols around the mascot
class _MascotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.15)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final accentPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.05)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    // Light gray accent blob behind mascot
    canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.45), 80, accentPaint);

    // Floating symbols
    _drawFloatingSymbols(canvas, size, paint);
  }

  void _drawFloatingSymbols(Canvas canvas, Size size, Paint paint) {
    final symbolPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.12)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    // Top-left: small star
    _drawMiniStar(canvas, Offset(size.width * 0.1, size.height * 0.15), 10, symbolPaint);

    // Top-right: exclamation
    canvas.drawLine(
      Offset(size.width * 0.85, size.height * 0.1),
      Offset(size.width * 0.85, size.height * 0.2),
      symbolPaint,
    );
    canvas.drawCircle(
        Offset(size.width * 0.85, size.height * 0.24), 2, symbolPaint);

    // Bottom-left: small spiral
    _drawMiniSpiral(canvas, Offset(size.width * 0.12, size.height * 0.8), 8, symbolPaint);

    // Bottom-right: zigzag
    final zigPath = Path()
      ..moveTo(size.width * 0.82, size.height * 0.78)
      ..lineTo(size.width * 0.87, size.height * 0.82)
      ..lineTo(size.width * 0.82, size.height * 0.86)
      ..lineTo(size.width * 0.87, size.height * 0.90);
    canvas.drawPath(zigPath, symbolPaint);

    // Small crosses
    _drawMiniCross(canvas, Offset(size.width * 0.2, size.height * 0.42), 6, symbolPaint);
    _drawMiniCross(canvas, Offset(size.width * 0.82, size.height * 0.48), 5, symbolPaint);
  }

  void _drawMiniStar(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    for (int i = 0; i < 8; i++) {
      final angle = (i * pi / 4) - pi / 2;
      final radius = i.isEven ? size : size * 0.4;
      final x = center.dx + cos(angle) * radius;
      final y = center.dy + sin(angle) * radius;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawMiniSpiral(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    for (double t = 0; t < 2.5 * pi; t += 0.3) {
      final r = (t / (2.5 * pi)) * size;
      final x = center.dx + cos(t) * r;
      final y = center.dy + sin(t) * r;
      if (t == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, paint);
  }

  void _drawMiniCross(Canvas canvas, Offset center, double size, Paint paint) {
    canvas.drawLine(
        Offset(center.dx - size, center.dy - size),
        Offset(center.dx + size, center.dy + size),
        paint);
    canvas.drawLine(
        Offset(center.dx + size, center.dy - size),
        Offset(center.dx - size, center.dy + size),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Draws comic-style halftone dots in a triangular pattern
class _HalftonePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    for (double y = 0; y < size.height; y += 6) {
      for (double x = 0; x < size.width; x += 6) {
        // Only draw in lower-right triangle
        if (x + y > size.width * 0.5) {
          final distFromCorner = (size.width - x) + (size.height - y);
          final dotSize = 1.0 + (1.0 - distFromCorner / (size.width + size.height)) * 1.5;
          canvas.drawCircle(Offset(x, y), dotSize.clamp(0.5, 2.5), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Draws a wobbly smile line
class _WobblySmilePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width * 0.15, size.height * 0.3);
    path.cubicTo(
      size.width * 0.25, size.height * 0.9,
      size.width * 0.75, size.height * 0.9,
      size.width * 0.85, size.height * 0.3,
    );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
