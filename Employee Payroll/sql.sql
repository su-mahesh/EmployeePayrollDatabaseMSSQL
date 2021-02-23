--UC1 Ability to create employee payroll database
create database EmployeePayroll
SELECT name, database_id, create_date FROM sys.databases ;  
use EmployeePayroll;

--UC2 Ability to create employee table
create Table Employee
(
EmpID		int	identity(1, 1),
EmpName		varchar(255) NOT Null,
Salary		Money,
StartDate	Date,
constraint Employee_Primary_Key_EmpID primary key(EmpID)
)

--UC3 Ability to create employee table data
insert into Employee(EmpName, Salary, StartDate) values
('Bil', 100000, '2018-01-03'),
('Terissa', 200000, '2019-11-13'),
('Charlie', 300000, '2020-05-21');

--UC4 Ability to retrieve all the employee payroll data
select * from Employee

--UC5 Ability to retrieve salary data for particular employee
-- as well employees who joined in particular data range
select Salary from Employee where EmpName = 'Terissa';
select * from Employee where StartDate	between '2018-01-01' and GETDATE();

--UC6 Ability to add gender to employee payroll table
alter table Employee add Gender char(1);
update Employee set Gender = 'M' where EmpName = 'Charlie' or EmpName = 'Bil';
update Employee set Gender = 'F' where Gender IS null;

--UC7 Ability to find sum avg min max and number of male female employee
select sum(Salary) as total_salary from Employee
select avg(Salary) as average_salary from Employee
select min(Salary) as min_salary from Employee
select max(Salary) as max_salary from Employee
select count(Salary) as salary_count from Employee

select Gender, sum(salary) as total_salary from Employee group by Gender;
select Gender, count(salary) as salary_count from Employee group by Gender;
select Gender, max(salary) as max_salary from Employee group by Gender;

--UC8 Ability to extend Employee_Payroll to store phone number, address, department
alter table Employee add PhoneNumber bigint, Address varchar(255) default('empty'), Department varchar(255);

--UC9 Ability to extend Employee_Payroll to store Basic Pay, Deductions, Taxable Pay, Income Tax, Net Pay
alter table Employee add Deduction money, TaxablePay money, IncomeTax money, NetPay money

--UC10 Ability to make terissa as part of sales and marketing department 
update Employee set Department = 'sales'  where EmpName  = 'Terissa';
insert into Employee(EmpName, Department) values('Terissa', 'marketing')

--UC11 Ability to implement er diagram 
-- normalize database
exec sp_rename 'Employee.Salary', 'BasicPay', 'COLUMN';
create Table Payroll
(
EmpID		int,
BasicPay	Money,
Deduction	Money,
TaxablePay	Money,
IncomeTax	Money,
NetPay		Money
constraint Payroll_foreign_Key_EmpID foreign key(EmpID) references Employee(EmpID) on delete cascade
)
insert into Payroll select EmpID, BasicPay, Deduction, TaxablePay, IncomeTax, NetPay from Employee;

select * from Employee;
select * from Payroll;

alter table Employee drop column BasicPay, Deduction, TaxablePay, IncomeTax, NetPay;

create Table Company
(
EmpID	int,
EmpName	varchar(255),
constraint Company_foreign_Key_EmpID foreign key(EmpID) references Employee(EmpID) on delete cascade
)
insert into Company select EmpID, EmpName from Employee;

select * from Company

create Table Department
(
EmpID		int,
Department	varchar(255),
constraint Department_foreign_Key_EmpID foreign key(EmpID) references Employee(EmpID) on delete cascade
)
insert into Department select EmpID, Department from Employee;

create Table Department
(
DeptID		int identity(1, 1),
DepartmentName	varchar(255),
constraint Department_primaryKey_DeptID primary key(DeptID)
)
INSERT INTO Department(DepartmentName) values('sales'), ('marketing');
INSERT INTO Department(DepartmentName) values('production'), ('IT');
select * from Department;

create Table EmpDepartment
(
EmpID	int,
DeptID	int,
constraint EmpDepartment_ForeignKey_EmpID foreign key(EmpID) references Employee(EmpID) on delete cascade,
constraint EmpDepartment_ForeignKey_DeptID foreign key(DeptID) references Department(DeptID) on delete cascade
)

select * from EmpDepartment;

ALTER TABLE Employee drop column Department
 
select * from Payroll;
select * from Department;
select * from Company;

--UC12 make sure all retrieve queries work
select * from Employee;
select * from Payroll;
delete from Employee where Address = 'empty';

select BasicPay from Payroll where EmpID = (select EmpID from Employee where EmpName = 'Terissa');
select * from Employee where StartDate	between '2018-01-01' and GETDATE();
INSERT INTO EmpDepartment(EmpID, DeptID) select Employee.EmpID, DeptID FROM Employee, Department WHERE Employee.EmpName = 'Terissa' 
AND Department.DepartmentName = 'sales';
INSERT INTO EmpDepartment(EmpID, DeptID) select Employee.EmpID, DeptID FROM Employee, Department WHERE Employee.EmpName = 'Terissa' 
AND Department.DepartmentName = 'marketing';
INSERT INTO EmpDepartment(EmpID, DeptID) select Employee.EmpID, DeptID FROM Employee, Department WHERE Employee.EmpName = 'Bil' 
AND Department.DepartmentName = 'IT';
INSERT INTO EmpDepartment(EmpID, DeptID) select Employee.EmpID, DeptID FROM Employee, Department WHERE Employee.EmpName = 'Charlie' 
AND Department.DepartmentName = 'production';

SELECT * FROM EmpDepartment;

--retrieve data queries
select avg(BasicPay) as average_Basic_Pay from Payroll
select Gender, sum(BasicPay) as total_Basic_Pay from Payroll, Employee where Payroll.EmpID = Employee.EmpID group by Gender
select Gender, count(BasicPay) as salary_Basic_Pay from Payroll, Employee where Payroll.EmpID = Employee.EmpID group by Gender
select Gender, max(BasicPay) as max_Basic_Pay from Payroll, Employee where Payroll.EmpID = Employee.EmpID group by Gender;
select Gender, min(BasicPay) as min_Basic_Pay from Payroll, Employee where Payroll.EmpID = Employee.EmpID group by Gender;

select BasicPay from Payroll, Employee where Payroll.EmpID = Employee.EmpID and EmpName = 'Terissa'
--OR
select BasicPay from Payroll where EmpID = (select EmpID from Employee where EmpName = 'Terissa')

select * from Employee, EmpDepartment where Employee.EmpID = EmpDepartment.EmpID and StartDate between '2018-01-01' and GETDATE();

SELECT * from Employee;
SELECT * from EmpDepartment;
SELECT * from Department;

UPDATE Employee set Gender = 'M' where EmpName = 'Charlie' or EmpName = 'Bil';
UPDATE Payroll SET NetPay = 70000;

delete from EmpDepartment where EmpID = 1;
SELECT Employee.EmpID, EmpName, PhoneNumber, Address, DepartmentName, Gender, BasicPay, Deduction,
                                    TaxablePay, IncomeTax, NetPay, StartDate
                                    from Employee, Payroll, Department, EmpDepartment where Employee.EmpID = Payroll.EmpID and 
									EmpDepartment.DeptID = Department.DeptID and Employee.EmpID = EmpDepartment.EmpID;

SELECT * from Employee;

drop table Employee;
drop table Department;
drop table Company;
drop table Payroll;



