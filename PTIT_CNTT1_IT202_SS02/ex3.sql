CREATE DATABASE k24_cntt1_ss02_gioi1;
USE k24_cntt1_ss02_gioi1;

CREATE TABLE Student (
    student_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL
);

CREATE TABLE Subject (
    subject_id VARCHAR(10) PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    credit INT CHECK (credit > 0)
);

CREATE TABLE Enrollment (
    student_id VARCHAR(10),
    subject_id VARCHAR(10),
    enroll_date DATE NOT NULL,

    PRIMARY KEY (student_id, subject_id),
	FOREIGN KEY (student_id)
	REFERENCES Student(student_id),
	FOREIGN KEY (subject_id)
	REFERENCES Subject(subject_id)
);
