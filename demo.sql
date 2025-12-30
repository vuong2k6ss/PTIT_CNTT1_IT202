CREATE DATABASE IT202_SS04;
USE IT202_SS04;

drop database IT202_SS04;

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    email VARCHAR(100) UNIQUE
);


CREATE TABLE Teacher (
    teacher_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    total_lessons INT,
    teacher_id INT,
    
	FOREIGN KEY (teacher_id)
	REFERENCES Teacher(teacher_id)
);

CREATE TABLE Enrollment (
    student_id INT,
    course_id INT,
    enroll_date DATE,
    PRIMARY KEY (student_id, course_id),
    
	FOREIGN KEY (student_id)
	REFERENCES Student(student_id),
	FOREIGN KEY (course_id)
	REFERENCES Course(course_id)
);


CREATE TABLE Score (
    student_id INT,
    course_id INT,
    mid_score DECIMAL(4,2) CHECK (mid_score BETWEEN 0 AND 10),
    final_score DECIMAL(4,2) CHECK (final_score BETWEEN 0 AND 10),
    PRIMARY KEY (student_id, course_id),
	FOREIGN KEY (student_id)
	REFERENCES Student(student_id),
	FOREIGN KEY (course_id)
	REFERENCES Course(course_id)
);

