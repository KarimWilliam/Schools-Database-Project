use SSchools6
-- System Admin 

--1 Adding Schools
insert into Schools values ('Manor House School', 'our mission is to educate children, and teach them to think independently and use critical thinking whenver possible',
10000.5,'our vision is to have a bully free school environment where chilldren of all races and religions can have an educational education','MHS@gmail.com','international',
'mohandeseen', 'our school is great!','English','all levels');

insert into Highs values ('Manor House School')
insert into middles values ('Manor House School')
insert into Elementaries values ('Manor House School')

insert into Schools values ('Masrya School ', 'our mission is to educate the masses',1000,'our vision is to educate as many people we we can','Masrya@yahoo.com','national',
'6 of october', 'send us your questions on our email','Arabic', 'middle and high');

insert into Schools values ('Elite School', 'our mission is to give high quality education',20000,'our vision is a future where everyone is educated','EliteShool@gmail.com','international',
'Giza', 'you must pass a test to enter this school','English', 'all levels' );

--2 Adding Courses
insert into Levels values ('Elementary');
insert into Levels values ('Middle');
insert into Levels values ('High');
insert into courses values ('Psychology', 'in this course we teach the basics of psychological interactions between humans',11,'High');
insert into Courses values ('Math 1','in this course we teach math basics',1,'Elementary');
insert into Courses values ('Math 2','in this course we teach more math basics',2,'Elementary');
insert into Course_prerequisite_Course values (2,'Math 1',3,'Math 2' );

--3 Adding Admins and teachers
insert into Employees (address,salary,gender,e_mail,first_name,middle_name,last_name,user_name,password,birth_date,school)
values ('Maadi',5000,'M','Tarek.Ahmed@yagoo.com','Tarek','Hussein','Ahmed','adminTarek','strongPassword123','1985-11-3','Manor House School');

insert into Employees (address,salary,gender,e_mail,first_name,middle_name,last_name,user_name,password,birth_date,school)
values ('6 of october',3000,'F','Lara.Hamed@yahoo.com','Lara','Kamel','Hamed','adminLara','strongerPassword123','1990-11-3','Masrya School');

insert into Employees (address,salary,gender,e_mail,first_name,middle_name,last_name,user_name,password,birth_date,school)
values ('6 of october',3000,'M','Ibrahim.Hamed@yahoo.com','Ibrahim','walid','Hamed','Ibrahim Teach','7382304','1988-12-8','Masrya School');

insert into Employees (address,salary,gender,e_mail,first_name,middle_name,last_name,user_name,password,birth_date,school)
values ('nasr city',5000,'F','lina.rahman@yahoo.com','lina','omar','rahman','Teach Lina','1234567','1980-2-4','Elite School');

insert into Employees (address,salary,gender,e_mail,first_name,middle_name,last_name,user_name,password,birth_date,school)
values ('nasr city',5000,'M','Karim.William@gmail.com','karim','osama','william','Karim ','555555','1997-1-13','Elite School');

insert into Employees (address,salary,gender,e_mail,first_name,middle_name,last_name,user_name,password,birth_date,school)
values ('Maadi 2nd street',5000,'F','Marline.Maged@yagoo.com','Marline','Magdey','Maged','Teach_Marlin','777888','1990-1-1','Manor House School');


insert into Administrator values (1);
insert into Administrator values (2);
insert into Teachers values (3,5,null);
insert into Teachers values (4,16,null);
insert into Teachers values (5,1,4);
insert into Teachers values (7,0,null)


-- adding parents

insert into parents values ('Samir','pass123word','zamalk',92983193,'Samir92@gmail.com','Samir','youssef');
insert into parents values ('Morad','singAsong','mohandeseen',029301921,'Moradsi@gmail.com','Morad','Hassan');

-- adding school reviews

insert into Parents_reviews_Schools values ('Manor House School','Morad','this school is okay');
insert into Parents_reviews_Schools values ('Manor House School','Samir','this school is good');

--adding teacher ratings

insert into Parents_rate_Teachers values (3,'Morad',10);

--adding students 
 
insert into students values (888444775,'George_Lewies','George','apples123','M','2002-7-13','Manor House School')

-- adding a club 

insert into Clubs values ('chess club','we  teach and play chess','Manor House School')


-- add an announcment 

insert into Announements values ('plant plants','2016-11-19','you will learn about planting','planting',1)

