# Kelompok 5 Gatot
Dian Krisna Rusmayanti - 25523140
Akbar Muzacky Syah - 25523128
Friska Rahmadani - 25523106
Ahmad Azam Al-Bar - 25523114
# Masalah
Proses verifikasi data dan zonasi PPDB tingkat SMP Negeri rawan kecurangan data domisili serta memakan waktu verifikasi manual yang lama.
# Pelaku
Panitia sekolah, orangtua ataupun calon peserta didik baru, dan dinas pendidikan.
# Proses Bisnis
1. Tahap Persiapan dan Pengaturan Sistem (Aktor: Admin)
    - Pengelolaan Data Sekolah & Kuota: Admin menginput dan mengelola data sekolah peserta PPDB
      serta menetapkan alokasi kuota daya tampung untuk masing-masing sekolah.   
    - Pengelolaan Jadwal & Jalur: Admin mengatur jadwal pelaksanaan dan menetapkan ketentuan
      untuk 4 jalur pendaftaran (Zonasi, Afirmasi, Prestasi, dan Perpindahan Orang Tua).   
    - Pemantauan: Admin memantau jalannya proses pendaftaran dan melihat laporan pendaftar secara keseluruhan.   
2. Tahap Pendaftaran Akun dan Pengisian Data (Aktor: Calon Peserta Didik / Orang Tua)
    1. Registrasi & Login: Calon peserta didik atau orang tua membuat akun baru pada platform PPDB Online,
       kemudian melakukan login ke dalam sistem.   
    2. Pengisian Formulir: Peserta memilih salah satu dari 4 jalur pendaftaran
       (Zonasi, Afirmasi, Prestasi, atau Perpindahan Orang Tua) dan mengisi formulir pendaftaran.   
    3. Pemrosesan Otomatis oleh Sistem (Include):
        - Verifikasi Nomor & Hierarki KK: Sistem secara otomatis memvalidasi data Nomor Kartu Keluarga
          dan struktur anggota keluarga yang diinput.   
        - Perhitungan Jarak Zonasi: Berdasarkan titik koordinat lokasi domisili peserta dan
          lokasi sekolah tujuan, sistem menghitung jarak zonasi secara otomatis.   
    4. Unggah Berkas: Peserta mengunggah dokumen persyaratan yang dibutuhkan
       (seperti KK, ijazah/SKL, sertifikat prestasi, atau surat pindah tugas).   
3. Tahap Verifikasi dan Validasi Data (Aktor: Operator Sekolah)
    1. Verifikasi Berkas: Operator sekolah memeriksa kelengkapan dan keabsahan dokumen persyaratan yang
       diunggah oleh peserta.   
    3. Verifikasi Data KK: Operator mengonfirmasi kembali kesesuaian data KK dan hierarki keluarga.   
    4. Pemeriksaan Domisili: Operator memverifikasi titik koordinat domisili calon peserta didik
       untuk memastikan keakuratan posisi.   
    5. Perhitungan Jarak Zonasi Otomatis: Sistem/Operator memastikan hasil perhitungan jarak zonasi valid
       sesuai data lapangan.   
4. Tahap Pemantauan dan Pengumuman Hasil (Aktor: Calon Peserta Didik & Operator Sekolah)
    - Pantau Daftar Pendaftar: Operator sekolah memantau dan mengelola pemeringkatan daftar
      pendaftar per jalur secara real-time.   
    - Pengumuman Hasil: Operator merilis pengumuman hasil seleksi akhir.   
    - Melihat Informasi & Hasil: Calon peserta didik / orang tua dapat mengakses sistem
      untuk melihat kuota sekolah, memantau status pendaftaran, serta melihat hasil akhir pengumuman kelulusan/seleksi.   
