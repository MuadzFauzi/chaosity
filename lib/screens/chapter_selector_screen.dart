import 'package:flutter/material.dart';
import '../widgets/chaos_background_painter.dart';

class ChapterSelectorScreen extends StatelessWidget {
  const ChapterSelectorScreen({super.key});

  // === Design Tokens (hitam-putih, sama dengan starting_screen) ===
  static const Color _bgColor = Color(0xFFF0F0F0);
  static const Color _inkBlack = Color(0xFF1A1A1A);

  // Data chapter berdasarkan skenario SDG
  static final List<Map<String, String>> _chapters = [
    {
      'num': '01',
      'title': 'Akhir Bulan Kosan',
      'sdg': 'SDG 1 — No Poverty',
      'desc': 'Bertahan hidup di akhir bulan dengan saldo menipis.',
    },
    {
      'num': '02',
      'title': 'SKS Sistem Kebut Semalam',
      'sdg': 'SDG 3 — Good Health',
      'desc': 'Kejar deadline tugas tanpa mengorbankan kesehatan.',
    },
    {
      'num': '03',
      'title': 'Dilema Ketua BEM',
      'sdg': 'SDG 5 — Gender Equality',
      'desc': 'Pimpin organisasi dengan keputusan yang adil.',
    },
    {
      'num': '04',
      'title': 'Misteri Keran Toilet GKB',
      'sdg': 'SDG 6 — Clean Water',
      'desc': 'Hentikan pemborosan air dari keran rusak sebelum satu kampus tenggelam.',
    },
    {
      'num': '05',
      'title': 'Krisis Listrik Kosan',
      'sdg': 'SDG 7 — Clean Energy',
      'desc': 'Mencari sumber listrik alternatif saat pemadaman bergilir.',
    },
    {
      'num': '06',
      'title': 'Ledakan Lemari Baju',
      'sdg': 'SDG 12 — R. Consumption',
      'desc': 'Menyelamatkan diri dari tumpukan limbah fast fashion.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: Stack(
        children: [
          // === LAYER 1: Chaos background doodles ===
          Positioned.fill(
            child: CustomPaint(
              painter: ChaosBackgroundPainter(
                lineColor: _inkBlack,
                opacity: 0.04,
              ),
            ),
          ),

          // === LAYER 2: Main content ===
          SafeArea(
            child: Column(
              children: [
                // === CUSTOM APP BAR ===
                _buildAppBar(context),

                // === CHAPTER LIST ===
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                    itemCount: _chapters.length,
                    itemBuilder: (context, index) {
                      return _buildChapterCard(context, _chapters[index], index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────
  // CUSTOM APP BAR: Matching the starting screen style
  // ───────────────────────────────────────────────
  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 20, 0),
      child: Row(
        children: [
          // Back button with comic border
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 42,
              height: 42,
              margin: const EdgeInsets.only(left: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: _inkBlack, width: 2.5),
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: _inkBlack,
                    offset: Offset(3, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: _inkBlack,
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Title area
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PILIH CHAPTER',
                  style: TextStyle(
                    color: _inkBlack,
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 4),
                // Decorative line under title
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 3,
                      color: _inkBlack,
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: _inkBlack,
                        border: Border.all(color: _inkBlack, width: 1.5),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 20,
                      height: 3,
                      color: _inkBlack,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Chapter count badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: _inkBlack, width: 2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '${_chapters.length} CH',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: _inkBlack,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────
  // CHAPTER CARD: Comic-panel style chapter entry
  // ───────────────────────────────────────────────
  Widget _buildChapterCard(
      BuildContext context, Map<String, String> chapter, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: _inkBlack,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: const BorderSide(color: Colors.white, width: 1),
              ),
              content: Text(
                'Membuka ${chapter['sdg']}...',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
          // TODO: Hubungkan ke halaman game engine frame UI
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: _inkBlack, width: 3),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: _inkBlack,
                offset: Offset(4, 4),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // === LEFT: Chapter number panel ===
                Container(
                  width: 60,
                  decoration: BoxDecoration(
                    color: _inkBlack,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(7),
                      bottomLeft: Radius.circular(7),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        chapter['num']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Container(
                        width: 20,
                        height: 2,
                        color: Colors.white.withValues(alpha: 0.4),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'CH',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),

                // === RIGHT: Chapter info ===
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Chapter title
                        Text(
                          chapter['title']!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: _inkBlack,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Description
                        Text(
                          chapter['desc']!,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: _inkBlack.withValues(alpha: 0.5),
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // SDG tag + arrow
                        Row(
                          children: [
                            // SDG badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: _inkBlack.withValues(alpha: 0.3),
                                    width: 1.5),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                chapter['sdg']!,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: _inkBlack.withValues(alpha: 0.5),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                            const Spacer(),

                            // Play arrow
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: _inkBlack,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}