create database ss13_ex5;
use ss13_ex5;

create table users (
    user_id int primary key auto_increment,
    username varchar(50) unique not null,
    email varchar(100) unique not null,
    created_at date,
    follower_count int default 0,
    post_count int default 0
);

-- 2 TẠO TRIGGER BEFORE INSERT TRÊN USERS (KIỂM TRA ĐỊNH DẠNG)
delimiter //
create trigger before_user_insert
before insert on users
for each row
begin
    -- kiểm tra định dạng email (phải có '@' và '.')
    if (new.email not like '%@%.%') then
	signal sqlstate '45000' set message_text = 'lỗi: định dạng email không hợp lệ (thiếu @ hoặc dấu chấm)!';
    end if;
    -- kiểm tra username (chỉ chứa chữ cái, số và dấu gạch dưới)
    -- sử dụng biểu thức chính quy (regexp)
    if (new.username not regexp '^[a-zA-z0-9_]+$') then
	signal sqlstate '45000' set message_text = 'lỗi: username chỉ được chứa chữ cái, số và dấu gạch dưới (_)!';
    end if;
end //

delimiter ;
-- 1 TẠO STORED PROCEDURE ADD_USER
delimiter //
create procedure add_user(in p_username varchar(50),in p_email varchar(100),in p_created_at date)
begin
    -- procedure thực hiện lệnh insert, trigger sẽ tự động được gọi
    insert into users (username, email, created_at) values (p_username, p_email, p_created_at);
end //
delimiter ;


-- 3 GỌI PROCEDURE ĐỂ KIỂM THỬ
-- a. kiểm thử dữ liệu hợp lệ
call add_user('alice_99', 'alice@gmail.com', '2025-01-01');
call add_user('bob_smith', 'bob.work@company.org', '2025-01-02');

-- b. kiểm thử email không hợp lệ (thiếu dấu chấm) -> sẽ báo lỗi
call add_user('charlie', 'charlie@gmail', '2025-01-03');

-- c. kiểm thử username không hợp lệ (chứa ký tự đặc biệt !) -> sẽ báo lỗi
call add_user('bad!user', 'bad@gmail.com', '2025-01-03');


-- 4  KẾT QUẢ
select * from users;