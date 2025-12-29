CREATE DATABASE quan_ly_dao_tao;
USE quan_ly_dao_tao;

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Subject (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    credit INT CHECK (credit > 0)
);

CREATE TABLE Enrollment (
    student_id INT,
    subject_id INT,
    enroll_date DATE,
    PRIMARY KEY (student_id, subject_id),
	FOREIGN KEY (student_id) REFERENCES Student(student_id),
	FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
);

CREATE TABLE Score (
    student_id INT,
    subject_id INT,
    mid_score FLOAT CHECK (mid_score BETWEEN 0 AND 10),
    final_score FLOAT CHECK (final_score BETWEEN 0 AND 10),
    PRIMARY KEY (student_id, subject_id),
	FOREIGN KEY (student_id) REFERENCES Student(student_id),
	FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
);

INSERT IGNORE INTO Student VALUES
(1, 'Nguyễn Thái Linh', '2002-05-10', 'linh@gmail.com'),
(2, 'Hoàng Thị Bình', '2001-11-20', 'binh@gmail.com'),
(3, 'Lê Hoàng Cường', '2003-03-15', 'cuong@gmail.com'),
(10, 'Phạm Minh Đức', '2003-08-12', 'duc.pham@gmail.com');

INSERT IGNORE INTO Subject VALUES
(1, 'Cơ sở dữ liệu', 3),
(2, 'Lập trình C', 4),
(3, 'Cấu trúc dữ liệu', 3);

INSERT IGNORE INTO Enrollment VALUES
(1, 1, '2024-09-01'),
(1, 2, '2024-09-01'),
(2, 1, '2024-09-02'),
(2, 3, '2024-09-02'),
(10, 1, '2024-09-05'),
(10, 2, '2024-09-05');

INSERT IGNORE INTO Score VALUES
(1, 1, 7.5, 8.5),
(1, 2, 6.0, 7.0),
(2, 1, 8.0, 9.0),
(2, 3, 7.0, 8.0),
(10, 1, 7.0, 8.0),
(10, 2, 6.5, 7.5);

UPDATE Score
SET final_score = 8.2
WHERE student_id = 10
AND subject_id = 2;


DELETE FROM Enrollment
WHERE student_id = 10
  AND subject_id = 2;

DELETE FROM Score
WHERE student_id = 10
AND subject_id = 2;

SELECT * FROM Student;
SELECT * FROM Subject;
SELECT * FROM Enrollment;
SELECT * FROM Score;

SELECT
    s.student_id,
    s.full_name,
    sub.subject_name,
    sc.mid_score,
    sc.final_score
FROM Student s
JOIN Score sc ON s.student_id = sc.student_id
JOIN Subject sub ON sc.subject_id = sub.subject_id
ORDER BY s.student_id;