USE ppdb_sleman;

-- 1
SELECT pd.pendaftaran_id, pf.nik, pf.nama_lengkap, s.nama_sekolah, pd.jalur_pendaftaran, pd.status_berkas
FROM pendaftaran pd
JOIN pendaftar pf ON pd.nik = pf.nik
JOIN sekolah s ON pd.sekolah_id = s.sekolah_id
WHERE s.nama_sekolah = 'SMP Negeri 1 Sleman'
ORDER BY pd.waktu_daftar ASC;

-- 2
SELECT pf.nama_lengkap, s.nama_sekolah, vk.nik_kepala_keluarga, vk.status_hierarki_kk, o.nama_operator AS verifikator
FROM verifikasi_kk vk
JOIN pendaftaran pd ON vk.pendaftaran_id = pd.pendaftaran_id
JOIN pendaftar pf ON pd.nik = pf.nik
JOIN sekolah s ON pd.sekolah_id = s.sekolah_id
JOIN operator o ON vk.operator_id = o.operator_id;

-- 3
SELECT s.npsn, s.nama_sekolah, s.kapanewon
FROM sekolah s
LEFT JOIN pendaftaran pd ON s.sekolah_id = pd.sekolah_id
WHERE pd.pendaftaran_id IS NULL;

-- 4
SELECT pd.pendaftaran_id, pf.nama_lengkap, COUNT(dp.dokumen_id) AS jumlah_dokumen
FROM pendaftaran pd
JOIN pendaftar pf ON pd.nik = pf.nik
JOIN dokumen_persyaratan dp ON pd.pendaftaran_id = dp.pendaftaran_id
GROUP BY pd.pendaftaran_id, pf.nama_lengkap
HAVING COUNT(dp.dokumen_id) > 1;

-- 5
SELECT pf.nik, pf.nama_lengkap, pd.jalur_pendaftaran, pd.status_seleksi
FROM pendaftaran pd
JOIN pendaftar pf ON pd.nik = pf.nik
WHERE pd.jalur_pendaftaran = 'Zonasi'
  AND pd.sekolah_id IN (
      SELECT sekolah_id
      FROM sekolah
      WHERE kapanewon = 'Sleman'
  );

-- 6
SELECT pd.pendaftaran_id, pf.nama_lengkap,
       ROUND(6371 * ACOS(
           COS(RADIANS(s.latitude)) * COS(RADIANS(pd.lat_domisili)) *
           COS(RADIANS(pd.long_domisili) - RADIANS(s.longitude)) +
           SIN(RADIANS(s.latitude)) * SIN(RADIANS(pd.lat_domisili))
       ), 2) AS jarak_km,
       pd.status_seleksi
FROM pendaftaran pd
JOIN pendaftar pf ON pd.nik = pf.nik
JOIN sekolah s ON pd.sekolah_id = s.sekolah_id
WHERE s.sekolah_id = 1 AND pd.jalur_pendaftaran = 'Zonasi'
ORDER BY jarak_km ASC;