--system admin 
use SSchools6
--1 
exec Create_School 'Manor House School American', 'our mission is to educate children, and teach them to think independently and use critical thinking whenver possible',
13000,'our vision is to have a bully free school environment where chilldren of all races and religions can have an educational education','MHSA@gmail.com','international',
'mohandeseen 1st street', 'our school is great!','English','all levels'
exec Create_School 'Alson', 'our mission is...', 7000,'our vision is ','alson@gmail.com','international','zamalk 1st street','for more info call 91120312','English','all levels'

--2
exec Create_Level 'Middle';
exec Create_Course  'Arabic6','in this course we teach Arabic intermediate at an level',6,'Middle'

--3

exec Create_Administrator 'nasr city','M','Maged.ahmed@gmail.com','Maged','middler','Ahmed','Maged','325252','1996-1-13'

declare @x int;
 select @x = max(e_id) from Employees
exec Assign_Admin_To_School    @x,'Manor House School American'

--4
exec Delete_School 'Alson'

-- System user 

--1
exec School_Search_Name 'Manor House School American'

exec School_Search_Address 'mohandeseen'

exec School_Search_Type 'international'

--2
exec School_By_Level 

--3 
exec View_Schools_Review_Teachers 'Manor House School'

-- administrator

--1 
exec View_Teacher_Employees 'Manor House School'



exec Assign_User_name_To_Teachers  1,'Ahmed', '423356677'


exec Update_Teacher_Salary  1 , 'international'


--2


exec View_Students  'Manor House School'

exec  Assign_User_Name_students 'Geo', 'banana', 888444775

--3

exec Create_Admin_in_my_School 'zamalk 2nd street', 'F','theBestNelly@yahoo.com', 'Nelly','mansour','Helmy', 'Admin_Nelly','1245iop','1979-7-8', 'Manor House School American'


--4 
exec Delete_Student 2;
exec Delete_Employee 2;

--5
exec Edit_school 'Manor House School American', 'our mission is to educate children, and teach them to think independently and use critical thinking whenver possible',
14000,'our vision is to have a bully free school environment where chilldren of all races and religions can have an educational education','MHSA@gmail.com','international',
'mohandeseen 1st street', 'our school is great!','English','all levels'

--6
exec Create_Anouncment   'Cupcake Sale','2016-5-30','come help us raise funds and eat delecious cupcakes','fund raiser',1

--7

exec Create_Activity  'a2 Yard','2016-5-30','fun activity','gloves','we will plant plants'
exec Assign_Activity_To_Teacher 1,7,1
--8
exec  Change_Teacher_Activity 1,4

--9

 exec Assign_Teacher_School 7,1,'Psychology'
--10

exec Assign_Supervisor 3,4

--11

exec Accepts_Reject_Students 'Morad','Manor House School',888444775,'accept'


--as a teacher

--1
exec TeacherSignup 'tagamoo al kams','F','randa.Tarik@gmail.com','randa','wakil','Tarik','1995-5-6'

--2

exec View_my_Courses 7

--3
exec Post_assignment  '2016-1-1','2016-1-4','1+1=?',7,1,'Psychology'

--4 
exec View_Assignment_solutions 1

--5
exec Grade_assignment  1,888444775,100

--6
exec Delete_Assignments 1
exec Post_assignment  '2016-1-1','2016-1-4','1+1=?',7,1,'Psychology' -- to have an assignment 

--7 
exec Create_Report '2016-1-1','report content','He is a great student',7,888444775

--8
exec View_Questions 'Psychology',1

--9
exec Answer_questions 1, 1,'Psychology', 'very interesting question... the answer is...'

--10
exec View_Students_By_Grades 7

--11
exec View_Activity_less_Students

--12 
exec View_Students_With_Most_Clubs

--parent 

--1
exec ParentSignup   'mohandeseen 31 street',981273182,'yasmin.mahmoud@gmail.com','yasmin','mamdouh','Yasmin M','pencils Break'
exec ParentMobile 38497239,'Yasmin M'

--2
exec Apply_Children_School 777778324,'marawan','M','2010-12-22','Manor House School American' ,'Yasmin M',9

update Parents_appliesIn_Schools_for_Students set acceptance_status = 'Accept' where student = 777777324

--3 
exec View_Accepted_Schools 777777324

--4
exec Choose_School 777777324, 'Manor House School American'

--5
 exec View_Child_Reports 888444775

 --6
 exec Reply_Post_About_Child '2016-1-1', 'Yasmin M','that is great',888444775


 --7
 exec View_Children_Schools  'Yasmin M'

 --8

 insert into Parent_of_Student values ('Yasmin M',888444775)

 exec View_Announcment  'Yasmin M'

 --9 
 exec Rate_Teachers 'Yasmin M', 7, 9
 --10
 exec Review_School 'Manor House School American' ,'Yasmin M', 'decent school'

 --11
 exec Delete_My_Review 'Manor House School American' ,'Yasmin M'

 --12
 exec View_OverAll_Teacher_Rating 7

 --13
 exec View_Most_reviews 'Morad'
 exec View_Most_Students 'Samir'
 --14
 

 --as a student 

 --1 
 
 exec Update_Student_info 888444775,'George', 'i_dont_like_apples', 'M','2002-7-13','Manor House School'

 --2 
 insert into Student_enrolledIn_level

 exec View_My_Courses_Grade 888444775

 --3 
 exec  Post_Questions  'what is the meaning of life', 'Psychology',1
  exec  Post_Questions  'what is the meaning of death', 'Psychology',1
 --4

 exec  View_All_Questions  'Psychology',1



insert into Course_learnedBy_Student_taughtBy_Teacher values (888444775,'High',7,1,'Psychology')
 
 
 --5

 exec View_My_Assignments 888444775
 select * from Assignments

 --6 

 exec Solve_Assignment 888444775,2,'best solution evenr'

 --7 
 exec View_Grades 2 ,888444775

 --8
 exec View_Announcment_Student 888444775

 --9
 exec View_Activities 'Manor House School'

 --10 
 exec Apply_for_Activities 888444775,1
 --11
 
 exec Join_Club 'chess club','Manor House School',888444775

 --12 

 exec View_My_Courses_name 888444775
 exec View_My_Courses_id  888444775