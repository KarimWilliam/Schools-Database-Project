 use SSchools6

go
-- AS A SYSTEM ADMIN

--1 create a school 

create proc Create_School 
@name VARCHAR(50), 
@mission VARCHAR(300),
@fees float,
@vision VARCHAR(300),
@e_mail VARCHAR(30) ,
@type varchar(15),
@address varchar(100) ,
@general_information varchar(300),
@main_language varchar(15),
@level varchar(30) 
as
if @name is null print 'schools must have names' else 
insert into Schools values (@name,@mission,@fees,@vision,@e_mail,@type,@address,@general_information,@main_language,@level);
go
 
 --2 add  levels and courses
 create proc Create_Level
 @name varchar(30)
 as 
 if @name is null print 'levels must have a name'
 else insert into Levels values (@name);
 go

 create proc Create_Course
@name varchar (20),
@description varchar(200),
@grade int,
@level varchar(30)
as 
if  @name is null print 'Courses must have a name ' else 
insert into Courses values (@name,@description,@grade,@level);
go
--3 add admin without school 
create proc Create_Administrator

@address varchar(100),
@gender varchar(1),
@e_mail varchar(50),
@first_name varchar(20),
@middle_name varchar(20),
@last_name varchar(20),
@user_name varchar (20),
@password varchar(20),
@birth_date smalldatetime
as
insert into Employees (address,gender,e_mail,first_name,middle_name,last_name,user_name,password,birth_date)
values (@address,@gender,@e_mail,@first_name,@middle_name,@last_name,@user_name,@password,@birth_date);
declare @latest_id int;
select @latest_id = max(e_id) from Employees;
insert into Administrator values(@latest_id);
go

--assigning an admin to a school given the school name

create proc Assign_Admin_To_School 
@e_id int,
@school varchar (50)
as 
declare @salary int;
declare @schooltype varchar(15);
select @schooltype = type from Schools where name = @school;
if @schooltype = 'national'
update Employees set school = @school, salary = 3000 where Employees.e_id = @e_id
else
update Employees set school = @school, salary = 5000 where Employees.e_id = @e_id
go

--4 Deleteing a school from the database

create proc Delete_School 
@name varchar(50)
as
update Employees set user_name = null, password = null  where Employees.school = @name;
delete from schools where name = @name;
go

 -- AS A SYSTEM USER

 --1 Search for a school by different things
 create proc School_Search_Name 
 @name varchar(50)
 as select * from Schools where name = @name; 
 go

 create proc School_Search_Address 
 @address varchar(50)
 as select * from Schools where Address = @address;
  go

 
 create proc School_Search_Type 
 @type varchar(50)
 as select * from Schools where type = @type;
  go

 --2 search for school by level
 create proc School_By_Level
 as
 select * from Schools order by level
 go

 --3 search for Schools + reviews + teachers 

 create proc View_Schools_Review_Teachers
 @name varchar (50)
 as
 select s.*,r.*, e.e_id, e.first_name as 'Teacher''s first name', e.last_name as 'teacher''s last name',e.e_mail, e.birth_date
 from Schools s inner  join Parents_reviews_Schools r on r.school = s.name inner join Employees e on e.school = s.name inner join Teachers t on t.e_id = e.e_id
 where s.name = @name
 go

 
 --AS AN ADMINISTRATOR 

 --1 view employees , assign username to teachers, update teacher's salaries
 create proc View_Teacher_Employees
 @my_school varchar(50)
 as 
 select * 
 from Teachers inner join Employees on Teachers.e_id = Employees.e_id
 where Employees.school = @my_school
go


 create proc Assign_User_name_To_Teachers
@e_id int,
@new_user_name varchar(20),
@new_password varchar(20)
as 
update Employees set  user_name = @new_user_name, password = @new_password where Employees.e_id = @e_id
go

Create proc Update_Teacher_Salary
@e_id int,
@type varchar(50)
as
declare @years_exp smallint
declare @Salary int
select @years_exp = experience_years from Teachers  where Teachers.e_id = @e_id;
if (@type = 'national')
set @Salary = @years_exp * 500 +3000
else 
if (@type = 'international')
set @Salary = @years_exp * 500 +5000;

update Employees set salary = @Salary
go


--2 view students and assign to them usernames and passwords
create proc View_Students
@my_school varchar(50)
as 
select Students.* 
from Students
where Students.school = @my_school
go

create proc Assign_User_Name_students
@new_user_name varchar(20),
@new_password varchar(20),
@ssn int
as
update Students set Students.user_name = @new_user_name, Students.password=@new_password where Students.ssn = @ssn
go

--3 add admins to my school 
create proc Create_Admin_in_my_School
@address varchar(100),
@gender varchar(1),
@e_mail varchar(50),
@first_name varchar(20),
@middle_name varchar(20),
@last_name varchar(20),
@user_name varchar (20),
@password varchar(20),
@birth_date smalldatetime,
@my_school varchar(50)
as
declare @type varchar(20)
select @type = type from Schools where name = @my_school;
declare @salary int 
set @salary = 5000
if @type = 'national' set @salary = 3000


insert into Employees (address,salary,gender,e_mail,first_name,middle_name,last_name,user_name,password,birth_date,school)
values (@address,@salary,@gender,@e_mail,@first_name,@middle_name,@last_name,@user_name,@password,@birth_date,@my_school);
declare @latest_id int;
select @latest_id = max(e_id) from Employees;
insert into Administrator values(@latest_id);
go

--4 deleteing employees and students 

create proc Delete_Student
@ssn int 
as 
delete from Students where ssn = @ssn
go


create proc Delete_Employee
@e_id int 
as 
delete from Employees where e_id = @e_id 
go

--5 edit the information of a school 

create proc Edit_school 
@name VARCHAR(50) ,
@mission VARCHAR(300),
@fees float,
@vision VARCHAR(300),
@e_mail VARCHAR(30) ,
@type varchar(15),
@address varchar(100),
@general_information varchar(300),
@main_language varchar(15),
@level varchar(30)
as
 update  Schools set mission = @mission, fees=@fees, vision = @vision, e_mail=@e_mail, type=@type,address = @address, general_information = @general_information,main_language =@main_language,level=@level
  where Schools.name = @name 
  go

  --6 create an announcment 
  create procedure Create_Anouncment 
@title varchar(20),
@date smalldatetime,
@decription varchar(300),
@type varchar(20),
@e_id int 
as
insert into Announements values (@title,@date,@decription,@type,@e_id)
go


--7 create an activity  
create proc Create_Activity 
@location varchar(50),
@date smalldatetime,
@type varchar(20),
@equipment varchar(50),
@description varchar(300)
as 
insert into Activities values (@location,@date,@type,@equipment,@description)
go
--assign it to  teacher
create proc Assign_Activity_To_Teacher
@admin_id int,
@teacher_id int,
@act_id int
as
insert into Activity_createdBy_Administrator_andAssignedTo_Teacher values (@admin_id,@teacher_id,@act_id)
go

--8 Change Teacher assigned to an activity

create proc Change_Teacher_Activity
@act_id int,
@teacher_id int
as 
update Activity_createdBy_Administrator_andAssignedTo_Teacher set teacher_id = @teacher_id 
go

--9 Assign teachers to courses that are taught in my school based on the levels it offers

create proc Assign_Teacher_School
@teacher_id int, 
@course_id int ,
@course_name varchar(20)
as 
insert into Courses_taughtBy_Teachers values (@teacher_id,@course_id,@course_name)
go

--10 Assign teachers to be supervisors to other teachers

create proc Assign_Supervisor
@e_id int,
@e_id_supervisor int
as
declare @texp int;
select @texp = experience_years from Teachers where Teachers.e_id = @e_id_supervisor;
if @texp<15
print 'supervisor experiene years must exceed 15 years' 
else update Teachers set supervisor  = @e_id_supervisor where e_id = @e_id;
go

--11 accept or reject applications by parents 

create proc Accepts_Reject_Students
@parent varchar (20),
@school varchar (50),
@student int,
@acceptance_status varchar(10)
as
insert into Accept_Reject_Students values (@parent,@school,@student,@acceptance_status)
go

-- AS A TEACHER

--1 sign up 
create proc TeacherSignup
@address varchar(100),
@gender varchar(1),
@e_mail varchar(50) ,
@first_name varchar(20),
@middle_name varchar(20),
@last_name varchar(20),
@birth_date smalldatetime
as
insert into Employees (address,gender,e_mail,first_name,middle_name,last_name,birth_date) values (@address,@gender,@e_mail,@first_name,@middle_name,@last_name,@birth_date);
declare @latest_id int;
select @latest_id = max(e_id) from Employees;
insert into Teachers (e_id) values (@latest_id)
go

--2  view teachers courses by level and grade 
create proc View_my_Courses
@teacher_id int
as
select c.*,ct.* from Courses_taughtBy_Teachers ct inner join Courses c on c.code = ct.course_id and c.name = ct.course_name 
where ct.teacher_id = @teacher_id 
order by c.grade, c.level
go

--3 post assignments on my courses 
create proc Post_assignment 
@posting_date smalldatetime,
@due_date smalldatetime,
@content varchar(max),
@teacher_id int ,
@course_id int,
@course_name varchar(20)
as
insert into Assignments values (@posting_date,@due_date,@content,@teacher_id,@course_id,@course_name)
go

-- 4 view assignment solutions ordered by student ssn

create proc View_Assignment_solutions
@assignment_id int
as
select * from Assignment_solvedBy_Student where assignment_id = @assignment_id
order by student_ssn
go


--5 Grade students soution 
create proc Grade_assignment 
@assignment_id int,
@student_ssn int ,
@grade smallint 
as
update  Assignment_solvedBy_Student  set grade = @grade
where assignment_id = @assignment_id and student_ssn = @student_ssn
go

--6 Delete assignments 
create proc Delete_Assignments
@assignment_id int
as
delete from Assignments where assignment_id = @assignment_id
go
--7 Write  reports about  student

create proc Create_Report 
@date smalldatetime,
@content varchar (200),
@teacher_comments varchar(200), 
@teacher_id int,
@student_ssn int
as
insert into Report values (@date,@student_ssn,@content,@teacher_comments);
insert into Report_on_Student_by_Teacher values (@date,@teacher_id,@student_ssn)
go
--8  View the questions asked by the students for each course I teach

create proc View_Questions 
@course_name varchar(20),
@course_code int
as
select * from Questions where course_code = @course_code and course_name = @course_name
go
--9 Answer Questions 
create proc Answer_questions
@question int,
@course_code int,
@course_name varchar(20),
@answer varchar(300)
as
update Questions set answer = @answer where question_num = @question and course_code = @course_code and course_name = @course_name
go

--10  View list of students ordered by grades then name 

Create proc View_Students_By_Grades
@teacher_id int
as 
select s.* from Students s inner join Schools on s.school = Schools.name inner join Employees on Schools.name = Employees.school inner join Teachers on Teachers.e_id = Employees.e_id 
 inner join Student_enrolledIn_level  on Student_enrolledIn_level.student_ssn = s.ssn
where Teachers.e_id = @teacher_id
order by Student_enrolledIn_level.grade, s.name
go
--11 view list of s tudents that did not join any activity 

create proc View_Activity_less_Students
as 
select * from Students except 
select s.* from Students s inner join  Activity_joinedBy_Student ajs  on s.ssn =  ajs.student_ssn
go


--12 Display the name of the high school student who is currently a member of the greatest number of clubs

create proc View_Students_With_Most_Clubs
as
select s.name,count(*) as r from Students s inner join Clubs_joinedBy_Students cjs on s.ssn = cjs.student 
group by s.name
order by r desc
go

--AS A PARENT

--1 sign up
create proc ParentSignup

@address varchar(100), 
@home_number int,
@e_mail varchar(50),
@first_name varchar(15),
@last_name varchar(15),
@user_name varchar (20),
@password varchar (20)
as
insert into Parents (user_name,password,address,home_number,e_mail,first_name,last_name) values (@user_Name,@password,@address,@home_number,@e_mail,@first_name,@last_name)
go

create proc ParentMobile
@mobile_number int,
@user_name varchar(20)
as
insert into Mobile_Numbers_of_Parents values (@user_name,@mobile_number) 
go

--2 Apply for child in a school 

create proc Apply_Children_School
@ssn int ,
@name varchar (20), 
@gender varchar (1),
@birth_date smalldatetime,
@school varchar(50),
@parent varchar(20),
@grade int
as 
declare @level varchar(30)
select @level = level from Schools where Schools.name = @level 
insert into Students (ssn,name,gender,birth_date) values (@ssn,@name,@gender,@birth_date)
insert into Parents_appliesIn_Schools_for_Students (parent,school,student)values (@parent,@school,@ssn)
insert into Parent_of_Student values (@parent,@ssn)
insert into Student_enrolledIn_level values (@ssn,@grade,@level)

go

--3 View a list of schools that accepted my children categorized by childcreate proc View_Accepted_Schools@ssn intasselect *  from Parents_appliesIn_Schools_for_Students p where p.student = @ssn and p.acceptance_status = 'Accept'go
--4 Choose one of the schools that accepted my child to enroll him/her

create proc Choose_School
@ssn int,
@school varchar(50)
as
update Students  set school = @school where Students.ssn = @ssn
go


--5 View reports written about my children by their teachers.
create proc View_Child_Reports
@ssn int
as 
select * from Report where Report.ssn = @ssn 
go
--6  Reply to reports written about my children

create proc Reply_Post_About_Child 
@report_date smalldatetime,
@parent_username varchar(20),
@reply varchar(300),
@ssn int
as
insert into  Parent_repliesOn_Report values (@report_date,@parent_username,@reply,@ssn)
go

--7 View a list of all schools of all my children ordered by its name.

create proc View_Children_Schools 
@username varchar(20)
as
select Schools.* from Schools inner join Students on Students.school = Schools.name inner join Parents_appliesIn_Schools_for_Students pss on pss.parent =@username
order by Schools.name
go



--8 View the announcements posted within the past 10 days about a school if one of my children is
create proc View_Announcment @username varchar (20)asDECLARE @Now DATETIME = GETDATE();
DECLARE @10DaysAgo DATETIME = DATEADD(day,-10,@Now);select * from Announements a inner  join Administrator admin on admin.e_id = a.e_id inner join Employees on admin.e_id = Employees.e_id inner join Schools on Employees.school = Schools.name inner join Students on Students.school = Schools.name inner join Parent_of_Student on Parent_of_Student.student_ssn = Students.ssn where Parent_of_Student.parent_username = @username and a.date  BETWEEN @10DaysAgo AND @Now;go--9 Rate any teacher that teaches my childrencreate proc Rate_Teachers@username varchar(20),@teacher_id int,@rating intasinsert into Parents_rate_Teachers values (@teacher_id,@username,@rating)go--10 Write reviews about my children’s schoolcreate proc Review_School @school varchar(50),
@parent varchar(20),
@review_text varchar(500)asinsert into Parents_reviews_Schools values (@school,@parent,@review_text)go--11  Delete a review that i have written.create proc Delete_My_Review@school varchar (50),@parent varchar(20)asdelete from Parents_reviews_Schools where parent = @parent and school = @schoolgo--12 View the overall rating of a teachercreate proc View_OverAll_Teacher_Rating@teacher_id intasselect avg(rating) from Parents_rate_Teachers where teacher_id = @teacher_idgo--13 View the top 10 schools with the highest number of reviews or highest number of enrolled studentscreate proc View_Most_reviews@username varchar(20)asselect top 10 s.school,count(*) as counts from Parents_reviews_Schools s inner join Parent_of_Student pof on pof.parent_username = s.parent inner join Students on Students.ssn = pof.student_ssn inner join Parent_of_Student on Students.ssn = Parent_of_Student.student_ssn where Parent_of_Student.parent_username <> @username group by s.school order by countsgo-- view top 10 schools with the highest number of students create proc View_Most_Students@username varchar (20)asselect top 10 s.name, count(*)as counts from Schools s inner join Students st on st.school = s.name inner join Parent_of_Student pof on pof.student_ssn = st.ssn where pof.parent_username <> @usernamegroup by s.nameorder by countsgo--14   Find the international school which has a reputation higher than all national schools, i.e. has the highest number of reviews-- i dont get it --AS AN ENROLLED STUDENT--1 Update my account information 

create proc Update_Student_info
@ssn int,
@name varchar (20),
@password varchar(20) ,
@gender varchar (1),
@birth_date smalldatetime,
@school varchar(50)
as 
update Students set name = @name, password = @password,gender = @gender, birth_date =@birth_date, school = @school where ssn = @ssn 
go  

--2 View a list of courses’ names assigned to me based on my grade ordered by name   NEEDS FIXING 

create proc View_My_Courses_Grade
@ssn int
as
select * from Courses  inner join Course_learnedBy_Student_taughtBy_Teacher  x on x.course_id = Courses.code and x.course_name = Courses.name inner join Student_enrolledIn_level se  on  se.student_ssn = x.student_ssn
where x.student_ssn = @ssn
order by se.grade
go

--3  Post questions I have about a certain course

create proc Post_Questions 
@question varchar(300),
@course_name varchar(20),
@course_code int
as
insert into Questions (question,course_name,course_code) values (@question,@course_name,@course_code)
go

--4 View all questions asked by other students on a certain course

create proc View_All_Questions 
@course_name varchar(20),
@course_code int
as
select * from Questions where course_code = @course_code and course_name = @course_name
go

--5 View the assignments posted for the courses I take

create proc View_My_Assignments 
@ssn int
as
select * from Assignments a inner join courses c  on a.course_name = c.name and c.code = a.course_id inner join  Course_learnedBy_Student_taughtBy_Teacher  cls on cls.course_id =a.course_id and cls.course_name =a.course_name 
inner join Students on cls.student_ssn = Students.ssn 
where Students.ssn = @ssn
go
--6  Solve assignments posted for courses I take.

create proc Solve_Assignment
@ssn int,
@assignment_id int,
@solution varchar(max)
as
update Assignment_solvedBy_Student  set Assignment_solvedBy_Student .solution = @solution where Assignment_solvedBy_Student.student_ssn = @ssn and Assignment_solvedBy_Student.assignment_id = @assignment_id
go

--7 View the grade of the assignments I solved per course

create proc View_Grades
@assignment_id int,
@student_ssn int 
as
select * from Assignment_solvedBy_Student where assignment_id = @assignment_id and student_ssn = @student_ssn

go

--8 View the announcements posted within the past 10 days about the school I am enrolled in

create proc View_Announcment_Student@ssn intasDECLARE @Now DATETIME = GETDATE();
DECLARE @10DaysAgo DATETIME = DATEADD(day,-10,@Now);select * from Announements a inner  join Administrator admin on admin.e_id = a.e_id inner join Employees on admin.e_id = Employees.e_id inner join Schools on Employees.school = Schools.name inner join Students on Students.school = Schools.name where Students.ssn =@ssn and a.date  BETWEEN @10DaysAgo AND @Nowgo--9 View all the information about activities offered by my school, as well as the teacher responsible for itcreate proc View_Activities@school varchar(50)asselect a.*,Employees.first_name,Employees.last_name  from Activities a inner join Activity_createdBy_Administrator_andAssignedTo_Teacher Ac on Ac.act_id = a.act_id inner join Teachers on ac.teacher_id = Teachers.e_id inner join Employees on Employees.e_id = Teachers.e_id go --10 Apply for activities  create proc Apply_for_Activities  @ssn int , @activity_id int as insert into Activity_joinedBy_Student values (@activity_id,@ssn) go --11  Join clubs offered by my school, if I am a highschool student create proc Join_Club @club_name varchar(20),
@club_school_name varchar(50),
@student intasdeclare @level varchar(10)select @level =level from Student_enrolledIn_level   where Student_enrolledIn_level.student_ssn = @studentif @level <> 'High' print 'you must be in high school to enter clubs'else insert into Clubs_joinedBy_Students values (@club_name,@club_school_name,@student)go --12 Search in a list of courses that i take by its name or code. create proc View_My_Courses_name @ssn int  as select  * from Course_learnedBy_Student_taughtBy_Teacher x  where  x.student_ssn = @ssn  order by x.course_name go create proc View_My_Courses_id  @ssn int  as select  * from Course_learnedBy_Student_taughtBy_Teacher x  where  x.student_ssn = @ssn  order by x.course_id