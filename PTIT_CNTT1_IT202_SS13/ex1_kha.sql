create database SS13_ex1;
use SS13_ex1;
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at DATE,
    follower_count INT DEFAULT 0,
    post_count INT DEFAULT 0
);

CREATE TABLE posts (
    post_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    content TEXT,
    created_at DATETIME,
    like_count INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

INSERT INTO users (username, email, created_at) VALUES
('alice', 'alice@example.com', '2025-01-01'),
('bob', 'bob@example.com', '2025-01-02'),
('charlie', 'charlie@example.com', '2025-01-03');


-- Trigger tăng post_count khi thêm bài đăng mới
DELIMITER //
create trigger after_post_insert
after insert on posts
for each row
begin
    update users set post_count = post_count + 1 where user_id = new.user_id;
end //

-- Trigger giảm post_count khi xóa bài đăng
create trigger after_post_delete
after delete on posts
for each row
BEGIN
    update users set post_count = post_count - 1 where user_id = old.user_id;
end //
DELIMITER ;

INSERT INTO posts (user_id, content, created_at) VALUES
(1, 'Hello world from Alice!', '2025-01-10 10:00:00'),
(1, 'Second post by Alice', '2025-01-10 12:00:00'),
(2, 'Bob first post', '2025-01-11 09:00:00'),
(3, 'Charlie sharing thoughts', '2025-01-12 15:00:00');

-- Kiểm tra bảng users
SELECT * FROM users;


-- Xóa bài đăng có id là 2
DELETE FROM posts WHERE post_id = 2;

-- kiểm tra sự thay đổi
SELECT * FROM users;