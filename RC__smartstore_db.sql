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