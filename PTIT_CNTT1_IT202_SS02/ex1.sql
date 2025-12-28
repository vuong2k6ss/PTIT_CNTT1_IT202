CREATE DATABASE k24_cntt1_ss02_kha1;
USE k24_cntt1_ss02_kha1;



CREATE TABLE Class (
    class_id VARCHAR(10) PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL,
    school_year INT NOT NULL
);

CREATE TABLE Student (
    student_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    class_id VARCHAR(10),
	FOREIGN KEY (class_id)
	REFERENCES Class(class_id)
);



