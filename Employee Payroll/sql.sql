--UC1 Ability to create employee payroll database
create database EmployeePayroll
SELECT name, database_id, create_date FROM sys.databases ;  
use EmployeePayroll;

--UC2 Ability to create employee table
create Table Employee_Payroll
(
ID			int	identity(1, 1),
Name		varchar(255) NOT Null,
Salary		Money,
Start_Date	Date,
primary key(ID)
)

--UC3 Ability to create employee table data
insert into Employee_Payroll(Name, Salary, Start_Date) values
('Bil', 100000, '2018-01-03'),
('Terissa', 200000, '2019-11-13'),
('Charlie', 300000, '2020-05-21');

--UC4 Ability to retrieve all the employee payroll data
select * from Employee_Payroll

--UC5 Ability to retrieve salary data for particular employee
-- as well employees who joined in particular data range
select salary from Employee_Payroll where Name = 'Terissa';
select * from Employee_Payroll where Start_Date	between '2018-01-01' and GETDATE();

--UC6 Ability to add gender to employee payroll table
alter table Employee_Payroll add Gender char(1)
update Employee_Payroll set Gender = 'M' where Name = 'Charlie' or Name = 'Bil'
update Employee_Payroll set Gender = 'F' where Gender IS null
--UC7 Ability to find sum avg min max and number of male female employee
select sum(salary) as total_salary from Employee_Payroll
select avg(salary) as average_salary from Employee_Payroll
select min(salary) as min_salary from Employee_Payroll
select max(salary) as max_salary from Employee_Payroll
select count(salary) as salary_count from Employee_Payroll

select Gender, sum(salary) as total_salary from Employee_Payroll group by Gender
select Gender, count(salary) as salary_count from Employee_Payroll group by Gender
select Gender, max(salary) as max_salary from Employee_Payroll group by Gender;

--UC8 Ability to extend Employee_Payroll to store phone number, address, department
alter table Employee_Payroll add Phone_number bigint, Address varchar(255) default('pune'), Department varchar(255) not null default('empty')

--UC9 Ability to extend Employee_Payroll to store Basic Pay, Deductions, Taxable Pay, Income Tax, Net Pay
alter table Employee_Payroll add Deduction int, Taxable_Pay int, Income_Tax int, Net_Pay int
EXEC sp_RENAME 'Employee_Payroll.Salary', 'Basic_Pay', 'column'

--UC10 Ability to make terissa as part of sales and marketing department 
update Employee_Payroll set Department = 'sales'  where Name  = 'Terissa'
insert into Employee_Payroll(Name, Department) values('Terissa', 'marketing')

--UC11 Ability to implement er diagram 
-- normalize database
select ID, Basic_Pay, Deduction, Taxable_Pay, Income_Tax, Net_Pay into Payroll from Employee_Payroll
select * from Payroll
alter table Payroll add foreign key(ID) references Employee_Payroll(ID)
alter table Employee_Payroll drop column Basic_Pay, Deduction, Taxable_Pay, Income_Tax, Net_Pay;

select ID into Company from Employee_Payroll
select * from Company

select ID, Department into Department from Employee_Payroll
alter table Department add foreign key(ID) references Employee_Payroll(ID)

ALTER TABLE Employee_Payroll DROP CONSTRAINT DF__Employee___Depar__3C69FB99
alter table Employee_Payroll drop column Department

select * from Payroll;
select * from Department;
select * from Company;

--UC12 make sure all retrieve queries work
select * from Employee_Payroll;
select Basic_Pay from Payroll where ID = (select ID from Employee_Payroll where Name = 'Terissa')
select * from Employee_Payroll where Start_Date	between '2018-01-01' and GETDATE();

--retrieve data queries
select avg(Basic_Pay) as average_Basic_Pay from Payroll
select Gender, sum(Basic_Pay) as total_Basic_Pay from Payroll, Employee_Payroll where Payroll.ID = Employee_Payroll.ID group by Gender
select Gender, count(Basic_Pay) as salary_Basic_Pay from Payroll, Employee_Payroll where Payroll.ID = Employee_Payroll.ID group by Gender
select Gender, max(Basic_Pay) as max_Basic_Pay from Payroll, Employee_Payroll where Payroll.ID = Employee_Payroll.ID group by Gender;
select Gender, min(Basic_Pay) as min_Basic_Pay from Payroll, Employee_Payroll where Payroll.ID = Employee_Payroll.ID group by Gender;

select Basic_Pay from Payroll, Employee_Payroll where Payroll.ID = Employee_Payroll.ID and Name = 'Terissa'
--OR
select Basic_Pay from Payroll where ID = (select ID from Employee_Payroll where Name = 'Terissa')

select * from Employee_Payroll, Department where Employee_Payroll.ID = Department.ID and Start_Date	between '2018-01-01' and GETDATE();

update Employee_Payroll set Gender = 'M' where Name = 'Charlie' or Name = 'Bil'
