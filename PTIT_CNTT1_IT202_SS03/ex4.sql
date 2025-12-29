CREATE DATABASE IT202_SS03_gioi2;
USE IT202_SS03_gioi2;

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL
);

CREATE TABLE Subject (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    credit INT CHECK (credit > 0)
);


INSERT INTO Student (student_id, full_name) VALUES
(1, 'Nguyen Van A'),
(2, 'Tran Thi B');


INSERT INTO Subject (subject_id, subject_name, credit) VALUES
(101, 'Co so du lieu', 3),
(102, 'Lap trinh C', 4),
(103, 'Mang may tinh', 3);


CREATE TABLE Enrollment (
    student_id INT,
    subject_id INT,
    enroll_date DATE NOT NULL,
    PRIMARY KEY (student_id, subject_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
	FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
);

INSERT INTO Enrollment (student_id, subject_id, enroll_date) VALUES
(1, 101, '2025-09-01'),
(1, 102, '2025-09-02'),
(2, 101, '2025-09-01'),
(2, 103, '2025-09-03');


SELECT * FROM Enrollment;


SELECT *
FROM Enrollment
WHERE student_id = 1;