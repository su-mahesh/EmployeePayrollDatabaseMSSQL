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
Start_Date	Date
)

--UC3 Ability to create employee table data
insert into Employee_Payroll(Name, Salary, Start_Date) values
('Bil', 100000, '2018-01-03'),
('Terisa', 200000, '2019-11-13'),
('Charlie', 300000, '2020-05-21');

--UC4 Ability to retrieve all the employee payroll data
select * from Employee_Payroll

--UC5 Ability to retrieve salary data for particular employee
-- as well employees who joined in particular data range
select salary from Employee_Payroll where Name = 'Terisa';
select * from Employee_Payroll where Start_Date	between '2018-01-01' and GETDATE();

--UC6 Ability to add gender to employee payroll table
alter table Employee_Payroll add Gender char(1)
update Employee_Payroll set Gender = 'M' where Name = 'Charlie' or Name = 'Bil'
update Employee_Payroll set Gender = 'M' where Name = 'Rahul' or Name = 'Nitesh' or Name= 'Mahesh'

--UC7 Ability to find sum avg min max and number of male female employee
select sum(salary) as total_salary from Employee_Payroll
select avg(salary) as average_salary from Employee_Payroll
select min(salary) as min_salary from Employee_Payroll
select max(salary) as max_salary from Employee_Payroll
select count(salary) as salary_count from Employee_Payroll

select sum(salary) as total_salary from Employee_Payroll group by Gender
select count(*) as salary_count from Employee_Payroll group by Gender
select max(salary) as max_salary from Employee_Payroll group by Gender

--UC8 Ability to extend Employee_Payroll to store phone number, address, department
alter table Employee_Payroll add phone_number bigint, address varchar(255) default('pune'), department varchar(255) not null default('null')

--UC9 Ability to extend Employee_Payroll to store Basic Pay, Deductions, Taxable Pay, Income Tax, Net Pay
alter table Employee_Payroll add Basic_Pay int, Deduction int, Taxable_Pay int, Income_Tax int, Net_Pay int

select * from Employee_Payroll
