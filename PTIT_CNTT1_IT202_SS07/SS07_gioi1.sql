create database SS07_gioi1;
use SS07_gioi1;

create table orders (
    id int primary key,
    customer_id int,
    order_date date,
    total_amount decimal(10,2)
);

insert into orders (id, customer_id, order_date, total_amount) values
(101, 1, '2025-01-01', 2500000),
(102, 2, '2025-01-03', 1800000),
(103, 3, '2025-01-05', 4200000),
(104, 1, '2025-01-08', 3000000),
(105, 4, '2025-01-10', 5200000),
(106, 5, '2025-01-12', 1500000);

select id, customer_id,order_date,total_amount from orders where total_amount > (select avg(total_amount) from orders);