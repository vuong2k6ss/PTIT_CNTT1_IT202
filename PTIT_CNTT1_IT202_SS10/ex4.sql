use  `social_network_pro`;

-- 2.TẠO CHỈ MỤC PHỨC HỢP (Composite Index)
EXPLAIN ANALYZE
SELECT post_id, content, created_at FROM posts
WHERE user_id = 1 AND created_at >= '2026-01-01' AND created_at <  '2027-01-01';

-- Tạo chỉ mục phức hợp idx_created_at_user_id
CREATE INDEX idx_created_at_user_id
ON posts(created_at, user_id);

-- Chạy lại truy vấn với EXPLAIN ANALYZE (SAU khi tạo index)
EXPLAIN ANALYZE
SELECT post_id, content, created_at FROM posts
WHERE user_id = 1 AND created_at >= '2026-01-01' AND created_at <  '2027-01-01';

-- 3.TẠO CHỈ MỤC DUY NHẤT (Unique Index)
EXPLAIN ANALYZE
SELECT user_id, username, email FROM users
WHERE email = 'an@gmail.com';

-- Tạo chỉ mục duy nhất idx_email
CREATE UNIQUE INDEX idx_email
ON users(email);

-- Chạy lại truy vấn (SAU khi tạo index)
EXPLAIN ANALYZE
SELECT user_id, username, email FROM users
WHERE email = 'an@gmail.com';

-- 4. XÓA CHỈ MỤC
-- Xóa chỉ mục phức hợp khỏi posts
DROP INDEX idx_created_at_user_id ON posts;
-- Xóa chỉ mục duy nhất khỏi users
DROP INDEX idx_email ON users;


