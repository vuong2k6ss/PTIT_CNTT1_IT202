drop database if exists online_learning;
create database online_learning;
use online_learning;

create table Student (
    student_id int auto_increment primary key,
    full_name varchar(100) not null,
    birth_date date not null,
    email varchar(100) not null unique
);

create table Instructor (
    instructor_id int auto_increment primary key,
    full_name varchar(100) not null,
    email varchar(100) not null unique
);

create table Course (
    course_id int auto_increment primary key,
    course_name varchar(150) not null,
    description varchar(255),
    total_sessions int check (total_sessions > 0),
    instructor_id int,
    foreign key (instructor_id) references Instructor(instructor_id)
);

create table Enrollment (
    student_id int not null,
    course_id int not null,
    enroll_date date default (current_date),
    primary key (student_id, course_id),
    foreign key (student_id) references Student(student_id),
    foreign key (course_id) references Course(course_id)
);

create table Result (
    student_id int not null,
    course_id int not null,
    mid_score decimal(4,2) check (mid_score between 0 and 10),
    final_score decimal(4,2) check (final_score between 0 and 10),
    primary key (student_id, course_id),
    foreign key (student_id, course_id) 
        references Enrollment(student_id, course_id)
);


insert into Student (full_name, birth_date, email) values
('Nguyễn Văn An','2002-05-10','an@gmail.com'),
('Trần Thị Bình','2001-08-15','binh@gmail.com'),
('Lê Minh Châu','2003-03-20','chau@gmail.com'),
('Phạm Quốc Dũng','2002-11-01','dung@gmail.com'),
('Võ Thị Hoa','2001-01-25','hoa@gmail.com');

insert into Instructor (full_name, email) values
('Nguyễn Văn A','a@uni.edu'),
('Trần Thị B','b@uni.edu'),
('Lê Văn C','c@uni.edu'),
('Phạm Thị D','d@uni.edu'),
('Hoàng Văn E','e@uni.edu');

insert into Course (course_name, description, total_sessions, instructor_id) values
('Lập trình C','C căn bản',30,1),
('Cơ sở dữ liệu','SQL & MySQL',25,2),
('Lập trình Java','OOP Java',28,3),
('Web cơ bản','HTML CSS JS',20,4),
('CTDL & GT','Thuật toán',35,5);


insert into Enrollment (student_id, course_id, enroll_date) values
(1,1,'2024-09-01'),
(1,2,'2024-09-01'),
(2,2,'2024-09-03'),
(3,3,'2024-09-05'),
(4,4,'2024-09-07');

insert into Result (student_id, course_id, mid_score, final_score) values
(1,1,7.5,8.0),
(1,2,6.5,7.0),
(2,2,8.0,8.5),
(3,3,7.0,7.8),
(4,4,6.0,6.5);


update Student
set email = 'an_new@gmail.com'
where student_id = 1;

update Course
set description = 'Cơ sở dữ liệu nâng cao'
where course_id = 2;

update Result
set final_score = 9.0
where student_id = 1 and course_id = 1;


delete from Enrollment
where student_id = 4 and course_id = 4;
delete from Result
where student_id = 4 and course_id = 4;


select * from Student;
select * from Instructor;
select * from Course;
select s.full_name, c.course_name, e.enroll_date
from Enrollment e
join Student s on e.student_id = s.student_id
join Course c on e.course_id = c.course_id;
select s.full_name, c.course_name, r.mid_score, r.final_score
from Result r
join Student s on r.student_id = s.student_id
join Course c on r.course_id = c.course_id;

