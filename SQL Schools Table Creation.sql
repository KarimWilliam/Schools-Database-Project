
use SSchools6

create table Levels
(name varchar (30) primary key
);

CREATE Table Schools
(
name VARCHAR(50) PRIMARY KEY,
mission VARCHAR(300),
fees float,
vision VARCHAR(300),
e_mail VARCHAR(30) unique ,
type varchar(15),
address varchar(100) unique,
general_information varchar(300),
main_language varchar(15),
level varchar(30),

);

--drop table Schools;

create Table Phone_Numbers_of_Schools
(phone_number int,
school Varchar(50),
primary key(phone_number, School),
FOREIGN KEY(school) references Schools(name) on delete cascade on update cascade
);

create Table Elementaries
(school_name varchar(50),
primary key (school_name),
foreign key (school_name) references Schools(name) on delete cascade on update cascade
);



create Table Elementaries_Supplies
(elementaries varchar(50),
supplies varchar (300),
primary key (elementaries),
foreign key (elementaries) references Elementaries(school_name) on delete cascade on update cascade
);

create Table Middles
(school_name varchar(50),
primary key (school_name),
foreign key (school_name) references Schools(name) on delete cascade on update cascade
);

create Table Highs
(school_name varchar(50) not null,
primary key (school_name),
foreign key (school_name) references Schools(name) on delete cascade on update cascade
);

create Table Parents
(user_name varchar(20),
password varchar(20) not null,
address varchar(100), 
home_number int,
e_mail varchar(50) unique not null,
first_name varchar(15),
last_name varchar(15),
primary key (user_name)
);

create table Mobile_Numbers_of_Parents
(parent varchar(20) not null,
mobile_number int unique,
primary key(parent,mobile_number),
foreign key (parent) references Parents on delete cascade on update cascade 
);

--create table Parents_review_Schools
--(parent varchar(20) not null,
--school varchar(50) not null,
--review_text varchar(500),
--primary key (parent,school),
--foreign key (parent) references Parents(user_name) on delete no action on update cascade,
--foreign key (school) references Schools(name) on delete no action on update cascade
--);

create table Clubs
(name varchar(20) not null,
purpose varchar(300),
school_name varchar(50) not null,
primary key (name, school_name),
foreign key (school_name) references Highs on delete cascade on update cascade
);



create table Students
(ssn int primary key,
user_name varchar (20) ,
name varchar (20),
password varchar(20) ,
gender varchar (1),
birth_date smalldatetime not null,
age AS (YEAR(CURRENT_TIMESTAMP) - YEAR(birth_date)),
school varchar(50),
foreign key (school) references Schools on delete no action on update cascade
);

create table Clubs_joinedBy_Students
(club_name varchar(20),
club_school_name varchar(50),
student int,
primary key (club_name,club_school_name,student),
foreign key(club_name,club_school_name) references Clubs(name, school_name) on update no action on delete no action,
foreign key(student) references Students on delete cascade on update cascade
);  

--drop table Clubs_joinedBy_Students    

create table Parents_appliesIn_Schools_for_Students
(parent varchar (20),
school varchar (50),
student int,
acceptance_status varchar(10),
primary key(school,student,parent),
foreign key (school) references Schools,
foreign Key (student) references Students,
foreign Key (parent) references Parents
);

create table Parents_reviews_Schools
(school varchar(50),
parent varchar(20),
review_text varchar(500)
primary key (school,parent),
foreign key (school) references Schools,
foreign key (parent) references Parents
);

create table Employees
(e_id int primary key identity,
address varchar(100),
salary int,
gender varchar(1),
e_mail varchar(50) unique,
first_name varchar(20),
middle_name varchar(20),
last_name varchar(20),
user_name varchar (20) unique,
password varchar(20),
birth_date smalldatetime,
school varchar(50) foreign key references Schools on update cascade 
);


--alter table Employees add password varchar(20) not null default '12345'
create table Administrator


(e_id int primary key,
foreign key (e_id) references Employees on delete cascade on update cascade
);

create table Announements
(a_number int primary key identity,
title varchar(20),
date smalldatetime,
decription varchar(300),
type varchar(20),
e_id int foreign key references Administrator on update cascade
);

create table Activities
(act_id int primary key identity,
location varchar(50),
date smalldatetime,
type varchar(20),
equipment varchar(50),
description varchar(300)
);

create table Activity_joinedBy_Student 
(act_id int,
student_ssn int,
primary key (student_ssn,act_id),
foreign key (act_id) references Activities,
foreign key (student_ssn) references Students on update cascade
);

create table Teachers
(e_id int primary key,
experience_years smallint,
supervisor int  , -- not sure how to add supervisor >15 constraint
foreign key (e_id) references Employees on delete cascade on update cascade ,
foreign key (supervisor) references Teachers 
);

--create table Teacher_Supervises_Teacher 
--(e_id int,
--e_supervisor_id int,
--supervisor_experience_years int,
--);

--drop table Teachers 

create table Activity_createdBy_Administrator_andAssignedTo_Teacher
(admin_id int,
teacher_id int,
act_id int,
primary key (act_id),
foreign key (admin_id) references Administrator ,
foreign key (teacher_id) references Teachers ,
foreign key (act_id) references Activities 
);

create table Parents_rate_Teachers
(teacher_id int primary key,
parent_username varchar(20),
rating smallint check (rating<11 and rating>-1),
foreign key (parent_username) references Parents,
foreign key (teacher_id) references Teachers
);

create table Report 
(date smalldatetime,
ssn int,
content varchar (200),
teacher_comments varchar(200), 
primary key (date,ssn),
foreign key (ssn) references Students
);


create table Report_on_Student_by_Teacher
(report_date smalldatetime,
teacher_id int,
student_ssn int,
primary key (report_date,student_ssn),
foreign key (report_date,student_ssn)references Report(date,ssn),
foreign key (teacher_id) references Teachers
);

create table Parent_repliesOn_Report
(report_date smalldatetime primary key,
parent_username varchar(20),
reply varchar(300),
ssn int,
foreign key (report_date,ssn) references Report(date,ssn),
foreign key (parent_username) references Parents
);

create table Parent_of_Student
(parent_username varchar(20),
student_ssn int,
primary key (student_ssn, parent_username),
foreign key (parent_username) references Parents,
foreign key (student_ssn) references Students
);


create table Courses
(code int identity,
name varchar (20),
description varchar(200),
grade int,
primary key (code,name),
level varchar(30) foreign key references Levels on update cascade
);

create table  Course_prerequisite_Course
(course_code int,
course_name varchar(20),
course_needed_code int,
course_needed_name varchar(20),
primary key (course_code, course_name,course_needed_code,course_needed_name),
foreign key (course_code,course_name) references courses (code,name) ,
foreign key (course_needed_code,course_needed_name) references courses (code,name) 
);


create table Assignments
(assignment_id int primary key identity,
posting_date smalldatetime,
due_date smalldatetime,
content varchar(max),
teacher_id int foreign key  references Teachers,
course_id int,
course_name varchar(20),
foreign key (course_id,course_name) references Courses (code,name)
);

create table Assignment_solvedBy_Student 
(assignment_id int,
student_ssn int ,
grade smallint check (grade<106 and grade>-1),
solution varchar(max)
primary key (assignment_id, student_ssn),
foreign key (assignment_id) references Assignments,
foreign key (student_ssn) references Students,
);

create table Course_learnedBy_Student_taughtBy_Teacher 
(student_ssn int primary key,
level_name varchar(30),
teacher_id int,
course_id int,
course_name varchar(20),
foreign key (course_id,course_name) references Courses (code,name) on update cascade on delete cascade ,
foreign key (student_ssn) references Students on delete cascade on update cascade, -- Same Problem?
foreign key (level_name) references Levels,
foreign key (teacher_id) references Teachers 
);

 --drop table Student_taughtBy_Teacher

create table Student_enrolledIn_level 
(student_ssn int primary key,
grade int,
level varchar(30) foreign key references Levels, 
foreign key (student_ssn) references Students on delete cascade on update cascade
);

create table Questions
(question_num int identity,
question varchar(300),
answer varchar(300) ,
course_name varchar(20),
course_code int,
primary key (question_num, course_name, course_code),
foreign key (course_code, course_name) references Courses
);

create table Course_questionsAsked_Student
(question int,
student_ssn int, 
course_code int,
course_name varchar(20),
primary key (question,course_code,course_name),
foreign key (question, course_name, course_code) references Questions,
foreign key (student_ssn) references Students,
foreign key (course_code, course_name) references Courses
);

create table Courses_taughtBy_Teachers 
(teacher_id int primary key, 
course_id int ,
course_name varchar(20),
foreign key (teacher_id) references Teachers on update cascade on delete cascade ,
foreign key (course_id,course_name) references Courses (code,name) on update cascade

)