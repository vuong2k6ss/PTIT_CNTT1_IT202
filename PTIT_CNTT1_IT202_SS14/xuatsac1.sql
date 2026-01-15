drop database SS14_xuatsac1;
create database SS14_xuatsac1;
use SS14_xuatsac1;

create table if not exists users (
    user_id int auto_increment primary key,
    username varchar(50) not null,
    posts_count int default 0
);

create table if not exists posts (
    post_id int auto_increment primary key,
    user_id int not null,
    content text not null,
    comments_count int default 0,
    created_at datetime default current_timestamp,
	foreign key (user_id) references users(user_id)
);

create table if not exists comments (
    comment_id int auto_increment primary key,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
	foreign key (post_id) references posts(post_id),
	foreign key (user_id) references users(user_id)
);

create table if not exists likes (
    like_id int auto_increment primary key,
    post_id int not null,
    user_id int not null,
    created_at datetime default current_timestamp,
	foreign key (post_id) references posts(post_id),
	foreign key (user_id) references users(user_id)
);

create table if not exists delete_log (
    log_id int auto_increment primary key,
    post_id int not null,
    deleted_by int not null,
    deleted_at datetime default current_timestamp
);

insert into users (username, posts_count)
values ('alice', 1), ('bob', 1);

insert into posts (user_id, content)
values (1, 'post cua alice'), (2, 'post cua bob');

insert into comments (post_id, user_id, content)
values (1, 2, 'comment cua bob');

insert into likes (post_id, user_id)
values (1, 2);

-- 7. stored procedure xóa bài viết
delimiter //

create procedure sp_delete_post (
    in p_post_id int,
    in p_user_id int
)
begin
    declare v_owner_id int;

    start transaction;

    -- kiểm tra bài viết có tồn tại và lấy chủ bài viết
    select user_id into v_owner_id
    from posts
    where post_id = p_post_id;

    -- nếu không tồn tại hoặc không phải chủ bài viết
    if v_owner_id is null or v_owner_id <> p_user_id then
        rollback;
    else
        -- xóa likes
        delete from likes where post_id = p_post_id;

        -- xóa comments
        delete from comments where post_id = p_post_id;

        -- xóa bài viết
        delete from posts where post_id = p_post_id;

        -- giảm posts_count của chủ bài viết
        update users
        set posts_count = posts_count - 1
        where user_id = p_user_id;

        -- ghi log
        insert into delete_log (post_id, deleted_by)
        values (p_post_id, p_user_id);

        commit;
    end if;
end //

delimiter ;


-- 8. test procedure
-- hợp lệ (xóa post của alice)
call sp_delete_post(1, 1);

-- không hợp lệ (alice xóa post của bob → rollback)
call sp_delete_post(2, 1);

-- 9. kiểm tra kết quả
select * from users;
select * from posts;
select * from comments;
select * from likes;
select * from delete_log;
