create database SS05_xuatsac2;
use SS05_xuatsac2;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT,
    sold_quantity INT DEFAULT 0,
    status ENUM('active', 'inactive') NOT NULL
);

INSERT INTO products (product_id, product_name, price, stock, sold_quantity, status) VALUES
(1, 'Laptop Dell', 2500000, 10, 120, 'active'),
(2, 'Laptop HP', 3000000, 8, 90, 'active'),
(3, 'Chuột Logitech', 500000, 50, 300, 'active'),
(4, 'Bàn phím cơ', 1200000, 30, 220, 'active'),
(5, 'Tai nghe Bluetooth', 1800000, 25, 180, 'active'),
(6, 'Màn hình Samsung', 3500000, 15, 160, 'active'),
(7, 'SSD 512GB', 2800000, 20, 140, 'active'),
(8, 'RAM 16GB', 2000000, 40, 200, 'active'),
(9, 'USB 64GB', 300000, 100, 400, 'active'),
(10, 'Chuột không dây', 1500000, 60, 270, 'active'),
(11, 'Webcam', 2200000, 22, 110, 'active'),
(12, 'Loa Bluetooth', 1700000, 18, 190, 'active'),
(13, 'Bàn làm việc', 2900000, 12, 80, 'inactive'),
(14, 'Ghế gaming', 2600000, 14, 150, 'active'),
(15, 'Tai nghe gaming', 1400000, 28, 210, 'active');


-- 🔹 TRANG 1
SELECT *
FROM products
WHERE status = 'active'
AND price BETWEEN 1000000 AND 3000000
ORDER BY price ASC
LIMIT 10 OFFSET 0;

-- 🔹 TRANG 2
SELECT *
FROM products
WHERE status = 'active'
AND price BETWEEN 1000000 AND 3000000
ORDER BY price ASC
LIMIT 10 OFFSET 10;