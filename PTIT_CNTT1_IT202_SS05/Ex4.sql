create database SS05_gioi2;
use SS05_gioi2;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock INT,
    sold_quantity INT DEFAULT 0,
    status ENUM('active', 'inactive')
);

INSERT INTO products (product_id, product_name, price, stock, sold_quantity, status) VALUES
(1, 'Laptop Dell', 15000000, 10, 120, 'active'),
(2, 'Laptop HP', 14000000, 8, 95, 'active'),
(3, 'Chuột Logitech', 500000, 50, 300, 'active'),
(4, 'Bàn phím cơ', 1200000, 30, 220, 'active'),
(5, 'Tai nghe Bluetooth', 800000, 25, 180, 'active'),
(6, 'Màn hình Samsung', 3000000, 15, 160, 'active'),
(7, 'SSD 1TB', 2500000, 20, 140, 'active'),
(8, 'RAM 16GB', 1800000, 40, 200, 'active'),
(9, 'USB 64GB', 300000, 100, 400, 'active'),
(10, 'Chuột không dây', 450000, 60, 270, 'active'),
(11, 'Webcam', 900000, 22, 110, 'active'),
(12, 'Loa Bluetooth', 1300000, 18, 190, 'active');


SELECT * FROM products ORDER BY sold_quantity DESC LIMIT 10;
SELECT * FROM products ORDER BY sold_quantity DESC LIMIT 5 OFFSET 10;
SELECT * FROM products WHERE price < 2000000 ORDER BY sold_quantity DESC;
