CREATE DATABASE k24_cntt1_ss02_gioi2;
USE k24_cntt1_ss02_gioi2;

CREATE TABLE Subject (
    subject_id VARCHAR(10) PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    credit INT CHECK (credit > 0)
);

CREATE TABLE Teacher (
    teacher_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

ALTER TABLE Subject
ADD teacher_id VARCHAR(10);

ALTER TABLE Subject
ADD CONSTRAINT fk_subject_teacher
FOREIGN KEY (teacher_id)
REFERENCES Teacher(teacher_id);