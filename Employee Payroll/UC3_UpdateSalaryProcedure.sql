USE [EmployeePayroll]
GO
/****** Object:  StoredProcedure [dbo].[Er_UpdateEmployeePayrollSalary]    Script Date: 26-Feb-21 1:40:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER     PROCEDURE [dbo].[Er_UpdateEmployeePayrollSalary]
	@EmpID int,
	@EmpName varchar(255),
	@BasicPay	Money
AS
SET XACT_ABORT on;
SET NOCOUNT ON;
BEGIN
BEGIN TRY
BEGIN TRANSACTION;
	DECLARE @row_count INTEGER

	update Payroll Set BasicPay = @BasicPay where EmpID = @EmpID;

	SELECT @row_count = @@ROWCOUNT

	select Employee.EmpID, EmpName, PhoneNumber, Address, DepartmentName, Gender, BasicPay, Deduction,
	TaxablePay, IncomeTax, NetPay, StartDate 
	from Employee left join EmpDepartment on Employee.EmpID = EmpDepartment.EmpID
	left join Department on EmpDepartment.DeptID = Department.DeptID
	left join Payroll on Employee.EmpID = Payroll.EmpID where Employee.EmpID = @EmpID

COMMIT TRANSACTION;
return @row_count
END TRY
BEGIN CATCH
SELECT ERROR_NUMBER() as ErrorNumber, ERROR_MESSAGE() as ErrorMessage;
IF(XACT_STATE()) = -1
	BEGIN
		PRINT
		'transaction is uncommitable' + ' rolling back transaction'
		ROLLBACK TRANSACTION;
	END;
ELSE IF(XACT_STATE()) = 1
	BEGIN
		PRINT
		'transaction is commitable' + ' rolling back transaction'
		COMMIT TRANSACTION;
		return @row_count
	END;
ELSE
	BEGIN
	PRINT
		'transaction is failed'
	ROLLBACK TRANSACTION;
	END;
END CATCH

END
