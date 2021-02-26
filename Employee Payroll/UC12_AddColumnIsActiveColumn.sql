--UC12 ADD column IsActive to employee payroll

USE EmployeePayroll;
ALTER TABLE EMPLOYEE ADD IsActive bit constraint EmpIsActiveNotNull not null constraint EmpDefaultIsActive default 1;

select * from Employee;