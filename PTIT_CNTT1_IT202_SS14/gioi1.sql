drop database SS14_gioi1;
create database SS14_gioi1;
use SS14_gioi1;

create table users (
    user_id int primary key auto_increment,
    username varchar(50) not null,
    following_count int default 0,   -- số người user đang follow
    followers_count int default 0    -- số người đang follow user
);

create table followers (
    follower_id int not null,
    followed_id int not null,
    primary key (follower_id, followed_id),
    foreign key (follower_id) references users(user_id),
    foreign key (followed_id) references users(user_id)
);


create table follow_log (
    log_id int primary key auto_increment,
    follower_id int,
    followed_id int,
    error_message varchar(255),
    created_at datetime default current_timestamp
);

insert into users (username) values
('alice'),
('bob'),
('charlie');

-- 6. tạo stored procedure sp_follow_user
-- xử lý follow bằng transaction
delimiter //
create procedure sp_follow_user (in p_follower_id int,in p_followed_id int)
begin
-- biến kiểm tra tồn tại user
    declare follower_exists int;
    declare followed_exists int;
    declare already_followed int;

    start transaction;
-- kiểm tra user follower có tồn tại không
    select count(*) into follower_exists from users where user_id = p_follower_id;

-- kiểm tra user được follow có tồn tại không
    select count(*) into followed_exists from users where user_id = p_followed_id;

-- nếu 1 trong 2 user không tồn tại → ghi log + rollback
    if follower_exists = 0 or followed_exists = 0 then
	insert into follow_log (follower_id, followed_id, error_message)
	values (p_follower_id, p_followed_id, 'user không tồn tại');

	rollback;
-- kiểm tra không tự follow chính mình
    elseif p_follower_id = p_followed_id then
	rollback;
    else
-- kiểm tra đã follow trước đó chưa
	select count(*) into already_followed from followers where follower_id = p_follower_id and followed_id = p_followed_id;
	if already_followed > 0 then
	rollback;
	else
-- insert quan hệ follow
	insert into followers (follower_id, followed_id) values (p_follower_id, p_followed_id);
-- tăng following_count cho follower
	update users set following_count = following_count + 1
	where user_id = p_follower_id;
-- tăng followers_count cho followed
	update users set followers_count = followers_count + 1
    where user_id = p_followed_id;
    
	commit;
		end if;
    end if;
end //

delimiter ;


-- 7. gọi procedure - các trường hợp test
-- case 1: thành công (alice follow bob)
call sp_follow_user(1, 2);

-- case 2: thất bại - follow trùng
call sp_follow_user(1, 2);

-- case 3: thất bại - tự follow chính mình
call sp_follow_user(1, 1);

-- case 4: thất bại - user không tồn tại
call sp_follow_user(1, 999);


-- 8. kiểm tra kết quả
select * from users;
select * from followers;
select * from follow_log;
