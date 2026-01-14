create database ss13_ex4;
use ss13_ex4;

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

-- yêu cầu 1: tạo bảng post_history
create table post_history (
    history_id int primary key auto_increment,
    post_id int,
    old_content text,
    new_content text,
    changed_at datetime,
    changed_by_user_id int,
    foreign key (post_id) references posts(post_id) on delete cascade
);

-- ======================================================
-- 2) THÊM DỮ LIỆU MẪU
-- ======================================================
insert into users (username, email, created_at) values
('alice', 'alice@example.com', '2025-01-01'),
('bob', 'bob@example.com', '2025-01-02'),
('charlie', 'charlie@example.com', '2025-01-03');

insert into posts (user_id, content, created_at) values
(1, 'nội dung gốc của alice', '2025-01-10 10:00:00'),
(2, 'nội dung gốc của bob', '2025-01-11 09:00:00'),
(3, 'nội dung gốc của charlie', '2025-01-12 15:00:00');

-- thêm like để kiểm chứng ở bước 5
insert into likes (user_id, post_id) values (2, 1), (3, 1);


-- 3) TẠO TRIGGER 
delimiter //
-- trigger before update trên posts (yêu cầu 3)
create trigger before_post_update
before update on posts
for each row
begin
    if old.content <> new.content then
	insert into post_history (post_id, old_content, new_content, changed_at, changed_by_user_id)
	values (old.post_id, old.content, new.content, now(), old.user_id);
    end if;
end //

-- trigger after delete trên posts (yêu cầu 3)
-- sử dụng cascade đã định nghĩa ở bảng post_history và likes nên không cần viết thêm logic xóa thủ công
create trigger after_post_delete
after delete on posts
for each row
begin
    update users set post_count = post_count - 1 where user_id = old.user_id;
end //

-- các trigger phụ trợ để đảm bảo tính toàn vẹn (post_count và like_count)
create trigger after_post_insert after insert on posts for each row
begin
    update users set post_count = post_count + 1 where user_id = new.user_id;
end //

create trigger after_like_insert after insert on likes for each row
begin
    update posts set like_count = like_count + 1 where post_id = new.post_id;
end //

create trigger after_like_delete after delete on likes for each row
begin
    update posts set like_count = like_count - 1 where post_id = old.post_id;
end //

delimiter ;
-- 4) THỰC HIỆN UPDATE VÀ KIỂM TRA LỊCH SỬ (Yêu cầu 4)

-- cập nhật nội dung bài đăng
update posts set content = 'nội dung alice đã chỉnh sửa' where post_id = 1;
update posts set content = 'charlie cập nhật bài viết lần 1' where post_id = 3;

-- xem lịch sử chỉnh sửa
select * from post_history;


-- 5) KIỂM TRA KẾT HỢP (Yêu cầu 5)
-- kiểm tra: update content nhưng like_count bài 1 vẫn phải giữ nguyên là 2
select 'kiểm tra like_count sau khi update content' as status;
select post_id, content, like_count from posts where post_id = 1;

-- thử thêm/xóa like để chắc chắn trigger like_count vẫn chạy tốt
insert into likes (user_id, post_id) values (1, 3);
delete from likes where user_id = 2 and post_id = 1;

-- hiển thị kết quả cuối cùng để đối chiếu
select 'kết quả bảng posts cuối cùng' as status;
select * from posts;
