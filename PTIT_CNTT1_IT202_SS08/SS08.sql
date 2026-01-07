create database SS08;
use SS08;

create table customers (
    customer_id int auto_increment primary key,
    customer_name varchar(100) not null,
    email varchar(100) not null unique,
    phone varchar(10) not null unique,
    password varchar(255) not null,
    created_at datetime default current_timestamp
);

create table categories (
    category_id int auto_increment primary key,
    category_name varchar(255) not null unique
);

create table products (
    product_id int auto_increment primary key,
    product_name varchar(255) not null unique,
    price decimal(10,2) not null check (price > 0),
    category_id int not null,
    foreign key (category_id) references categories(category_id)
);

create table orders (
    order_id int auto_increment primary key,
    customer_id int not null,
    order_date datetime default current_timestamp,
    status enum('Pending', 'Completed', 'Cancel') default 'Pending',
    foreign key (customer_id) references customers(customer_id)
);

create table order_items (
    order_item_id int auto_increment primary key,
    order_id int not null,
    product_id int not null,
    quantity int not null check (quantity > 0),
    foreign key (order_id) references orders(order_id),
    foreign key (product_id) references products(product_id)
);

insert into customers (customer_name, email, phone, password) values
('Nguyen Van A', 'a@gmail.com', '0900000001', '123456'),
('Tran Thi B', 'b@gmail.com', '0900000002', '123456'),
('Le Van C', 'c@gmail.com', '0900000003', '123456'),
('Pham Thi D', 'd@gmail.com', '0900000004', '123456'),
('Hoang Van E', 'e@gmail.com', '0900000005', '123456');

insert into categories (category_name) values
('Điện thoại'),
('Laptop'),
('Phụ kiện');

insert into products (product_name, price, category_id) values
('iPhone 15', 25000000, 1),
('Samsung S23', 20000000, 1),
('MacBook Air M2', 28000000, 2),
('Dell XPS 13', 30000000, 2),
('Tai nghe Bluetooth', 1500000, 3),
('Chuột không dây', 800000, 3);

insert into orders (customer_id, status) values
(1, 'Completed'),
(1, 'Completed'),
(2, 'Pending'),
(3, 'Completed'),
(4, 'Cancel'),
(2, 'Completed');

insert into order_items (order_id, product_id, quantity) values
(1, 1, 1),
(1, 5, 2),
(2, 2, 1),
(2, 6, 1),
(3, 3, 1),
(4, 4, 1),
(5, 6, 3),
(6, 1, 1),
(6, 3, 1);


-- Danh sách tất cả danh mục
select * from categories;

-- Danh sách đơn hàng COMPLETED
select * from orders where status = 'Completed';

-- Danh sách sản phẩm sắp xếp giá giảm dần
select * from products order by price desc;

--  5 sản phẩm giá cao nhất, bỏ qua 2 sản phẩm đầu
select * from products order by price desc limit 5 offset 2;



-- Sản phẩm kèm tên danh mục
select p.product_id, p.product_name, p.price, c.category_name
from products p join categories c on p.category_id = c.category_id;

-- Danh sách đơn hàng kèm tên khách
select o.order_id, o.order_date, c.customer_name, o.status
from orders o join customers c on o.customer_id = c.customer_id;

-- Tổng số lượng sản phẩm trong từng đơn hàng
select o.order_id, sum(oi.quantity) total_quantity
from orders o join order_items oi on o.order_id = oi.order_id
group by o.order_id;

-- Thống kê số đơn hàng của mỗi khách
select c.customer_id, c.customer_name, count(o.order_id) total_orders
from customers c left join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name;

--  Khách hàng có tổng số đơn hàng ≥ 2
select c.customer_id, c.customer_name, count(o.order_id) total_orders
from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name
having count(o.order_id) >= 2;

-- B6. Giá trung bình, thấp nhất, cao nhất theo danh mục
select c.category_name, avg(p.price) avg_price, min(p.price) min_price, max(p.price) max_price
from categories c join products p on c.category_id = p.category_id
group by c.category_name;



--  Sản phẩm có giá > giá trung bình tất cả sản phẩm
select * from products
where price > (select avg(price) from products);

--  Khách hàng đã từng đặt ít nhất 1 đơn
select * from customers
where customer_id in (select distinct customer_id from orders);

-- Đơn hàng có tổng số lượng sản phẩm lớn nhất
select order_id, sum(quantity) total_quantity
from order_items
group by order_id
having total_quantity = (
    select max(t.total_qty) from (
        select sum(quantity) total_qty from order_items group by order_id
    ) t
);

-- Khách mua sản phẩm thuộc danh mục có giá trung bình cao nhất
select distinct c.customer_name
from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
join products p on oi.product_id = p.product_id
where p.category_id = (
    select category_id from products
    group by category_id
    order by avg(price) desc
    limit 1
);

-- Từ bảng tạm: tổng số lượng sản phẩm mỗi khách đã mua
select t.customer_id, c.customer_name, sum(t.total_qty) total_quantity
from (
    select o.customer_id, sum(oi.quantity) total_qty
    from orders o join order_items oi on o.order_id = oi.order_id
    group by o.customer_id
) t join customers c on t.customer_id = c.customer_id
group by t.customer_id, c.customer_name;

-- Sản phẩm có giá cao nhất (subquery trả về 1 giá trị)
select * from products
where price = (select max(price) from products);
