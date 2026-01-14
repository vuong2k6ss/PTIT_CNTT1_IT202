use SS13_ex1;
drop database SS13_ex1;

CREATE TABLE likes (
    like_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    post_id INT,
    liked_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (post_id) REFERENCES posts(post_id) ON DELETE CASCADE
);

INSERT INTO likes (user_id, post_id, liked_at) VALUES
(2, 1, '2025-01-10 11:00:00'),
(3, 1, '2025-01-10 13:00:00'),
(1, 3, '2025-01-11 10:00:00'),
(3, 4, '2025-01-12 16:00:00');

delimiter //
-- trigger tăng like_count khi thêm lượt thích mới
create trigger after_like_insert
after insert on likes
for each row
begin
    update posts set like_count = like_count + 1 where post_id = new.post_id;
end //

-- trigger giảm like_count khi xóa lượt thích
create trigger after_like_delete
after delete on likes
for each row
begin
    update posts set like_count = like_count - 1 where post_id = old.post_id;
end //
delimiter ;

-- Xem số lượng like của từng bài đăng
select post_id, content, like_count from posts;

-- 4.Tạo View user_statistics
create view user_statistics as
select u.user_id, u.username, u.post_count, sum(ifnull(p.like_count, 0)) as total_likes from users u
left join posts p on u.user_id = p.user_id
group by u.user_id, u.username, u.post_count;


-- 5.Thêm một lượt thích và kiểm chứng
-- Thêm lượt thích mới
insert into likes (user_id, post_id, liked_at) values (2, 4, now());

-- Kiểm tra bảng posts (like_count của post_id 4 phải tăng lên)
select * from posts where post_id = 4;

-- Kiểm tra View (tổng likes của Charlie phải tăng lên)
select * from user_statistics;



-- 6.Xóa một lượt thích và kiểm chứng lại
-- Xóa lượt thích vừa thêm (giả sử like_id vừa tạo là 5, hoặc xóa theo user_id và post_id)
delete from likes where user_id = 2 and post_id = 4;

-- Kiểm tra lại bảng posts để xác nhận like_count đã giảm
select * from posts where post_id = 4;

-- Kiểm tra lại View để xác nhận total_likes đã cập nhật
select * from user_statistics;
