create database SS05_gioi1;
use SS05_gioi1;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    total_amount DECIMAL(10,2),
    order_date DATE,
    status ENUM('pending', 'completed', 'cancelled')
);

INSERT INTO orders (order_id, customer_id, total_amount, order_date, status) VALUES
(1, 101, 3000000, '2024-01-05', 'completed'),
(2, 102, 7000000, '2024-01-10', 'completed'),
(3, 103, 1500000, '2024-01-15', 'pending'),
(4, 104, 9000000, '2024-02-01', 'completed'),
(5, 105, 2000000, '2024-02-05', 'cancelled'),
(6, 106, 12000000, '2024-02-10', 'completed'),
(7, 107, 4000000, '2024-02-15', 'pending');

SELECT * FROM orders WHERE status = 'completed';
SELECT * FROM orders WHERE total_amount > 5000000;
SELECT * FROM orders ORDER BY order_date DESC LIMIT 5;
SELECT * FROM orders WHERE status = 'completed' ORDER BY total_amount DESC;
