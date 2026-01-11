create database CNTT1_PhungVanVuong_002;
use CNTT1_PhungVanVuong_002;
drop database CNTT1_PhungVanVuong_002;

-- 1 tạo bảng csdl
create table Customers (
    customer_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    address VARCHAR(200) NOT NULL
);

create table InsuranceAgents (
    agent_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    region VARCHAR(50) NOT NULL,
    years_of_experience INT CHECK (years_of_experience >= 0),
    commission_rate DECIMAL(5,2) CHECK (commission_rate >= 0)
);

create table Policies (
    policy_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id VARCHAR(10),
    agent_id VARCHAR(10),
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP NOT NULL,
    status ENUM ('Active', 'Expired', 'Cancelled') DEFAULT 'Active',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (agent_id) REFERENCES InsuranceAgents(agent_id)
);

create table ClaimPayments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    policy_id INT,
    payment_method VARCHAR(50) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount DECIMAL(15,2) CHECK (amount >= 0),
    FOREIGN KEY (policy_id) REFERENCES Policies(policy_id)
);

-- PHẦN 2: thêm dữ liệu

insert into Customers values
('C001', 'Nguyen Van An', '0912345678', 'Hanoi, Vietnam'),
('C002', 'Tran Thi Binh', '0923456789', 'Ho Chi Minh, Vietnam'),
('C003', 'Le Minh Chau', '0934567890', 'Da Nang, Vietnam'),
('C004', 'Pham Hoang Duc', '0945678901', 'Can Tho, Vietnam'),
('C005', 'Vu Thi Hoa', '0956789012', 'Hai Phong, Vietnam');

insert into InsuranceAgents values
('A001', 'Nguyen Van Minh', 'Mien Bac', 10, 5.50),
('A002', 'Tran Thi Lan', 'Mien Nam', 15, 7.00),
('A003', 'Le Hoang Nam', 'Mien Trung', 8, 4.50),
('A004', 'Pham Quang Huy', 'Mien Tay', 20, 8.00),
('A005', 'Vu Thi Mai', 'Mien Bac', 5, 3.50);

insert into Policies (customer_id, agent_id, start_date, end_date) values
('C001', 'A001', '2024-01-01 08:00:00', '2025-01-01 08:00:00'),
('C002', 'A002', '2024-02-01 09:30:00', '2025-02-01 09:30:00'),
('C003', 'A003', '2023-03-02 10:00:00', '2024-03-02 10:00:00'),
('C004', 'A004', '2024-05-02 14:00:00', '2025-05-02 14:00:00'),
('C005', 'A005', '2024-06-03 15:30:00', '2025-06-03 15:30:00');

insert into ClaimPayments (policy_id, payment_method, payment_date, amount) values
(1, 'Bank Transfer', '2024-05-01 08:45:00', 5000000.00),
(2, 'Bank Transfer', '2024-06-01 10:00:00', 7500000.00),
(4, 'Cash', '2024-08-02 15:00:00', 2000000.00),
(1, 'Bank Transfer', '2024-09-04 11:00:00', 3000000.00),
(3, 'Credit Card', '2023-10-05 14:00:00', 1500000.00);

-- bài làm

-- 3.Viết câu lệnh thay đổi địa chỉ của khách hàng có customer_id = 'C002' thành "District 1, Ho Chi Minh City"
update Customers set address = 'District 1, Ho Chi Minh City'
where customer_id = 'C002';

-- 4. Thay đổi trạng thái nhân viên:. Nhân viên có mã A001 đạt thành tích tốt, hãy tăng years_of_experience thêm 2 năm và tăng commission_rate thêm 1.5%
update InsuranceAgents set years_of_experience = years_of_experience + 2, commission_rate = commission_rate + 1.5
where agent_id = 'A001';

-- 5.Xóa dữ liệu có điều kiện. Viết câu lệnh xóa tất cả các hợp đồng trong bảng Policies có trạng thái là "Cancelled" và ngày bắt đầu trước ngày "2024-06-15".
delete from Policies
where status = 'Cancelled' and start_date < '2024-06-15';

-- 6. Liệt kê danh sách các nhân viên bảo hiểm gồm: agent_id, full_name, region có số năm kinh nghiệm (years_of_experience) trên 8 năm
select agent_id, full_name, region from InsuranceAgents
where years_of_experience > 8;

-- 7.Lấy thông tin customer_id, full_name, phone của những khách hàng có tên chứa từ khóa "Nguyen".
select customer_id, full_name, phone from Customers
where full_name like '%Nguyen%';

-- 8.Hiển thị danh sách tất cả các hợp đồng gồm: policy_id, start_date, status, sắp xếp theo ngày bắt đầu (start_date) giảm dần
select policy_id, start_date, status from Policies
order by start_date desc;

-- 9.Lấy thông tin 3 bản ghi đầu tiên trong bảng ClaimPayments có phương thức thanh toán là 'Bank Transfer'
select * from ClaimPayments
where payment_method = 'Bank Transfer' limit 3;

-- 10. Hiển thị thông tin gồm mã nhân viên (agent_id) và tên nhân viên (full_name) từ bảng InsuranceAgents, bỏ qua 2 bản ghi đầu tiên và lấy 3 bản ghi tiếp theo (LIMIT và OFFSET)
select agent_id, full_name from InsuranceAgents limit 3 offset 2;