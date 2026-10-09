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