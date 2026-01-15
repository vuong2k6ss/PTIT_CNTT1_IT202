drop database SS14_gioi2;
create database SS14_gioi2;
use SS14_gioi2;

create table users (
    user_id int primary key auto_increment,
    username varchar(50) not null
);

create table posts (
    post_id int primary key auto_increment,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    comments_count int default 0,
    foreign key (user_id) references users(user_id)
);

create table comments (
    comment_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id)
);

insert into users (username) values
('alice'),
('bob');

insert into posts (user_id, content) values
(1, 'bài viết của alice');

delimiter //

create procedure sp_post_comment (in p_post_id int,in p_user_id int,in p_content text)
begin
    start transaction;
-- bước 1: insert bình luận
    insert into comments (post_id, user_id, content) values (p_post_id, p_user_id, p_content);

-- tạo savepoint sau khi insert comment
    savepoint after_insert;

-- bước 2: update comments_count(có thể gây lỗi trong test)
    update posts set comments_count = comments_count + 1 where post_id = p_post_id;

    commit;
end //

delimiter ;

-- 7. test case 1: thành công (commit)
call sp_post_comment(1, 2, 'bình luận đầu tiên của bob');

-- kiểm tra sau commit
select * from posts;
select * from comments;


-- 8. test case 2: gây lỗi ở bước update
-- giả sử post_id = 999 không tồn tại
-- update không tác động dòng nào → mô phỏng lỗi logic
delimiter //

create procedure sp_post_comment_fail (in p_post_id int,in p_user_id int,in p_content text)
begin
    start transaction;
    insert into comments (post_id, user_id, content) values (p_post_id, p_user_id, p_content);

    savepoint after_insert;
    -- update gây lỗi (post không tồn tại)
    update posts set comments_count = comments_count + 1 where post_id = 999;

    -- rollback partial về savepoint
    rollback to after_insert;

    commit;
end //

delimiter ;

-- gọi procedure lỗi
call sp_post_comment_fail(1, 2, 'bình luận sẽ bị rollback phần update');

-- 9. kiểm tra kết quả cuối
select * from posts;
select * from comments;
