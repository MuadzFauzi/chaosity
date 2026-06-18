# 🌀 Chaosity: Media Pembelajaran SDG Berbasis Pilihan Interaktif

**Chaosity** adalah sebuah aplikasi media pembelajaran inovatif yang dikemas dalam bentuk game interaktif berbasis pilihan (*Choose Your Own Adventure / Chaos Simulator*) ala *Henry Stickmin* atau *Kuukiyomi*. Berfokus utama pada **SDG 4 (Pendidikan Berkualitas)**, aplikasi ini bertujuan mentransformasikan materi edukasi global yang biasanya kaku menjadi skenario dilema kehidupan sehari-hari yang dekat dengan dunia mahasiswa.

Menggunakan metode **psikologi terbalik (reverse psychology)**, pemain diberikan kebebasan untuk "berbuat salah" di dalam game dan melihat langsung akibat ekstremnya melalui efek sebab-akibat (*Butterfly Effect*) yang konyol, satir, atau destruktif. Di akhir babak, game menyajikan pesan edukasi informatif untuk memperkuat retensi pemahaman pengguna terhadap berbagai pilar SDG lainnya.

---

## 🛠️ Fitur & Fungsi Utama

* **State-Based Frame UI System (Infrastruktur Ringan):** Antarmuka Flutter yang efisien memanfaatkan perubahan aset visual statis berbasis state. Aplikasi tidak membutuhkan animasi berjalan yang kompleks sehingga sangat ringan dalam proses eksekusi dan koding.
* **Gamified Educational Scenario Branching (Mesin Pembelajaran Interaktif):** Menyediakan kurikulum berbasis game berupa skenario pilihan bercabang. Pengguna belajar secara aktif dengan mengeksplorasi akhir cerita yang sukses (`SUCCESS`) atau gagal (`FAIL/FUNNY`).
* **Post-Scenario Educational Logs (Evaluasi Pembelajaran):** Setiap kali pemain menyentuh akhir dari sebuah pilihan, Flutter UI akan memunculkan dialog log penjelasan yang memadukan humor mahasiswa dengan teks penjelas edukasi yang informatif berdasarkan fakta riil.

---

## 🗺️ Daftar Chapter & Target SDG

Aplikasi ini mencakup 6 pilar SDG lintas sektor yang dikemas dalam dilema lokal mahasiswa:

| Chapter | Judul Skenario | Target SDG | Deskripsi Singkat |
| :---: | :--- | :--- | :--- |
| **01** | Akhir Bulan Kosan | **SDG 1: No Poverty** | Simulasi risiko finansial digital (pinjol/judi online) di perantauan. |
| **02** | SKS Sistem Kebut Semalam | **SDG 3: Good Health & Well-Being** | Dampak fisik akibat manajemen waktu buruk dan kebiasaan begadang. |
| **03** | Dilema Ketua BEM | **SDG 5: Gender Equality** | Mengatasi bias gender dan stereotip dalam dunia kerja/organisasi kampus. |
| **04** | Misteri Keran Toilet GKB | **SDG 6: Clean Water & Sanitation** | Efisiensi dan tanggung jawab menjaga fasilitas air bersih di umum. |
| **05** | Krisis Listrik Kosan | **SDG 7: Affordable & Clean Energy** | Pengenalan energi alternatif ramah lingkungan saat pemadaman listrik. |
| **06** | Ledakan Lemari Baju | **SDG 12: Responsible Consumption** | Dampak limbah tekstil dari perilaku belanja impulsif (*fast fashion*). |

---

## 🚀 Cara Menjalankan Proyek di Lokal

### Prasyarat
* Sudah menginstal [Flutter SDK](https://docs.flutter.dev/get-started/install) terbaru.
* Perangkat Android (Emulator atau HP Fisik dengan USB Debugging aktif).

### Langkah Instalasi
1. Clone repositori ini ke laptop Anda:
  ```bash
  git clone https://github.com/MuadzFauzi/chaosity.git
  ```
2. Masuk ke direktori proyek:

  ```bash
  cd chaosity
  ```
3. Ambil semua dependensi package yang dibutuhkan:
  ```bash
  flutter pub get
  ```
4. Jalankan aplikasi di perangkat Anda:
  ```bash
  flutter run
  ```
🎨 Desain Visual & Tema
Game ini menggunakan gaya Neo-Brutalism / Comic Style dengan ciri khas:

- Garis tepi hitam yang tebal (thick borders).
- Warna-warna flat kontras tinggi yang kaku.
- Aset visual komik statis untuk menjaga performa aplikasi tetap optimal dan ringan.
