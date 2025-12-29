CREATE DATABASE IT202_SS03_kha2;
USE IT202_SS03_kha2;

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE
);

INSERT INTO Student (student_id, full_name, date_of_birth, email) VALUES
(1, 'Nguyen Van A', '2003-05-10', 'a@gmail.com'),
(2, 'Tran Thi B', '2003-08-22', 'b@gmail.com'),
(3, 'Le Van C', '2004-01-15', 'c@gmail.com'),
(4, 'Pham Van D', '2003-12-01', 'd@gmail.com'),
(5, 'Hoang Thi E', '2004-03-18', 'e@gmail.com');


UPDATE Student
SET email = 'cccc@gmail.com'
WHERE student_id = 3;


UPDATE Student
SET date_of_birth = '2003-09-01'
WHERE student_id = 2;


DELETE FROM Student
WHERE student_id = 5;


SELECT * FROM Student;