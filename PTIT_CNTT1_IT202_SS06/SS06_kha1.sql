create database SS06_kha1;
use SS06_kha1;

create table customers (
    customer_id int primary key,
    full_name varchar(255),
    city varchar(255)
);

create table orders (
    order_id int primary key,
    customer_id int,
    order_date date,
    status enum('pending', 'completed', 'cancelled'),
    foreign key (customer_id) references customers(customer_id)
);

insert into customers (customer_id, full_name, city) values
(1, 'Nguyễn Văn An', 'Hà Nội'),
(2, 'Trần Thị Bình', 'Hồ Chí Minh'),
(3, 'Lê Văn Cường', 'Đà Nẵng'),
(4, 'Phạm Thị Dung', 'Hà Nội'),
(5, 'Hoàng Văn Em', 'Cần Thơ');

insert into orders (order_id, customer_id, order_date, status) values
(101, 1, '2025-01-01', 'completed'),
(102, 1, '2025-01-05', 'pending'),
(103, 2, '2025-01-03', 'completed'),
(104, 3, '2025-01-10', 'cancelled'),
(105, 2, '2025-01-12', 'pending');

select o.order_id, c.full_name, o.order_date, o.status from orders o
inner join customers c on o.customer_id = c.customer_id;

select c.customer_id, c.full_name, count(o.order_id) as total_orders from customers c
left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.full_name;

select distinct c.customer_id, c.full_name from customers c
inner join orders o on c.customer_id = o.customer_id;


