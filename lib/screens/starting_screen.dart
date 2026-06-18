import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/chaos_background_painter.dart';
import '../widgets/mascot_placeholder.dart';
import 'chapter_selector_screen.dart';

class StartingScreen extends StatelessWidget {
  const StartingScreen({super.key});

  // === Design Tokens (hitam-putih) ===
  static const Color _bgColor = Color(0xFFF0F0F0); // Latar abu-abu kertas bersih
  static const Color _inkBlack = Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: _bgColor,
      body: Stack(
        children: [
          // === LAYER 1: Chaos background doodles ===
          Positioned.fill(
            child: CustomPaint(
              painter: ChaosBackgroundPainter(
                lineColor: _inkBlack,
                opacity: 0.06,
              ),
            ),
          ),

          // === LAYER 2: Decorative corner panels ===
          _buildCornerAccents(screenWidth, screenHeight),

          // === LAYER 3: Main content ===
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight * 0.04),

                    // === TITLE SECTION ===
                    _buildTitleSection(),

                    SizedBox(height: screenHeight * 0.03),

                    // === MASCOT SECTION ===
                    _buildMascotSection(),

                    SizedBox(height: screenHeight * 0.03),

                    // === BUTTONS SECTION ===
                    _buildButtonSection(context),

                    SizedBox(height: screenHeight * 0.02),

                    // === FOOTER: SDG Badge + Version ===
                    _buildFooter(),

                    SizedBox(height: screenHeight * 0.02),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────
  // TITLE: "CHAOSITY" with subtitle badge and decorative accent
  // ───────────────────────────────────────────────
  Widget _buildTitleSection() {
    return Column(
      children: [
        // Top decorative line with dots (hitam-putih)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: _inkBlack,
                border: Border.all(color: _inkBlack, width: 2),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 60,
              height: 3,
              color: _inkBlack,
              margin: const EdgeInsets.symmetric(horizontal: 8),
            ),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: _inkBlack, width: 2),
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 60,
              height: 3,
              color: _inkBlack,
              margin: const EdgeInsets.symmetric(horizontal: 8),
            ),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: _inkBlack,
                border: Border.all(color: _inkBlack, width: 2),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Main title with offset shadow effect
        Stack(
          children: [
            // Shadow layer
            Transform.translate(
              offset: const Offset(4, 4),
              child: Text(
                'CHAOSITY',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                  color: _inkBlack.withValues(alpha: 0.1),
                ),
              ),
            ),
            // Main title
            const Text(
              'CHAOSITY',
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w900,
                letterSpacing: 4,
                color: _inkBlack,
                height: 1.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Subtitle badge — tilted for personality
        Transform.rotate(
          angle: -0.02, // Subtle tilt
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: _inkBlack, width: 2.5),
              boxShadow: const [
                BoxShadow(
                  color: _inkBlack,
                  offset: Offset(3, 3),
                ),
              ],
            ),
            child: const Text(
              'CHOICE-BASED CHAOS SIMULATOR',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
                color: _inkBlack,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ───────────────────────────────────────────────
  // MASCOT: Comic panel with character placeholder
  // ───────────────────────────────────────────────
  Widget _buildMascotSection() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // The mascot itself
        const MascotPlaceholder(),

        // Speech bubble floating above right
        Positioned(
          top: 0,
          right: 20,
          child: Transform.rotate(
            angle: 0.05,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: _inkBlack, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Let\'s go!',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: _inkBlack,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ───────────────────────────────────────────────
  // BUTTONS: Main actions with visual hierarchy
  // ───────────────────────────────────────────────
  Widget _buildButtonSection(BuildContext context) {
    return Column(
      children: [
        // Primary CTA — bigger, more prominent
        CustomGameButton(
          text: 'MAIN KAN',
          color: Colors.white,
          onPressed: () {
            // Pindah ke halaman pilih level sesuai poin 2
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ChapterSelectorScreen()),
            );
          },
        ),
        const SizedBox(height: 14),

        // Secondary button
        CustomGameButton(
          text: 'TENTANG GAME',
          color: Colors.white,
          onPressed: () {
            // Show dialog info singkat SDG 4
            _showAboutDialog(context);
          },
        ),
      ],
    );
  }

  // ───────────────────────────────────────────────
  // FOOTER: SDG Badge + version
  // ───────────────────────────────────────────────
  Widget _buildFooter() {
    return Column(
      children: [
        // SDG connection badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            border: Border.all(color: _inkBlack.withValues(alpha: 0.2), width: 1.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.eco_outlined, size: 14, color: _inkBlack.withValues(alpha: 0.4)),
              const SizedBox(width: 6),
              Text(
                'Powered by SDG Goals',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: _inkBlack.withValues(alpha: 0.4),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'v1.0.0',
          style: TextStyle(
            fontSize: 10,
            color: _inkBlack.withValues(alpha: 0.25),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // ───────────────────────────────────────────────
  // CORNER ACCENTS: Decorative comic-panel corners
  // ───────────────────────────────────────────────
  Widget _buildCornerAccents(double screenWidth, double screenHeight) {
    return Stack(
      children: [
        // Top-left corner bracket
        Positioned(
          top: 40,
          left: 16,
          child: CustomPaint(
            size: const Size(30, 30),
            painter: _CornerBracketPainter(corner: _Corner.topLeft),
          ),
        ),
        // Top-right corner bracket
        Positioned(
          top: 40,
          right: 16,
          child: CustomPaint(
            size: const Size(30, 30),
            painter: _CornerBracketPainter(corner: _Corner.topRight),
          ),
        ),
        // Bottom-left corner bracket
        Positioned(
          bottom: 20,
          left: 16,
          child: CustomPaint(
            size: const Size(30, 30),
            painter: _CornerBracketPainter(corner: _Corner.bottomLeft),
          ),
        ),
        // Bottom-right corner bracket
        Positioned(
          bottom: 20,
          right: 16,
          child: CustomPaint(
            size: const Size(30, 30),
            painter: _CornerBracketPainter(corner: _Corner.bottomRight),
          ),
        ),
      ],
    );
  }

  // ───────────────────────────────────────────────
  // ABOUT DIALOG
  // ───────────────────────────────────────────────
  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _bgColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: _inkBlack, width: 3),
          borderRadius: BorderRadius.circular(4),
        ),
        title: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: _inkBlack,
                border: Border.all(color: _inkBlack, width: 2),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Tentang Chaosity',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
          ],
        ),
        content: const Text(
          'Game edukasi berbasis psikologi terbalik untuk mempelajari pilar-pilar SDG (Sustainable Development Goals) melalui simulasi kehidupan mahasiswa yang absurd.',
          style: TextStyle(fontSize: 14, height: 1.5),
        ),
        actions: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: _inkBlack, width: 2),
              boxShadow: const [
                BoxShadow(
                  color: _inkBlack,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'SERU!',
                style: TextStyle(
                  color: _inkBlack,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────────────────────────────────────
// CORNER BRACKET PAINTER
// Draws L-shaped brackets in corners for a comic-panel framing effect
// ───────────────────────────────────────────────
enum _Corner { topLeft, topRight, bottomLeft, bottomRight }

class _CornerBracketPainter extends CustomPainter {
  final _Corner corner;

  _CornerBracketPainter({required this.corner});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.12)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    switch (corner) {
      case _Corner.topLeft:
        path.moveTo(0, size.height);
        path.lineTo(0, 0);
        path.lineTo(size.width, 0);
        break;
      case _Corner.topRight:
        path.moveTo(0, 0);
        path.lineTo(size.width, 0);
        path.lineTo(size.width, size.height);
        break;
      case _Corner.bottomLeft:
        path.moveTo(0, 0);
        path.lineTo(0, size.height);
        path.lineTo(size.width, size.height);
        break;
      case _Corner.bottomRight:
        path.moveTo(0, size.height);
        path.lineTo(size.width, size.height);
        path.lineTo(size.width, 0);
        break;
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}