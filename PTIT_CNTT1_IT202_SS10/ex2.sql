USE social_network_pro;

-- 2.Tạo view view_user_post
create view view_user_post as
select user_id, count(*) as total_user_post
from posts
group by user_id;

-- 3.Hiển thị lại view để kiểm chứng
select * from view_user_post;

-- 4.Kết hợp view với bảng users
select u.full_name, v.total_user_post
from users u
inner join view_user_post v on u.user_id = v.user_id;
