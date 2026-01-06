create database SS07_xuatsac1;
use SS07_xuatsac1;

create table customers (
    id int primary key,
    name varchar(255),
    email varchar(255)
);

create table orders (
    id int primary key,
    customer_id int,
    order_date date,
    total_amount decimal(10,2)
);

insert into customers (id, name, email) values
(1, 'Nguyễn Văn An', 'an@gmail.com'),
(2, 'Trần Thị Bình', 'binh@gmail.com'),
(3, 'Lê Văn Cường', 'cuong@gmail.com'),
(4, 'Phạm Thị Dung', 'dung@gmail.com'),
(5, 'Hoàng Văn Em', 'em@gmail.com');

insert into orders (id, customer_id, order_date, total_amount) values
(101, 1, '2025-01-01', 2500000),
(102, 1, '2025-01-05', 1800000),
(103, 2, '2025-01-03', 3200000),
(104, 3, '2025-01-10', 1500000),
(105, 3, '2025-01-15', 2200000),
(106, 1, '2025-01-18', 4000000),
(107, 4, '2025-01-20', 900000),
(108, 5, '2025-01-22', 1200000);

select name, email from customers
where id = (select customer_id from orders group by customer_id
    having sum(total_amount) = (select max(total_spent)
        from (select sum(total_amount) as total_spent from orders group by customer_id) as temp
    )
);