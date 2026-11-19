-- Skrip DDL Database PPDB Online Kabupaten Sleman
-- Disimpan di: docs/erd/ppdb_sleman_erd.sql

CREATE DATABASE IF NOT EXISTS ppdb_sleman;
USE ppdb_sleman;

CREATE TABLE Sekolah (
    sekolah_id INT AUTO_INCREMENT PRIMARY KEY,
    npsn VARCHAR(16) NOT NULL UNIQUE,
    nama_sekolah VARCHAR(100) NOT NULL,
    kapanewon VARCHAR(50) NOT NULL,
    latitude DECIMAL(10, 7) NOT NULL,
    longitude DECIMAL(10, 7) NOT NULL
);

CREATE TABLE KuotaJalur (
    kuota_id INT AUTO_INCREMENT PRIMARY KEY,
    sekolah_id INT NOT NULL,
    jalur_pendaftaran ENUM('Zonasi', 'Afirmasi', 'Prestasi', 'Perpindahan Orang Tua') NOT NULL,
    jumlah_kuota INT NOT NULL,
    UNIQUE KEY uq_sekolah_jalur (sekolah_id, jalur_pendaftaran),
    CONSTRAINT fk_kuota_sekolah FOREIGN KEY (sekolah_id) REFERENCES Sekolah(sekolah_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE Operator (
    operator_id INT AUTO_INCREMENT PRIMARY KEY,
    sekolah_id INT NULL,
    nama_operator VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    role ENUM('operator_sekolah', 'admin_dinas') NOT NULL,
    CONSTRAINT fk_operator_sekolah FOREIGN KEY (sekolah_id) REFERENCES Sekolah(sekolah_id)
        ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE Pendaftar (
    nik VARCHAR(16) PRIMARY KEY,
    nomor_kk VARCHAR(16) NOT NULL,
    nama_lengkap VARCHAR(100) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    tanggal_daftar DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Pendaftaran (
    pendaftaran_id VARCHAR(20) PRIMARY KEY,
    nik VARCHAR(16) NOT NULL UNIQUE,
    sekolah_id INT NOT NULL,
    jalur_pendaftaran ENUM('Zonasi', 'Afirmasi', 'Prestasi', 'Perpindahan Orang Tua') NOT NULL,
    lat_domisili DECIMAL(10, 7) NOT NULL,
    long_domisili DECIMAL(10, 7) NOT NULL,
    status_berkas ENUM('Dalam Verifikasi', 'Valid', 'Ditolak') NOT NULL DEFAULT 'Dalam Verifikasi',
    status_seleksi ENUM('Proses', 'Terseleksi', 'Tidak Terseleksi') NOT NULL DEFAULT 'Proses',
    waktu_daftar DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_pendaftaran_pendaftar FOREIGN KEY (nik) REFERENCES Pendaftar(nik)
        ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_pendaftaran_sekolah FOREIGN KEY (sekolah_id) REFERENCES Sekolah(sekolah_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE DokumenPersyaratan (
    dokumen_id INT AUTO_INCREMENT PRIMARY KEY,
    pendaftaran_id VARCHAR(20) NOT NULL,
    jenis_dokumen ENUM('KK', 'SKL', 'Bukti Afirmasi', 'Sertifikat Prestasi', 'Surat Tugas Orang Tua') NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    waktu_unggah DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_dokumen_pendaftaran FOREIGN KEY (pendaftaran_id) REFERENCES Pendaftaran(pendaftaran_id)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE VerifikasiKK (
    verifikasi_id INT AUTO_INCREMENT PRIMARY KEY,
    pendaftaran_id VARCHAR(20) NOT NULL UNIQUE,
    operator_id INT NOT NULL,
    nik_kepala_keluarga VARCHAR(16) NOT NULL,
    status_hierarki_kk ENUM('Terverifikasi', 'Tidak Sesuai') NOT NULL,
    catatan_verifikasi TEXT NULL,
    waktu_verifikasi DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_verifikasi_pendaftaran FOREIGN KEY (pendaftaran_id) REFERENCES Pendaftaran(pendaftaran_id)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_verifikasi_operator FOREIGN KEY (operator_id) REFERENCES Operator(operator_id)
        ON UPDATE CASCADE ON DELETE RESTRICT
);