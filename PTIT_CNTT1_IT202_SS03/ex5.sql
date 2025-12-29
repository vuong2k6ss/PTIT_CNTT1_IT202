CREATE DATABASE IT202_SS03_xuatsac1;
USE IT202_SS03_xuatsac1;

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL
);

CREATE TABLE Subject (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL
);

INSERT INTO Student (student_id, full_name) VALUES
(1, 'Nguyen Van A'),
(2, 'Tran Thi B');

INSERT INTO Subject (subject_id, subject_name) VALUES
(101, 'Co so du lieu'),
(102, 'Lap trinh C');

CREATE TABLE Score (
    student_id INT,
    subject_id INT,
    mid_score DECIMAL(4,2) CHECK (mid_score BETWEEN 0 AND 10),
    final_score DECIMAL(4,2) CHECK (final_score BETWEEN 0 AND 10),
    PRIMARY KEY (student_id, subject_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
);

INSERT INTO Score (student_id, subject_id, mid_score, final_score) VALUES
(1, 101, 7.5, 8.0),
(1, 102, 6.5, 7.0),
(2, 101, 8.0, 9.0),
(2, 102, 7.0, 8.5);

UPDATE Score
SET final_score = 9.0
WHERE student_id = 1
  AND subject_id = 101;


SELECT * FROM Score;


SELECT *
FROM Score
WHERE final_score >= 8;