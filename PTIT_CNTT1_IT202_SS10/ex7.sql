use  `social_network_pro`;

-- 2. Tạo VIEW view_user_activity_status
CREATE VIEW view_user_activity_status AS
SELECT u.user_id,u.username,u.gender,u.created_at,
CASE
WHEN COUNT(DISTINCT p.post_id) > 0
OR COUNT(DISTINCT c.comment_id) > 0
THEN 'Active'
ELSE 'Inactive'
END AS status
FROM users u
LEFT JOIN posts p ON u.user_id = p.user_id
LEFT JOIN comments c ON u.user_id = c.user_id
GROUP BY u.user_id,u.username,u.gender,u.created_at;

-- 3. Truy vấn view view_user_activity_status và kiểm tra kết quả thu được
SELECT * FROM view_user_activity_status;

-- 4.Thống kê số lượng người dùng theo từng trạng thái
SELECT status,COUNT(*) AS user_count FROM view_user_activity_status
GROUP BY status ORDER BY user_count DESC;

-- View view_user_activity_status giúp xác định nhanh trạng thái hoạt động của người dùng dựa trên dữ liệu bài viết và bình luận.
--  Việc sử dụng view giúp truy vấn thống kê đơn giản, dễ bảo trì và tái sử dụng trong các báo cáo hệ thống.