create database SS05_kha2;
use SS05_kha2;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    city VARCHAR(255),
    status ENUM('active', 'inactive') NOT NULL
);

INSERT INTO customers (customer_id, full_name, email, city, status) VALUES
(1, 'Nguyễn Văn An', 'an@gmail.com', 'Hà Nội', 'active'),
(2, 'Trần Thị Bình', 'binh@gmail.com', 'TP.HCM', 'inactive'),
(3, 'Lê Văn Cường', 'cuong@gmail.com', 'Hà Nội', 'active'),
(4, 'Phạm Thị Dung', 'dung@gmail.com', 'TP.HCM', 'active'),
(5, 'Hoàng Văn Em', 'em@gmail.com', 'Đà Nẵng', 'inactive');

SELECT * FROM customers;
SELECT * FROM customers WHERE city = 'TP.HCM';
SELECT * FROM customers WHERE status = 'active' AND city = 'Hà Nội';
SELECT * FROM customers ORDER BY full_name ASC;
