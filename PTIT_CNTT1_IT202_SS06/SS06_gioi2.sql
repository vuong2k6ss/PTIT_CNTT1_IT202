create database SS06_gioi2;
use SS06_gioi2;

create table orders (
    order_id int primary key
);

create table products (
    product_id int primary key,
    product_name varchar(255),
    price decimal(10,2)
);

create table order_items (
    order_id int,
    product_id int,
    quantity int,
    primary key (order_id, product_id),
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

insert into orders (order_id) values
(101),
(102),
(103),
(104),
(105);

insert into products (product_id, product_name, price) values
(1, 'Laptop', 15000000),
(2, 'Chuột', 300000),
(3, 'Bàn phím', 800000),
(4, 'Tai nghe', 1200000),
(5, 'Màn hình', 5000000);


insert into order_items (order_id, product_id, quantity) values
(101, 1, 1),
(101, 2, 2),
(102, 3, 1),
(103, 1, 1),
(103, 5, 1),
(104, 4, 2),
(105, 2, 3),
(105, 3, 2);


select p.product_id, p.product_name, sum(oi.quantity) as total_quantity_sold from products p
inner join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name;


select p.product_id, p.product_name, sum(oi.quantity * p.price) as total_revenue, avg(oi.quantity * p.price) as avg_revenue_per_order from products p
inner join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name;


select p.product_id, p.product_name, sum(oi.quantity * p.price) as total_revenue from products p
inner join order_items oi on p.product_id = oi.product_id
group by p.product_id, p.product_name
having sum(oi.quantity * p.price) > 5000000;
