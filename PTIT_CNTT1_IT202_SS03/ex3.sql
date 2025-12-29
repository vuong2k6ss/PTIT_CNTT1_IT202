CREATE DATABASE IT202_SS03_gioi1;
USE IT202_SS03_gioi1;

CREATE TABLE Subject (
    subject_id VARCHAR(10) PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    credit INT CHECK (credit > 0)
);

INSERT INTO Subject (subject_id, subject_name, credit) VALUES
('MH001', 'Co so du lieu', 3),
('MH002', 'Lap trinh C', 4),
('MH003', 'Mang may tinh', 3);

SELECT * FROM Subject;

UPDATE Subject
SET credit = 5
WHERE subject_id = 'MH002';

UPDATE Subject
SET subject_name = 'Mang may tinh can ban'
WHERE subject_id = 'MH003';

SELECT * FROM Subject;