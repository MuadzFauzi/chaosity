import 'package:flutter/material.dart';

enum _Phase {
  intro,
  menu1,
  flushCuciGif,
  menu2,
  successGif,
  successDialog,
  failKeluarMenu2Gif,
  failKeluarMenu2Dialog,
  cuciTanganTransition,
  menu3,
  failKeluarMenu3Gif,
  failKeluarMenu3Dialog,
  failKeranMenu3Gif,
  failKeranMenu3Dialog,
  flushAjaGif,
  flushAjaDialog,
}

class GameScreenChapter4 extends StatefulWidget {
  const GameScreenChapter4({Key? key}) : super(key: key);

  @override
  State<GameScreenChapter4> createState() => _GameScreenChapter4State();
}

class _GameScreenChapter4State extends State<GameScreenChapter4>
    with TickerProviderStateMixin {
  static const Color _inkBlack = Color(0xFF1A1A1A);

  _Phase _phase = _Phase.intro;

  String _bgImage = 'assets/images/Scene1.png';
  String _fgImage = '';
  int _bgVer = 0;
  int _fgVer = 0;

  late final AnimationController _imgFadeCtrl;
  late final Animation<double> _imgFade;

  late final AnimationController _overlayFadeCtrl;
  late final Animation<double> _overlayFade;

  @override
  void initState() {
    super.initState();

    _imgFadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _imgFade = CurvedAnimation(parent: _imgFadeCtrl, curve: Curves.easeInOut);
    _imgFadeCtrl.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _bgImage = _fgImage;
          _bgVer = _fgVer;
          _fgImage = '';
        });
        _imgFadeCtrl.reset();
      }
    });

    _overlayFadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _overlayFade =
        CurvedAnimation(parent: _overlayFadeCtrl, curve: Curves.easeInOut);

    _startIntro();
  }

  @override
  void dispose() {
    _imgFadeCtrl.dispose();
    _overlayFadeCtrl.dispose();
    super.dispose();
  }

  void _crossfadeTo(String newAsset) {
    setState(() {
      _fgImage = newAsset;
      _fgVer++;
    });
    _imgFadeCtrl.forward(from: 0.0);
  }

  void _startIntro() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      if (!mounted) return;
      _crossfadeTo('assets/images/Scene2.png');
      Future.delayed(const Duration(milliseconds: 700), () {
        if (!mounted) return;
        setState(() => _phase = _Phase.menu1);
        _overlayFadeCtrl.forward(from: 0.0);
      });
    });
  }

  void _delayedTransition(String gifAsset, _Phase gifPhase, Duration wait,
      String nextAsset, _Phase nextPhase) {
    _overlayFadeCtrl.reset();
    _crossfadeTo(gifAsset);
    setState(() => _phase = gifPhase);

    Future.delayed(wait, () {
      if (!mounted) return;
      _crossfadeTo(nextAsset);
      Future.delayed(const Duration(milliseconds: 700), () {
        if (!mounted) return;
        setState(() => _phase = nextPhase);
        _overlayFadeCtrl.forward(from: 0.0);
      });
    });
  }

  void _onMenu1(int choice) {
    switch (choice) {
      case 1:
        _delayedTransition(
          'assets/images/Scene3_final.webp',
          _Phase.flushCuciGif,
          const Duration(milliseconds: 3200),
          'assets/images/Scene3C.webp',
          _Phase.menu2,
        );
        break;
      case 2:
        _delayedTransition(
          'assets/images/Scene_failed3.png',
          _Phase.cuciTanganTransition,
          const Duration(milliseconds: 2400),
          'assets/images/Scene3D.png',
          _Phase.menu3,
        );
        break;
      case 3:
        _delayedTransition(
          'assets/images/Scene_failed4.webp',
          _Phase.flushAjaGif,
          const Duration(milliseconds: 3000),
          'assets/images/Scene1.png',
          _Phase.flushAjaDialog,
        );
        break;
    }
  }

  void _onMenu2(int choice) {
    if (choice == 1) {
      _delayedTransition(
        'assets/images/Scene_failed1.webp',
        _Phase.failKeluarMenu2Gif,
        const Duration(milliseconds: 7000),
        'assets/images/Scene_failed1.png',
        _Phase.failKeluarMenu2Dialog,
      );
    } else {
      _delayedTransition(
        'assets/images/Scene_success.webp',
        _Phase.successGif,
        const Duration(milliseconds: 2200),
        'assets/images/Scene1.png',
        _Phase.successDialog,
      );
    }
  }

  void _onMenu3(int choice) {
    if (choice == 1) {
      _delayedTransition(
        'assets/images/Scene_failed2.webp',
        _Phase.failKeluarMenu3Gif,
        const Duration(milliseconds: 6600),
        'assets/images/Scene_failed2.png',
        _Phase.failKeluarMenu3Dialog,
      );
    } else {
      _delayedTransition(
        'assets/images/Scene_failed3.webp',
        _Phase.failKeranMenu3Gif,
        const Duration(milliseconds: 2100),
        'assets/images/Scene_failed3.png',
        _Phase.failKeranMenu3Dialog,
      );
    }
  }

  void _resetGame() {
    _overlayFadeCtrl.reset();
    _imgFadeCtrl.reset();
    setState(() {
      _phase = _Phase.intro;
      _bgImage = 'assets/images/Scene1.png';
      _fgImage = '';
      _bgVer++;
    });
    _startIntro();
  }

  bool get _isTransition =>
      _phase == _Phase.intro ||
      _phase == _Phase.flushCuciGif ||
      _phase == _Phase.cuciTanganTransition ||
      _phase == _Phase.successGif ||
      _phase == _Phase.failKeluarMenu2Gif ||
      _phase == _Phase.failKeluarMenu3Gif ||
      _phase == _Phase.failKeranMenu3Gif ||
      _phase == _Phase.flushAjaGif;

  bool get _showOverlay =>
      _phase == _Phase.menu1 ||
      _phase == _Phase.menu2 ||
      _phase == _Phase.menu3 ||
      _phase == _Phase.successDialog ||
      _phase == _Phase.failKeluarMenu2Dialog ||
      _phase == _Phase.failKeluarMenu3Dialog ||
      _phase == _Phase.failKeranMenu3Dialog ||
      _phase == _Phase.flushAjaDialog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _inkBlack,
      body: SafeArea(
        child: Center(
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    _bgImage,
                    key: ValueKey<String>('bg-$_bgImage-$_bgVer'),
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  ),
                ),
                if (_fgImage.isNotEmpty)
                  Positioned.fill(
                    child: FadeTransition(
                      opacity: _imgFade,
                      child: Image.asset(
                        _fgImage,
                        key: ValueKey<String>('fg-$_fgImage-$_fgVer'),
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                      ),
                    ),
                  ),
                if (_isTransition) _buildLoadingChip(),
                if (_showOverlay)
                  FadeTransition(
                    opacity: _overlayFade,
                    child: _buildCurrentOverlay(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentOverlay() {
    switch (_phase) {
      case _Phase.menu1:
        return _buildMenu1();
      case _Phase.menu2:
        return _buildMenu2();
      case _Phase.menu3:
        return _buildMenu3();
      case _Phase.successDialog:
        return _buildSuccessDialog();
      case _Phase.failKeluarMenu2Dialog:
        return _buildFailDialog(
          pesan:
              'Kamu buru-buru keluar karena takut telat, tapi keran wastafel masih mengucur deras! '
              'Selamat, kamu baru saja menyumbang banjir mini di lantai 3 GKB. '
              'Petugas kebersihan kirim surat cinta buat kamu. 👏💧',
        );
      case _Phase.failKeluarMenu3Dialog:
        return _buildFailDialog(
          pesan:
              'Kamu keluar dengan tangan bersih dan hati tenang, tapi '
              'toilet yang belum di-flush mengeluarkan aroma "parfum organik" '
              'yang bikin penghuni bilik sebelah mimisan. '
              'Sanitasi itu bukan cuma soal diri sendiri, lho! 🚽💀',
        );
      case _Phase.failKeranMenu3Dialog:
        return _buildFailDialog(
          pesan:
              'Bagus, kamu amankan keran dari kebocoran! '
              'Tapi... kamu tetap lupa flush toilet. '
              'Bioreaktor amonia di dalam kloset sudah siap meledak '
              'dan menghantui pengguna berikutnya. '
              'Setidaknya kerannya aman, ya kan? 😅🧪',
        );
      case _Phase.flushAjaDialog:
        return _buildFailDialog(
          pesan:
              'Kamu flush toilet lalu langsung cabut tanpa cuci tangan. '
              'Jutaan bakteri E. coli kini menumpang gratis di jari-jarimu '
              'dan siap berpetualang ke gagang pintu, buku, dan wajah temanmu. '
              'Selamat menjadi agen biologis kampus! 🦠✋',
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildLoadingChip() {
    return Positioned(
      top: 14,
      left: 14,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: _inkBlack, width: 2.5),
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(color: _inkBlack, offset: Offset(3, 3)),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(_inkBlack),
              ),
            ),
            SizedBox(width: 8),
            Text(
              'LOADING...',
              style: TextStyle(
                color: _inkBlack,
                fontWeight: FontWeight.w800,
                fontSize: 10,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenu1() {
    return Center(
      child: _brutalCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _menuHeader('⚠️  MAU NGAPAIN SEKARANG?'),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
              child: Column(
                children: [
                  _brutalBtn(
                    label: 'Flush dan Cuci Tangan',
                    onTap: () => _onMenu1(1),
                  ),
                  const SizedBox(height: 10),
                  _brutalBtn(
                    label: 'Cuci Tangan Aja',
                    onTap: () => _onMenu1(2),
                  ),
                  const SizedBox(height: 10),
                  _brutalBtn(
                    label: 'Flush Aja',
                    onTap: () => _onMenu1(3),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenu2() {
    return Center(
      child: _brutalCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _menuHeader('🚰  KERAN MASIH NYALA!'),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
              child: Column(
                children: [
                  _brutalBtn(
                    label: 'Buruan keluar, nanti telat masuk kelas!',
                    onTap: () => _onMenu2(1),
                  ),
                  const SizedBox(height: 10),
                  _brutalBtn(
                    label:
                        'Putar silinder besi penutup katup saluran hidrolik searah jarum jam untuk mematikan keran air.',
                    fontSize: 11,
                    onTap: () => _onMenu2(2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenu3() {
    return Center(
      child: _brutalCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _menuHeader('🚽  LUPA FLUSH, BRO!'),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
              child: Column(
                children: [
                  _brutalBtn(
                    label: 'Keluar langsung, tangan udah bersih ini.',
                    onTap: () => _onMenu3(1),
                  ),
                  const SizedBox(height: 10),
                  _brutalBtn(
                    label: 'Amankan keran toilet dari kebocoran masal.',
                    onTap: () => _onMenu3(2),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessDialog() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: _brutalCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _menuHeader('🎉  STAGE COMPLETE!'),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'Pilihan brilian! Kamu flush toilet DAN cuci tangan '
                        'sambil memastikan keran air tidak terbuang sia-sia. '
                        'Kamu adalah pahlawan sanitasi sejati hari ini! 🌟',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: _inkBlack,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: _inkBlack, width: 2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          children: const [
                            Text(
                              '💧 SDG 6 — Air Bersih & Sanitasi Layak',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 12,
                                color: _inkBlack,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Akses terhadap sanitasi yang aman bukan hanya soal '
                              'kebersihan diri, melainkan tanggung jawab bersama '
                              'untuk menjaga fasilitas publik agar tetap sehat '
                              'dan layak bagi semua orang. Setiap tetes air yang '
                              'kamu hemat berkontribusi pada masa depan yang berkelanjutan.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                fontStyle: FontStyle.italic,
                                color: _inkBlack,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _brutalBtn(
                              label: '🔄 Replay',
                              onTap: _resetGame,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _brutalBtn(
                              label: '🏠 Main Menu',
                              inverted: true,
                              onTap: () => Navigator.pop(context),
                            ),
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
      ),
    );
  }

  Widget _buildFailDialog({required String pesan}) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: _brutalCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _menuHeader('❌  STAGE FAILED!'),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        pesan,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          color: _inkBlack,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: _inkBlack, width: 2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          '💡 Tips: Sanitasi yang benar dimulai dari kebiasaan kecil — '
                          'flush toilet, cuci tangan, dan pastikan keran tidak bocor. '
                          'Coba lagi dan tunjukkan bahwa kamu peduli!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            fontStyle: FontStyle.italic,
                            color: _inkBlack,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _brutalBtn(
                              label: '🔁 Try Again',
                              onTap: _resetGame,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _brutalBtn(
                              label: '🏠 Main Menu',
                              inverted: true,
                              onTap: () => Navigator.pop(context),
                            ),
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
      ),
    );
  }

  Widget _brutalCard({required Widget child}) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 320),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _inkBlack, width: 3),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: _inkBlack, offset: Offset(4, 4)),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }

  Widget _menuHeader(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: _inkBlack,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(7),
          topRight: Radius.circular(7),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 14,
          color: Colors.white,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _brutalBtn({
    required String label,
    required VoidCallback onTap,
    double fontSize = 12,
    bool inverted = false,
  }) {
    final Color bg = inverted ? _inkBlack : Colors.white;
    final Color fg = inverted ? Colors.white : _inkBlack;

    return SizedBox(
      width: double.infinity,
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: _inkBlack, width: 2.5),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: fontSize,
                color: fg,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}