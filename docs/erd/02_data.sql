USE ppdb_sleman;

INSERT INTO sekolah (sekolah_id, npsn, nama_sekolah, kapanewon, latitude, longitude) VALUES
(1, '20401001', 'SMP Negeri 1 Sleman', 'Sleman', -7.7161230, 110.3554320),
(2, '20401002', 'SMP Negeri 2 Sleman', 'Sleman', -7.7052100, 110.3612450),
(3, '20401003', 'SMP Negeri 1 Depok', 'Depok', -7.7689120, 110.4098760),
(4, '20401004', 'SMP Negeri 1 Mlati', 'Mlati', -7.7345120, 110.3651230),
(5, '20401005', 'SMP Negeri 2 Depok', 'Depok', -7.7591230, 110.3987650); 

INSERT INTO pendaftar (nik, nomor_kk, nama_lengkap, password_hash, tanggal_daftar) VALUES
('3404010000000001', '3404019900000001', 'Dian Krisna', '$2y$10$hashdummy001', '2026-06-15 08:10:00'),
('3404010000000002', '3404019900000002', 'Akbar Muzacky', '$2y$10$hashdummy002', '2026-06-15 08:25:00'),
('3404010000000003', '3404019900000003', 'Friska Rahmadani', '$2y$10$hashdummy003', '2026-06-15 09:05:00'),
('3404010000000004', '3404019900000004', 'Ahmad Azam', '$2y$10$hashdummy004', '2026-06-15 10:15:00'),
('3404010000000005', '3404019900000005', 'Nabila Putri', '$2y$10$hashdummy005', '2026-06-16 07:45:00'),
('3404010000000006', '3404019900000006', 'Fajar Nugroho', '$2y$10$hashdummy006', '2026-06-16 11:20:00'),
('3404010000000007', '3404019900000007', 'Rizky Pratama', '$2y$10$hashdummy007', '2026-06-16 12:00:00'); 

INSERT INTO kuota_jalur (kuota_id, sekolah_id, jalur_pendaftaran, jumlah_kuota) VALUES
(1, 1, 'Zonasi', 96),
(2, 1, 'Afirmasi', 24),
(3, 1, 'Prestasi', 32),
(4, 1, 'Perpindahan Orang Tua', 8),
(5, 2, 'Zonasi', 80),
(6, 2, 'Prestasi', 25),
(7, 3, 'Zonasi', 90),
(8, 4, 'Afirmasi', 20);

INSERT INTO operator (operator_id, sekolah_id, nama_operator, email, role) VALUES
(1, 1, 'Budi Santoso', 'op.smpn1sleman@slemankab.go.id', 'operator_sekolah'),
(2, 2, 'Siti Aminah', 'op.smpn2sleman@slemankab.go.id', 'operator_sekolah'),
(3, 3, 'Hendra Wijaya', 'op.smpn1depok@slemankab.go.id', 'operator_sekolah'),
(4, 4, 'Rina Kusuma', 'op.smpn1mlati@slemankab.go.id', 'operator_sekolah'),
(5, NULL, 'Admin Dinas Sleman', 'admin.ppdb@slemankab.go.id', 'admin_dinas'); 

INSERT INTO pendaftaran (pendaftaran_id, nik, sekolah_id, jalur_pendaftaran, lat_domisili, long_domisili, status_berkas, status_seleksi, waktu_daftar) VALUES
(1, '3404010000000001', 1, 'Zonasi', -7.7210000, 110.3580000, 'Terverifikasi', 'Terseleksi', '2026-06-15 08:30:00'),
(2, '3404010000000002', 1, 'Zonasi', -7.7250000, 110.3600000, 'Terverifikasi', 'Terseleksi', '2026-06-15 08:50:00'),
(3, '3404010000000003', 1, 'Prestasi', -7.7300000, 110.3620000, 'Terverifikasi', 'Terseleksi', '2026-06-15 09:30:00'),
(4, '3404010000000004', 3, 'Zonasi', -7.7701000, 110.4110000, 'Ditolak', 'Tidak Lolos', '2026-06-15 10:45:00'),
(5, '3404010000000005', 4, 'Afirmasi', -7.7360000, 110.3660000, 'Dalam Verifikasi', 'Proses', '2026-06-16 08:15:00'),
(6, '3404010000000007', 2, 'Prestasi', -7.7080000, 110.3620000, 'Terverifikasi', 'Terseleksi', '2026-06-16 12:15:00'); 

INSERT INTO dokumen_persyaratan (dokumen_id, pendaftaran_id, jenis_dokumen, file_path, waktu_unggah) VALUES
(1, 1, 'KK', '/uploads/kk_3404010000000001.pdf', '2026-06-15 08:28:00'),
(2, 1, 'SKL', '/uploads/skl_3404010000000001.pdf', '2026-06-15 08:29:00'),
(3, 2, 'KK', '/uploads/kk_3404010000000002.pdf', '2026-06-15 08:48:00'),
(4, 2, 'SKL', '/uploads/skl_3404010000000002.pdf', '2026-06-15 08:49:00'),
(5, 3, 'KK', '/uploads/kk_3404010000000003.pdf', '2026-06-15 09:25:00'),
(6, 3, 'Sertifikat Prestasi', '/uploads/prestasi_3404010000000003.pdf', '2026-06-15 09:28:00'),
(7, 4, 'KK', '/uploads/kk_3404010000000004.pdf', '2026-06-15 10:40:00'),
(8, 5, 'KK', '/uploads/kk_3404010000000005.pdf', '2026-06-16 08:10:00'),
(9, 5, 'Kartu KIP', '/uploads/kip_3404010000000005.pdf', '2026-06-16 08:12:00'),
(10, 6, 'KK', '/uploads/kk_3404010000000007.pdf', '2026-06-16 12:10:00');

INSERT INTO verifikasi_kk (verifikasi_id, pendaftaran_id, operator_id, nik_kepala_keluarga, status_hierarki_kk, catatan_verifikasi, waktu_verifikasi) VALUES
(1, 1, 1, '3404011100000001', 'Valid - Anak Kandung', NULL, '2026-06-15 09:00:00'),
(2, 2, 1, '3404011100000002', 'Valid - Anak Kandung', 'Data KK sesuai Dukcapil', '2026-06-15 09:15:00'),
(3, 3, 1, '3404011100000003', 'Valid - Anak Kandung', NULL, '2026-06-15 10:00:00'),
(4, 4, 3, '3404011100000004', 'Tidak Valid - Famili Lain', 'Numpang KK kurang dari 1 tahun', '2026-06-15 11:10:00')
(5, 6, 2, '3404011100000007', 'Valid - Anak Kandung', NULL, '2026-06-16 12:30:00');