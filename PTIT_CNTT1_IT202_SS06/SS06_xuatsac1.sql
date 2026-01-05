create database SS06_xuatsac1;
use SS06_xuatsac1;

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
    total_amount decimal(10,2),
    foreign key (customer_id) references customers(customer_id)
);


insert into customers (customer_id, full_name, city) values
(1, 'Nguyễn Văn An', 'Hà Nội'),
(2, 'Trần Thị Bình', 'Hồ Chí Minh'),
(3, 'Lê Văn Cường', 'Đà Nẵng'),
(4, 'Phạm Thị Dung', 'Hà Nội'),
(5, 'Hoàng Văn Em', 'Cần Thơ');

insert into orders (order_id, customer_id, order_date, status, total_amount) values
(101, 1, '2025-01-01', 'completed', 3000000),
(102, 1, '2025-01-05', 'completed', 4500000),
(103, 1, '2025-01-10', 'completed', 3500000),
(104, 2, '2025-01-03', 'completed', 2000000),
(105, 2, '2025-01-12', 'completed', 1800000),
(106, 3, '2025-01-08', 'completed', 5000000),
(107, 3, '2025-01-15', 'completed', 4200000),
(108, 3, '2025-01-20', 'completed', 3000000),
(109, 4, '2025-01-18', 'pending',   7000000),
(110, 5, '2025-01-22', 'completed', 1500000);


select c.customer_id, c.full_name, count(o.order_id) as total_orders, sum(o.total_amount) as total_spent, avg(o.total_amount) as avg_order_value  from customers c
inner join orders o on c.customer_id = o.customer_id
where o.status = 'completed'
group by c.customer_id, c.full_name
having count(o.order_id) >= 3
and sum(o.total_amount) > 10000000
order by total_spent desc;