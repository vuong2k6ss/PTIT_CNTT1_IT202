drop database if exists ss13_ex3;
create database ss13_ex3;
use ss13_ex3;

create table users (
    user_id int primary key auto_increment,
    username varchar(50) unique not null,
    email varchar(100) unique not null,
    created_at date,
    follower_count int default 0,
    post_count int default 0
);

create table posts (
    post_id int primary key auto_increment,
    user_id int,
    content text,
    created_at datetime,
    like_count int default 0,
    foreign key (user_id) references users(user_id) on delete cascade
);

create table likes (
    like_id int primary key auto_increment,
    user_id int,
    post_id int,
    liked_at datetime default current_timestamp,
    foreign key (user_id) references users(user_id) on delete cascade,
    foreign key (post_id) references posts(post_id) on delete cascade
);

insert into users (username, email, created_at) values
('alice', 'alice@example.com', '2025-01-01'),
('bob', 'bob@example.com', '2025-01-02'),
('charlie', 'charlie@example.com', '2025-01-03');

insert into posts (user_id, content, created_at) values
(1, 'Hello world from Alice!', '2025-01-10 10:00:00'),
(1, 'Second post by Alice', '2025-01-10 12:00:00'),
(2, 'Bob first post', '2025-01-11 09:00:00'),
(3, 'Charlie sharing thoughts', '2025-01-12 15:00:00');

delimiter //
-- Trigger quản lý post_count (Khi thêm/xóa bài viết)
create trigger after_post_insert after insert on posts for each row
begin
    update users set post_count = post_count + 1 where user_id = new.user_id;
end //

create trigger after_post_delete after delete on posts for each row
begin
    update users set post_count = post_count - 1 where user_id = old.user_id;
end //

-- BEFORE INSERT: Chặn không cho tự like bài của mình
create trigger before_like_insert before insert on likes for each row
begin
    declare owner_id int;
    select user_id into owner_id from posts where post_id = new.post_id;
    if (new.user_id = owner_id) then
	signal sqlstate '45000' set message_text = 'Lỗi: Không thể tự thích bài viết của chính mình!';
    end if;
end //

-- AFTER INSERT/DELETE/UPDATE: Cập nhật like_count trong posts
create trigger after_like_insert after insert on likes for each row
begin
    update posts set like_count = like_count + 1 where post_id = new.post_id;
end //

create trigger after_like_delete after delete on likes for each row
begin
    update posts set like_count = like_count - 1 where post_id = old.post_id;
end //

create trigger after_like_update after update on likes for each row
begin
    if (old.post_id <> new.post_id) then
	update posts set like_count = like_count - 1 where post_id = old.post_id;
	update posts set like_count = like_count + 1 where post_id = new.post_id;
    end if;
end //

delimiter ;


-- 4) TẠO VIEW USER_STATISTICS
create view user_statistics as
select u.user_id, u.username, u.post_count, sum(ifnull(p.like_count, 0)) as total_likes from users u
left join posts p on u.user_id = p.user_id
group by u.user_id, u.username, u.post_count;


-- 5) THỰC HIỆN KIỂM THỬ (TEST CASES)
-- A. Thử like bài của chính mình (Alice like bài 1 - của Alice) -> Sẽ báo lỗi
insert into likes (user_id, post_id) values (1, 1); 

-- B. Thêm like hợp lệ
insert into likes (user_id, post_id) values (2, 1); -- Bob like bài Alice
insert into likes (user_id, post_id) values (3, 1); -- Charlie like bài Alice
insert into likes (user_id, post_id, liked_at) values (2, 4, now()); -- Bob like bài Charlie

-- C. Kiểm tra like_count trong bảng posts
select 'Sau khi thêm like' as 'Status';
select * from posts;

-- D. UPDATE một like sang post khác (Chuyển like của Bob từ bài 1 sang bài 3)
update likes set post_id = 3 where user_id = 2 and post_id = 1;

-- E. Xóa một lượt thích (Xóa like của Charlie tại bài 1)
delete from likes where user_id = 3 and post_id = 1;


-- 6) TRUY VẤN KIỂM CHỨNG CUỐI CÙNG
select 'Kết quả kiểm chứng cuối cùng' as 'Status';
select * from user_statistics;