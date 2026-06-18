import 'package:flutter/material.dart';

class GameScreenChapter4 extends StatefulWidget {
  const GameScreenChapter4({Key? key}) : super(key: key);

  @override
  State<GameScreenChapter4> createState() => _GameScreenChapter4State();
}

class _GameScreenChapter4State extends State<GameScreenChapter4> {
  // 💡 Ubah jadi 'false' jika sudah pas untuk menyembunyikan kotak merah pembantu
  bool showDebugHotspots = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          // Menggunakan AspectRatio 1:1 sesuai dengan proporsi gambar image_d25ae3.png
          child: AspectRatio(
            aspectRatio: 1.0, 
            child: LayoutBuilder(
              builder: (context, constraints) {
                // Ambil ukuran dinamis dari layar perangkat
                final double w = constraints.maxWidth;
                final double h = constraints.maxHeight;

                return Stack(
                  children: [
                    // === LAYER 1: Gambar Latar Belakang Statis ===
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/image_d25ae3.png', // Pastikan sudah didaftarkan di pubspec.yaml
                        fit: BoxFit.contain,
                      ),
                    ),

                    // === LAYER 2: Hotspot Objek A (Pintu Keluar / Bilik Kiri) ===
                    _buildHotspot(
                      name: "Objek A: Pintu Keluar",
                      top: h * 0.15,   // Mulai dari 15% dari atas
                      left: w * 0.02,  // Mulai dari 2% dari kiri
                      width: w * 0.30, // Lebar kotak 30% dari total lebar
                      height: h * 0.65,// Tinggi kotak 65% dari total tinggi
                      onTap: () {
                        _handleChoice(context, "Pemain memilih kabur lewat pintu.");
                      },
                    ),

                    // === LAYER 3: Hotspot Objek B (Keran Wastafel Kiri yang Rusak) ===
                    _buildHotspot(
                      name: "Objek B: Keran Rusak",
                      top: h * 0.40,
                      left: w * 0.44,
                      width: w * 0.18,
                      height: h * 0.22,
                      onTap: () {
                        _handleChoice(context, "Pemain menekan saklar darurat dekat keran.");
                      },
                    ),

                    // === LAYER 4: Hotspot Objek C (Ventilasi Tengah / Tempat Sembunyi Alat) ===
                    _buildHotspot(
                      name: "Objek C: Ventilasi",
                      top: h * 0.52,
                      left: w * 0.61,
                      width: w * 0.12,
                      height: h * 0.08,
                      onTap: () {
                        _handleChoice(context, "Pemain mengambil kunci inggris di ventilasi.");
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // Helper Widget untuk membuat area klik yang fleksibel
  Widget _buildHotspot({
    required String name,
    required double top,
    required double left,
    required double width,
    required double height,
    required VoidCallback onTap,
  }) {
    return Positioned(
      top: top,
      left: left,
      width: width,
      height: height,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          // Jika debug mode aktif, beri warna merah transparan + text pembantu
          color: showDebugHotspots 
              ? Colors.red.withValues(alpha: 0.3) 
              : Colors.transparent,
          alignment: Alignment.center,
          child: showDebugHotspots
              ? Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 9, color: Colors.red, fontWeight: FontWeight.bold),
                )
              : null,
        ),
      ),
    );
  }

  // Fungsi eksekusi ketika objek diklik
  void _handleChoice(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
    // Di sini nanti tempat berpindah ke Frame 2 (Action/Reaksi)
  }
}