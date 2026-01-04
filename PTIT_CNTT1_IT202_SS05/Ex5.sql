create database SS05_xuatsac1;
use SS05_xuatsac1;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    total_amount DECIMAL(10,2),
    order_date DATE,
    status ENUM('pending', 'completed', 'cancelled')
);

INSERT INTO orders (order_id, customer_id, total_amount, order_date, status) VALUES
(1, 101, 3000000, '2024-01-01', 'completed'),
(2, 102, 5000000, '2024-01-03', 'pending'),
(3, 103, 7000000, '2024-01-05', 'completed'),
(4, 104, 2000000, '2024-01-07', 'cancelled'),
(5, 105, 9000000, '2024-01-09', 'completed'),
(6, 106, 4000000, '2024-01-11', 'pending'),
(7, 107, 8000000, '2024-01-13', 'completed'),
(8, 108, 6000000, '2024-01-15', 'completed'),
(9, 109, 1000000, '2024-01-17', 'pending'),
(10, 110, 12000000, '2024-01-19', 'completed'),
(11, 111, 3000000, '2024-01-21', 'completed'),
(12, 112, 4500000, '2024-01-23', 'pending'),
(13, 113, 6500000, '2024-01-25', 'completed'),
(14, 114, 2500000, '2024-01-27', 'cancelled'),
(15, 115, 11000000, '2024-01-29', 'completed');


SELECT *
FROM orders
WHERE status != 'cancelled'
ORDER BY order_date DESC
LIMIT 5 OFFSET 0;

SELECT *
FROM orders
WHERE status != 'cancelled'
ORDER BY order_date DESC
LIMIT 5 OFFSET 5;

SELECT *
FROM orders
WHERE status != 'cancelled'
ORDER BY order_date DESC
LIMIT 5 OFFSET 10;
