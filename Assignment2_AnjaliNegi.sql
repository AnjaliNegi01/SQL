--Anjali Negi
--Assignment: 02
--Student Information system

create database Sis;
use [Sis];
--creating tables

--1. Students Table


create table Students(
student_id int Primary Key,
first_name varchar (30),
last_name varchar (30),
date_of_birth date,
email varchar (30),
phone_number char(10)
);


--2. teacher table

create table Teacher(
teacher_id int Primary Key,
first_name varchar(30),
last_name varchar(30),
email varchar(50),
);


--3. Course table

create table Courses(
course_id int Primary Key,
course_name varchar (20),
credits int,
teacher_id int Foreign Key (teacher_id) references [dbo].[Teacher] ([teacher_id])
);

--4. enrollment table

create table Enrollments(
enrollment_id int Primary Key,
student_id int Foreign Key (student_id) references [dbo].[Students] ([student_id]),
course_id int Foreign Key (course_id) references [dbo].[Courses] ([course_id]),
enrollment_date date
);


--5. Payments table

create table Payments(
payment_id int Primary Key,
student_id int Foreign Key (student_id) references [dbo].[Students] ([student_id]),
amount decimal(10,2),
payment_date date
);

--inserting data into table
/*a) Insert at least 10 sample records into each of the following tables.
• Students
• Courses
• Enrollments
• Teacher
• Payments*/

--1. student table

insert into [dbo].[Students] ([student_id],[first_name],[last_name],[date_of_birth],[email],[phone_number])
values
(10, 'Anoop', 'Rajput', '2002-06-19','anoop@gmail.com','1110102506'),
(7, 'Deepa', 'Sinha', '1998-12-13','deepasinha@gmail.com','8876543211'),
(8, 'Sumit', 'Rawat', '1997-01-27','sumiitrawat@gmail.com','1021234045'),
(9, 'Shikha', 'Gupta', '1998-12-01','shikhagupta@gmail.com','9885521230');
(10, 'James', 'William', '2001-11-30','jameswilliam@gmail.com','1234560987');


select * from [dbo].[Students];
--2. teacher table

insert into [dbo].[Teacher] ([teacher_id],[first_name],[last_name],[email])
values
(4, 'Navin', 'Negi', 'navinnegi@email.com'),
(5, 'Aishwarya', 'Singh', 'aishwarya@email.com'),
(6, 'Rajat', 'Singh', 'rajatsingh@email.com');

select * from [dbo].[Teacher];


--3. Course table
insert into [dbo].[Courses] ([course_id],[course_name],[credits],[teacher_id])
values
(107, 'History', 5, 4),
(102, 'Chemistry', 5, 5),
(103, 'English', 4, 2),
(104, 'Computer Science', 3, 6),
(105, 'Physics', 3, 1),
(106, 'Biology', 2, 3);

--4. enrollment table

insert into [dbo].[Enrollments] ([enrollment_id],[student_id],[course_id],[enrollment_date])
values
(10,10,101,'2022-12-30'),
(2,2,102,'2022-10-13'),
(3,3,103,'2023-05-30'),
(4,4,104,'2023-09-11'),
(5,5,105,'2023-03-15'),
(6,6,106,'2023-02-28'),
(7,7,102,'2023-02-01'),
(8,8,103,'2023-01-20'),
(9,9,103,'2023-01-15');

--5. payments table

insert into [dbo].[Payments] ([payment_id],[student_id],[amount],[payment_date])
values
(210,10,500.00,'2023-01-15'),
(202,2,600.00, '2022-12-01'),
(203,3,550.00, '2023-05-30'),
(204,4,700.00, '2023-10-10'),
(205,5,800.00, '2023-03-30'),
(206,6,450.00, '2023-02-28'),
(207,7,550.00, '2023-02-27'),
(208,8,550.00, '2023-01-27'),
(209,9,400.00, '2023-01-20');



--b) Write SQL queries for the following tasks:


--1. Write an SQL query to insert a new student into the "Students" table with the following details:
/*a. First Name: John
  b. Last Name: Doe
  c. Date of Birth: 1995-08-15
  d. Email: john.doe@example.com
  e. Phone Number: 1234567890*/

insert into [dbo].[Students] ([student_id],[first_name],[last_name],[date_of_birth],[email],[phone_number])
values
(11, 'John', 'Doe', '1995-08-15','doe@example.com','1234567890');



--2. Write an SQL query to enroll a student in a course. Choose an existing student and course and 
--insert a record into the "Enrollments" table with the enrollment date.

declare @StuId int, @Cid int;
set @StuId=11;
set @Cid=106;

insert into [dbo].[Enrollments] ([enrollment_id],[student_id],[course_id],[enrollment_date])
values
(11,@StuId,@Cid,'2023-12-01');



--3. Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and modify their email address.

update [dbo].[Teacher] set [email]='profnavin@email.com' where [teacher_id]=4;

select * from [dbo].[Teacher];

--4. Write an SQL query to delete a specific enrollment record from the "Enrollments" table. Select an enrollment record based on student and course.

declare @Stid int, @Crid int;
set @Stid=1;
set @Crid=101;

delete from [dbo].[Enrollments] where [student_id]=@Stid and [course_id]=@Crid;
select * from [dbo].[Enrollments];

--5. Update the "Courses" table to assign a specific teacher to a course. Choose any course and teacher from the respective tables.
update [dbo].[Courses] set [teacher_id]=1 where [course_id]=107;


--6. Delete a specific student from the "Students" table and remove all their enrollment records
--from the "Enrollments" table. Be sure to maintain referential integrity.
declare @studentid int;
set @studentid=10;
delete from  [dbo].[Payments] where [student_id]=@studentid;
delete from [dbo].[Enrollments] where [student_id]=@studentid;
delete from [dbo].[Students] where [student_id]=@studentid;



--7. Update the payment amount for a specific payment record in the "Payments" table. Choose any payment record and modify the payment amount.
update [dbo].[Payments] set [amount]=700, [payment_date]='2023-05-11' where [amount]=400;
select * from [dbo].[Payments];


--4. Joins:


--1. Write an SQL query to calculate the total payments made by a specific student. You will need to
--join the "Payments" table with the "Students" table based on the student's ID.

select S.[student_id], S.[first_name], S.[last_name], sum(P.[amount]) as total_amount from [dbo].[Students] as S
join [dbo].[Payments] as P on P.[student_id]=S.[student_id]
group by S.[student_id],S.[first_name],S.[last_name];



--2. Write an SQL query to retrieve a list of courses along with the count of students enrolled in each course.
--   Use a JOIN operation between the "Courses" table and the "Enrollments" table.

select C.[course_name],count(E.[student_id]) as No_of_students from [dbo].[Courses] as C
left join [dbo].[Enrollments] as E on E.[course_id]=C.[course_id]
group by C.[course_name];


--3. Write an SQL query to find the names of students who have not enrolled in any course. Use a
--   LEFT JOIN between the "Students" table and the "Enrollments" table to identify students without enrollments.

select S.[first_name], S.[last_name] from [dbo].[Students] as S
left join [dbo].[Enrollments] as E on E.[student_id]=S.[student_id]
where S.[student_id] not in(select [student_id] from [dbo].[Enrollments]);


--4. Write an SQL query to retrieve the first name, last name of students, and the names of the courses they are enrolled in.
--   Use JOIN operations between the "Students" table and the "Enrollments" and "Courses" tables.

select S.[first_name], S.[last_name], C.[course_name] from [dbo].[Students] as S
join [dbo].[Enrollments] as E on E.[student_id]=S.[student_id]
join [dbo].[Courses] as C on C.[course_id]=E.[course_id];


--5. Create a query to list the names of teachers and the courses they are assigned to. Join the "Teacher" table with the "Courses" table.

select T.[first_name],T.[last_name], C.[course_name] from [dbo].[Teacher] as T
join [dbo].[Courses] as C on C.[teacher_id]=T.[teacher_id];



--6. Retrieve a list of students and their enrollment dates for a specific course. You'll need to join the
--   "Students" table with the "Enrollments" and "Courses" tables.

select S.[first_name],S.[last_name],E.[enrollment_date] from [dbo].[Students] as S
join [dbo].[Enrollments] as E on E.[student_id]=S.[student_id]
join [dbo].[Courses] as C on C.[course_id]=E.[course_id]
where C.[course_name]='English';


--7. Find the names of students who have not made any payments. Use a LEFT JOIN between the "Students" table and the "Payments" table and 
--  filter for students with NULL payment records.

select S.[first_name],S.[last_name] from [dbo].[Students] as S
left join [dbo].[Payments] as P on P.[student_id]=S.[student_id]
where S.[student_id] not in (select [student_id] from [dbo].[Payments]);

select * from [dbo].[Payments];

--8. Write a query to identify courses that have no enrollments. You'll need to use a LEFT JOIN
--   between the "Courses" table and the "Enrollments" table and filter for courses with NULL enrollment records.

select C.[course_name] from [dbo].[Courses] as C
left join [dbo].[Enrollments] as E on E.[course_id]=C.[course_id]
where C.[course_id] not in (select [course_id] from [dbo].[Enrollments]);


--9. Identify students who are enrolled in more than one course. Use a self-join on the "Enrollments" table 
--   to find students with multiple enrollment records.

select S.[first_name],S.[last_name],count(E.[enrollment_id]) as no_of_courses from  [dbo].[Students] as S
join [dbo].[Enrollments] as E on E.[student_id]=S.[student_id]
group by S.[first_name],S.[last_name]
order by no_of_courses desc
offset 0 rows
fetch next 1 rows only;


--10. Find teachers who are not assigned to any courses. Use a LEFT JOIN between the "Teacher" table and the "Courses" table 
--    and filter for teachers with NULL course assignments.

select T.[first_name], T.[last_name] from [dbo].[Teacher] as T
left join [dbo].[Courses] as C on C.[teacher_id]=T.[teacher_id]
where T.[teacher_id] not in (select [teacher_id] from [dbo].[Courses]);



--5. Aggregate Functions and Subqueries:


--1. Write an SQL query to calculate the average number of students enrolled in each course.
--   Use aggregate functions and subqueries to achieve this.

select C.[course_id],C.[course_name], avg(No_of_students_enroll)as Average_students from [dbo].[Courses] as c
left join (select course_id, count(distinct student_id) as No_of_students_enroll
from [dbo].[Enrollments]
group by course_id) E on E.[course_id]=C.[course_id]
group by C.[course_id],C.[course_name];

--2. Identify the student(s) who made the highest payment. Use a subquery to find the maximum
 --  payment amount and then retrieve the student(s) associated with that amount.

 select S.* from [dbo].[Students] as S
 join [dbo].[Payments] as P on P.[student_id]=S.[student_id]
 where P.[amount]=(select max([amount]) from [dbo].[Payments]);


--3. Retrieve a list of courses with the highest number of enrollments. Use subqueries to find the
 --  course(s) with the maximum enrollment count.

select C.[course_id],C.[course_name],count(E.[enrollment_id]) as No_of_enroll from [dbo].[Courses] as C
join [dbo].[Enrollments] as E on E.[course_id]=C.[course_id]
group by C.[course_id],C.[course_name]
order by No_of_enroll desc
offset 0 rows
fetch next 1 rows only;
 
--4. Calculate the total payments made to courses taught by each teacher. Use subqueries to sum
--   payments for each teacher's courses.

select T. [teacher_id],T.[first_name],T.[last_name],sum(P.[amount]) from  [dbo].[Teacher] as T
join [dbo].[Courses] as C on C.[teacher_id]=T.[teacher_id]
join [dbo].[Enrollments] as E on E.[course_id]=C.[course_id]
join [dbo].[Payments] as P on P.[student_id]=E.[student_id]
group by T.[teacher_id],T.[first_name],T.[last_name];



--5. Identify students who are enrolled in all available courses. Use subqueries to compare a
   --student's enrollments with the total number of courses.

   select [student_id],[first_name],[last_name] from [dbo].[Students] 
   where student_id in (select student_id from  [dbo].[Enrollments]);



--6. Retrieve the names of teachers who have not been assigned to any courses. Use subqueries to
--   find teachers with no course assignments.

select [teacher_id],[first_name],[last_name]  from [dbo].[Teacher]
where [teacher_id] not in (select [teacher_id] from [dbo].[Courses]);



--7. Calculate the average age of all students. Use subqueries to calculate the age of each student
--   based on their date of birth.

select avg(S.[Age]) as average_age from (select datediff(year,[date_of_birth],getdate()) as Age
from [dbo].[Students]) as S;


--8. Identify courses with no enrollments. Use subqueries to find courses without enrollment records.

select [course_id],[course_name] from [dbo].[Courses] where [course_id] not in (select [course_id] from  [dbo].[Enrollments]);



--9. Calculate the total payments made by each student for each course they are enrolled in. Use
--   subqueries and aggregate functions to sum payments.

select S.[student_id],S.[first_name],S.[last_name],C.[course_name],sum(P.[amount]) as total_amount from [dbo].[Students] as S
left join [dbo].[Payments] as P on P.[student_id]=S.[student_id]
left join [dbo].[Enrollments] as E on E.[student_id]=P.[student_id]
left join [dbo].[Courses] as C on C.[course_id]=E.[course_id]
group by S.[student_id],S.[first_name],S.[last_name],C.[course_name];


--10. Identify students who have made more than one payment. Use subqueries and aggregate
--    functions to count payments per student and filter for those with counts greater than one.

select [student_id],[first_name],[last_name] from [dbo].[Students] 
where student_id in 
(select student_id from [dbo].[Payments] group by student_id having count(payment_id)>1);



--11. Write an SQL query to calculate the total payments made by each student. Join the "Students"
 --   table with the "Payments" table and use GROUP BY to calculate the sum of payments for each student.

 select S.[student_id],S.[first_name],S.[last_name], sum(P.[amount]) as total_amount from [dbo].[Students] as S
 join [dbo].[Payments] as P on P.[student_id]=S.[student_id]
 group by S.[student_id],S.[first_name],S.[last_name];



--12. Retrieve a list of course names along with the count of students enrolled in each course. Use
    --JOIN operations between the "Courses" table and the "Enrollments" table and GROUP BY to count enrollments.

	select C.[course_id],C.[course_name],count(E.[student_id]) as No_of_students from [dbo].[Courses] as C
	left join [dbo].[Enrollments] as E on E.[course_id]=C.[course_id]
	group by C.[course_id],C.[course_name]; 



--13. Calculate the average payment amount made by students. Use JOIN operations between the
--    "Students" table and the "Payments" table and GROUP BY to calculate the average.

select S.[student_id],S.[first_name],S.[last_name] ,avg(P.amount) as average_payment from [dbo].[Students] as S
join [dbo].[Payments] as P on P.[student_id]=S.[student_id]
group by S.[student_id],S.[first_name],S.[last_name];
