-- Pertemuan 1
CREATE DATABASE smartsore_db;

-- Pertemuan 2
USE smartsore_db;

CREATE TABLE kategori(
    id_kategori INT,
    nama_kategori VARCHAR(100),
    PRIMARY KEY (id_kategori)
);

CREATE TABLE produk(
    id_produk INT,
    nama_produk VARCHAR(100),
    sku VARCHAR(50),
    harga_beli DECIMAL(12,2),
    harga_jual DECIMAL(12,2),
    stok_minimum INT,
    stok_aktual INT,
    id_kategori INT,
    PRIMARY KEY (id_produk),
    FOREIGN KEY (id_kategori) REFERENCES kategori(id_kategori)
);

CREATE TABLE supplier(
    id_supplier INT,
    nama_supplier VARCHAR(100),
    kontak VARCHAR(50),
    telepon VARCHAR(20),
    PRIMARY KEY (id_supplier)
);

CREATE TABLE transaksi_stok(
    id_transaksi INT,
    id_supplier INT,
    id_produk INT,
    tipe_transaksi ENUM('masuk', 'keluar'),
    jumlah INT,
    waktu_transaksi DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_transaksi),
    FOREIGN KEY (id_produk) REFERENCES produk(id_produk),
    FOREIGN KEY (id_supplier) REFERENCES supplier(id_supplier)
);

INSERT INTO kategori (id_kategori, nama_kategori) VALUES
(1, 'Makanan'),
(2, 'Minuman'),
(3, 'Alat Tulis'),
(4, 'Kebersihan');

INSERT INTO supplier (id_supplier, nama_supplier, kontak, telepon) VALUES
(1, 'PT BUDI LUHUR', 'Jerry', '081987123654'),
(2, 'CV ANDRA AMERTA', 'Pratama', '089642143867'),
(3, 'PT YUKTI SAHAKARYA', 'Dwi', '087456372891');

INSERT INTO produk (id_produk, nama_produk, sku, harga_beli, harga_jual, stok_minimum, stok_aktual, id_kategori) VALUES
(101, 'Mie Telur', 'MKN101', 3000, 3500, 30, 65, 1),
(102, 'Teh Josjis', 'MNM102', 4000, 5000, 25, 75, 2),
(103, 'Pulpen Soepir', 'ALT103', 3500, 4500, 45, 65, 3),
(104, 'Pembersih Lantai', 'KBH104', 12000, 18000, 15, 40, 4);

-- Pertemuan 3


-- Kosong

-- Pertemuan 4
-- Menambahkan Batasan Integritas (CHECK dan UNIQUE)[cite: 18]
ALTER TABLE produk ADD CONSTRAINT chk_harga CHECK (harga_jual >= harga_beli);
ALTER TABLE produk ADD CONSTRAINT uq_sku UNIQUE (sku);

-- Membuat Virtual View[cite: 18]
CREATE VIEW v_katalog_produk AS
SELECT p.sku, p.nama_produk, k.nama_kategori, p.stok_aktual, p.harga_jual
FROM produk p
JOIN kategori k ON p.id_kategori = k.id_kategori;

-- Stored Procedure (IN parameter)[cite: 18]
DELIMITER //
CREATE PROCEDURE tambah_stok_masuk(IN p_id_supplier INT, IN p_id_produk INT, IN p_jumlah INT)
BEGIN
    INSERT INTO transaksi_stok (id_supplier, id_produk, tipe_transaksi, jumlah)
    VALUES (p_id_supplier, p_id_produk, 'masuk', p_jumlah);
END //
DELIMITER ;

-- Database Trigger: ROW Trigger[cite: 18]
DELIMITER //
CREATE TRIGGER trg_after_transaksi_stok
AFTER INSERT ON transaksi_stok
FOR EACH ROW
BEGIN
    IF NEW.tipe_transaksi = 'masuk' THEN
        UPDATE produk SET stok_aktual = stok_aktual + NEW.jumlah WHERE id_produk = NEW.id_produk;
    ELSEIF NEW.tipe_transaksi = 'keluar' THEN
        UPDATE produk SET stok_aktual = stok_aktual - NEW.jumlah WHERE id_produk = NEW.id_produk;
    END IF;
END //
DELIMITER ;

-- Pertemuan 5
CREATE TABLE pelanggan (
    id_pelanggan INT PRIMARY KEY,
    nama_pelanggan VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE penjualan (
    id_penjualan INT PRIMARY KEY,
    id_pelanggan INT,
    tanggal_penjualan DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_pelanggan) REFERENCES pelanggan(id_pelanggan)
);

-- Insert Data Dummy Entitas
INSERT INTO pelanggan (id_pelanggan, nama_pelanggan, email) VALUES 
(1, 'Budi Santoso', 'budi@email.com'), 
(2, 'Siti Aminah', 'siti@email.com');

INSERT INTO penjualan (id_penjualan, id_pelanggan) VALUES 
(1, 1), 
(2, 2);

-- Pertemuan 6: Tahapan Normalisasi Data
CREATE TABLE detail_penjualan (
    id_penjualan INT,
    id_produk INT,
    kuantitas INT NOT NULL CHECK (kuantitas > 0),
    harga_satuan DECIMAL(12,2),
    PRIMARY KEY (id_penjualan, id_produk),
    FOREIGN KEY (id_penjualan) REFERENCES penjualan(id_penjualan),
    FOREIGN KEY (id_produk) REFERENCES produk(id_produk)
);

-- Insert Data Hasil Normalisasi
INSERT INTO detail_penjualan (id_penjualan, id_produk, kuantitas, harga_satuan) VALUES 
(1, 101, 2, 3500), 
(1, 102, 1, 5000), 
(2, 104, 1, 18000);