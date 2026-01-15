drop database SS14_kha2;
create database SS14_kha2;
use SS14_kha2;

create table users (
    user_id int primary key auto_increment,
    username varchar(50) not null
);

create table posts (
    post_id int primary key auto_increment,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    likes_count int default 0,
	foreign key (user_id) references users(user_id)
);

create table likes (
    like_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
	foreign key (post_id) references posts(post_id),
	foreign key (user_id) references users(user_id),
    constraint unique_like unique (post_id, user_id)
);

insert into users (username) values
('alice'),
('bob');

insert into posts (user_id, content) values
(1, 'bài viết của alice'),
(2, 'bài viết của bob');


-- 6. test 1: like lần đầu (commit)
-- bob like bài của alice
start transaction;
insert into likes (post_id, user_id) values (1, 2);
update posts set likes_count = likes_count + 1 where post_id = 1;
commit;

-- kiểm tra sau commit
select * from posts;
select * from likes;

-- 7. test 2: like trùng (rollback)
-- bob like lại bài của alice → vi phạm unique
start transaction;
insert into likes (post_id, user_id) values (1, 2);  -- lỗi unique (post_id, user_id)
update posts set likes_count = likes_count + 1 where post_id = 1;
rollback;


-- 8. kiểm tra sau rollback
select * from posts;
select * from likes;
