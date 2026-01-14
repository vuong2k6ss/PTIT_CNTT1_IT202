drop database SS12;
create database SS12;
use SS12;

create table users (
    user_id int auto_increment primary key,
    username varchar(50) not null unique,
    password varchar(255) not null,
    email varchar(100) not null unique,
    created_at datetime default current_timestamp
);

create table posts (
    post_id int auto_increment primary key,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (user_id) references users(user_id)
);

create table comments (
    comment_id int auto_increment primary key,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime default current_timestamp,
    foreign key (post_id) references posts(post_id),
    foreign key (user_id) references users(user_id)
);

create table friends (
    user_id int not null,
    friend_id int not null,
    status varchar(20) check (status in ('pending', 'accepted')),
    foreign key (user_id) references users(user_id),
    foreign key (friend_id) references users(user_id)
);

create table likes (
    user_id int not null,
    post_id int not null,
    foreign key (user_id) references users(user_id),
    foreign key (post_id) references posts(post_id)
);


insert into users (username, password, email) values
('nguyenvana', '123456', 'vana@gmail.com'),
('tranthib', 'abcdef', 'b@gmail.com'),
('leminhc', 'password', 'c@gmail.com');

insert into posts (user_id, content) values
(1, 'bai viet dau tien'),
(2, 'xin chao moi nguoi');

insert into comments (post_id, user_id, content) values
(1, 2, 'bai viet hay'),
(1, 3, 'toi dong y');

insert into friends (user_id, friend_id, status) values
(1, 2, 'pending'),
(2, 1, 'accepted');

insert into likes (user_id, post_id) values
(2, 1),
(3, 1);



-- bài 1 
select user_id, username, email, created_at from users;


-- bai 2: hien thi thong tin cong khai 
create view vw_public_users as select user_id, username, created_at from users;

-- select tu view
select * from vw_public_users;

-- select truc tiep tu bang users
select user_id, username, created_at from users;



-- bai 3: toi uu tim kiem nguoi dung (index)
create index idx_users_username on users(username);

-- tim kiem nguoi dung theo username
select * from users where username = 'nguyenvana';



-- bai 4: dang bai viet (stored procedure)
delimiter $$
create procedure sp_create_post (in p_user_id int,in p_content text)
begin
    if exists (select 1 from users where user_id = p_user_id) then
	insert into posts (user_id, content) values (p_user_id, p_content);
    else
	signal sqlstate '45000' set message_text = 'user khong ton tai';
    end if;
end$$
delimiter ;

-- goi procedure dang bai
call sp_create_post(1, 'bai viet dau tien');
call sp_create_post(2, 'xin chao moi nguoi');


-- bai 5: news feed view
create view vw_recent_posts as
select post_id, user_id, content, created_at from posts
where created_at >= now() - interval 7 day;

-- hien thi bai viet moi nhat
select * from vw_recent_posts order by created_at desc;



-- bai 6: toi uu truy van bai viet
create index idx_posts_user on posts(user_id);
create index idx_posts_user_created on posts(user_id, created_at);

-- lay bai viet cua 1 user
select * from posts where user_id = 1 order by created_at desc;


-- bai 7: thong ke bai viet
delimiter $$
create procedure sp_count_posts (in p_user_id int,out p_total int)
begin
    select count(*) into p_total from posts where user_id = p_user_id;
end$$
delimiter ;

-- goi procedure thong ke
call sp_count_posts(1, @total_posts);
select @total_posts as total_posts;


-- =====================================
-- bai 8: kiem soat du lieu bang view with check option



-- user duoc coi la hoat dong neu co it nhat 1 bai viet
create view vw_active_users as select u.user_id, u.username, u.created_at from users u
where u.user_id in (select distinct user_id from posts)
with check option;

-- xem danh sach user dang hoat dong
select * from vw_active_users;



-- bai 9: quan ly ket ban bang stored procedure  chuc nang: gui loi moi ket ban


delimiter $$
create procedure sp_add_friend (in p_user_id int,in p_friend_id int)
begin
    -- khong cho ket ban voi chinh minh
    if p_user_id = p_friend_id then
	signal sqlstate '45000' set message_text = 'khong the ket ban voi chinh minh';
    else
	insert into friends (user_id, friend_id, status) values (p_user_id, p_friend_id, 'pending');
    end if;
end$$
delimiter ;

-- goi procedure gui loi moi ket ban
call sp_add_friend(1, 3);



-- bai 10: goi y ban be bang stored procedure nang cao  chuc nang: goi y nguoi dung chua phai ban


delimiter $$
create procedure sp_suggest_friends (in p_user_id int,inout p_limit int)
begin
    declare done int default 0;
    declare v_user_id int;
    -- cursor lay danh sach user khac chua ket ban
    declare cur_users cursor for
	select user_id from users
	where user_id != p_user_id and user_id not in (select friend_id from friends where user_id = p_user_id);
    declare continue handler for not found set done = 1;
    open cur_users;

    suggest_loop: loop
        fetch cur_users into v_user_id;
        if done = 1 then leave suggest_loop;
        end if;
        -- tra ve tung user goi y
        select v_user_id as suggested_friend;
        set p_limit = p_limit - 1;
        if p_limit <= 0 then leave suggest_loop;
        end if;
    end loop;
    close cur_users;
end$$
delimiter ;

-- goi procedure goi y ban be
set @limit = 2;
call sp_suggest_friends(1, @limit);
