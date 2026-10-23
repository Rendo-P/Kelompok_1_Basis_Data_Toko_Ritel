-- Pertemuan 1
SHOW DATABASES;

-- Pertemuan 2
SELECT * FROM produk;

SELECT * FROM kategori;

SELECT * FROM supplier;

SELECT * FROM supplier WHERE kontak = 'Dwi';

SELECT * FROM produk WHERE stok_minimum < 30;

-- Pertemuan 3
SELECT COUNT(*) AS jumlah_produk
FROM produk;

SELECT SUM(harga_beli * stok_aktual) AS total_nilai_stok
FROM produk;

SELECT AVG(harga_jual) AS rata_rata_harga_jual
FROM produk;

SELECT
    MIN(harga_beli) AS harga_beli_minimum,
    MAX(harga_beli) AS harga_beli_maksimum
FROM produk;

SELECT id_kategori, COUNT(*) AS jumlah_produk
FROM produk
GROUP BY id_kategori;

SELECT id_kategori, COUNT(*) AS jumlah_produk
FROM produk
GROUP BY id_kategori
HAVING COUNT(*) >= 1;

SELECT nama_produk, harga_jual
FROM produk
ORDER BY harga_jual DESC;

-- Pertemuan 4
SELECT p.nama_produk, k.nama_kategori 
FROM produk p 
JOIN kategori k ON p.id_kategori = k.id_kategori;

SELECT nama_produk, nama_kategori 
FROM produk 
JOIN kategori USING (id_kategori);

SELECT s.nama_supplier, t.id_transaksi, t.jumlah
FROM supplier s 
LEFT JOIN transaksi_stok t ON s.id_supplier = t.id_supplier;

SELECT * FROM v_katalog_produk;
CALL tambah_stok_masuk(1, 101, 20);
SELECT nama_produk, stok_aktual FROM produk WHERE id_produk = 101;

---pertemuan 7
START TRANSACTION;

INSERT INTO penjualan (id_penjualan, id_pelanggan) VALUES (3, 1);
INSERT INTO detail_penjualan (id_penjualan, id_produk, kuantitas, harga_satuan) VALUES (3, 103, 5, 4500);

-- Jika instruksi berhasil, terapkan ke database (Commit):
COMMIT;