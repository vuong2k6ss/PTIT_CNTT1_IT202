drop database SS14_kha1;
create database SS14_kha1;
use SS14_kha1;

create table users (
    user_id int primary key auto_increment,
    username varchar(50) not null,
    posts_count int default 0
);

create table posts (
    post_id int primary key auto_increment,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    constraint fk_posts_user
	foreign key (user_id) references users(user_id)
);


insert into users (username) values
('alice'),
('bob');

-- 5. transaction - trường hợp thành công (commit)
start transaction;
insert into posts (user_id, content) values (1, 'bài viết đầu tiên của alice');

update users set posts_count = posts_count + 1 where user_id = 1;
commit;


-- 6. kiểm tra sau commit
select * from users;
select * from posts;


-- 7. transaction - trường hợp gây lỗi (rollback)
-- user_id = 999 không tồn tại
start transaction;

insert into posts (user_id, content) values (999, 'bài viết lỗi do user không tồn tại');
update users set posts_count = posts_count + 1 where user_id = 999;
rollback;

-- 8. kiểm tra sau rollback
select * from users;
select * from posts;
