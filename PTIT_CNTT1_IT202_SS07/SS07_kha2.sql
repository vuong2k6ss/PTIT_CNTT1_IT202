create database SS07_kha2;
use SS07_kha2;

create table products (
    id int primary key,
    name varchar(255),
    price decimal(10,2)
);

create table order_items (
    order_id int,
    product_id int,
    quantity int
);

insert into products (id, name, price) values
(1, 'Laptop', 15000000),
(2, 'Chuột', 300000),
(3, 'Bàn phím', 800000),
(4, 'Tai nghe', 1200000),
(5, 'Màn hình', 5000000),
(6, 'USB', 200000),
(7, 'Webcam', 900000);

insert into order_items (order_id, product_id, quantity) values
(101, 1, 1),
(101, 2, 2),
(102, 3, 1),
(103, 1, 1),
(103, 5, 1),
(104, 4, 2),
(105, 2, 3);


select id,name,price from products where id in (select product_id from order_items);