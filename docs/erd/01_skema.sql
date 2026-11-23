CREATE DATABASE IF NOT EXISTS ppdb_sleman
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE ppdb_sleman;

CREATE TABLE sekolah (
    sekolah_id INT AUTO_INCREMENT PRIMARY KEY,
    npsn VARCHAR(20) NOT NULL UNIQUE,
    nama_sekolah VARCHAR(150) NOT NULL,
    kapanewon VARCHAR(100) NOT NULL,
    latitude DECIMAL(10, 7) NOT NULL,
    longitude DECIMAL(10, 7) NOT NULL,
    CONSTRAINT chk_sekolah_latitude CHECK (latitude BETWEEN -90 AND 90),
    CONSTRAINT chk_sekolah_longitude CHECK (longitude BETWEEN -180 AND 180)
) ENGINE=InnoDB;

CREATE TABLE pendaftar (
    nik CHAR(16) PRIMARY KEY,
    nomor_kk CHAR(16) NOT NULL,
    nama_lengkap VARCHAR(150) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    tanggal_daftar DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE kuota_jalur (
    kuota_id INT AUTO_INCREMENT PRIMARY KEY,
    sekolah_id INT NOT NULL,
    jalur_pendaftaran VARCHAR(50) NOT NULL,
    jumlah_kuota INT NOT NULL DEFAULT 0,
    CONSTRAINT uq_kuota_sekolah_jalur UNIQUE (sekolah_id, jalur_pendaftaran),
    CONSTRAINT chk_kuota_nonneg CHECK (jumlah_kuota >= 0),
    CONSTRAINT chk_jalur_pendaftaran CHECK (
        jalur_pendaftaran IN ('Zonasi', 'Afirmasi', 'Prestasi', 'Perpindahan Orang Tua')
    ),
    CONSTRAINT fk_kuota_jalur_sekolah
        FOREIGN KEY (sekolah_id) REFERENCES sekolah(sekolah_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE operator (
    operator_id INT AUTO_INCREMENT PRIMARY KEY,
    sekolah_id INT NULL,
    nama_operator VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    role VARCHAR(30) NOT NULL,
    CONSTRAINT chk_operator_role CHECK (role IN ('operator_sekolah', 'admin_dinas')),
    CONSTRAINT fk_operator_sekolah
        FOREIGN KEY (sekolah_id) REFERENCES sekolah(sekolah_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE pendaftaran (
    pendaftaran_id INT AUTO_INCREMENT PRIMARY KEY,
    nik CHAR(16) NOT NULL UNIQUE,
    sekolah_id INT NOT NULL,
    jalur_pendaftaran VARCHAR(50) NOT NULL,
    lat_domisili DECIMAL(10, 7) NOT NULL,
    long_domisili DECIMAL(10, 7) NOT NULL,
    status_berkas VARCHAR(30) NOT NULL DEFAULT 'Dalam Verifikasi',
    status_seleksi VARCHAR(30) NOT NULL DEFAULT 'Proses',
    waktu_daftar DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_domisili_latitude CHECK (lat_domisili BETWEEN -90 AND 90),
    CONSTRAINT chk_domisili_longitude CHECK (long_domisili BETWEEN -180 AND 180),
    CONSTRAINT fk_pendaftaran_pendaftar
        FOREIGN KEY (nik) REFERENCES pendaftar(nik)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_pendaftaran_sekolah
        FOREIGN KEY (sekolah_id) REFERENCES sekolah(sekolah_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE dokumen_persyaratan (
    dokumen_id INT AUTO_INCREMENT PRIMARY KEY,
    pendaftaran_id INT NOT NULL,
    jenis_dokumen VARCHAR(100) NOT NULL,
    file_path VARCHAR(255) NOT NULL,
    waktu_unggah DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_dokumen_pendaftaran
        FOREIGN KEY (pendaftaran_id) REFERENCES pendaftaran(pendaftaran_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE verifikasi_kk (
    verifikasi_id INT AUTO_INCREMENT PRIMARY KEY,
    pendaftaran_id INT NOT NULL UNIQUE,
    operator_id INT NOT NULL,
    nik_kepala_keluarga CHAR(16) NOT NULL,
    status_hierarki_kk VARCHAR(50) NOT NULL,
    catatan_verifikasi TEXT NULL,
    waktu_verifikasi DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_verifikasi_pendaftaran
        FOREIGN KEY (pendaftaran_id) REFERENCES pendaftaran(pendaftaran_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_verifikasi_operator
        FOREIGN KEY (operator_id) REFERENCES operator(operator_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;