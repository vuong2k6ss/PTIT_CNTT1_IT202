CREATE DATABASE IT202_SS03_kha1;
USE IT202_SS03_kha1;

CREATE TABLE Student (
    student_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE
);

INSERT INTO Student (student_id, full_name, date_of_birth, email) VALUES
('SV001', 'Nguyen Van A', '2003-05-10', 'a@gmail.com'),
('SV002', 'Tran Thi B', '2003-08-22', 'b@gmail.com'),
('SV003', 'Le Van C', '2004-01-15', 'c@gmail.com');

-- Lấy toàn bộ danh sách sinh viên
SELECT * FROM Student;

-- Lấy mã sinh viên và họ tên
SELECT student_id, full_name FROM Student;

