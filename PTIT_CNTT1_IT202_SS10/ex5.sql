use  `social_network_pro`;

-- 2.Tạo chỉ mục có tên idx_hometown trên cột hometown của bảng users
CREATE INDEX idx_hometown
ON users(hometown);


-- 3.truy vấn
EXPLAIN ANALYZE
SELECT u.username,p.post_id,p.content FROM users u
JOIN posts p ON u.user_id = p.user_id
WHERE u.hometown = 'Hà Nội'
ORDER BY u.username DESC LIMIT 10;

-- 4.Sử dụng EXPLAIN ANALYZE để kiểm tra lại kế hoạch thực thi trước và sau khi có chỉ mục.
-- TRƯỚC KHI TẠO idx_hometown
EXPLAIN ANALYZE
SELECT u.username,p.post_id,p.content FROM users u
JOIN posts p ON u.user_id = p.user_id
WHERE u.hometown = 'Hà Nội'
ORDER BY u.username DESC LIMIT 10;

-- SAU KHI TẠO idx_hometown
EXPLAIN ANALYZE
SELECT u.username,p.post_id,p.content FROM users u
JOIN posts p ON u.user_id = p.user_id
WHERE u.hometown = 'Hà Nội'
ORDER BY u.username DESC LIMIT 10;

-- Việc tạo chỉ mục cho cột hometown giúp tối ưu đáng kể các truy vấn lọc người dùng theo quê quán.
-- Khi kết hợp với JOIN và LIMIT, hệ quản trị CSDL có thể giảm số lượng bản ghi cần xử lý, từ đó cải thiện hiệu năng truy vấn.

