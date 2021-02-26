USE [EmployeePayroll]
GO
/****** Object:  StoredProcedure [dbo].[Er_InsertEmployeePayrollData]    Script Date: 26-Feb-21 3:11:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER   PROCEDURE [dbo].[Er_InsertEmployeePayrollData]
	-- Add the parameters for the stored procedure here
	@EmpName		varchar(255),
	@Gender			char(1),
	@StartDate		Date,
	@BasicPay		Money,
	@Department		varchar(50)
AS
SET XACT_ABORT on;
SET NOCOUNT ON;
BEGIN
BEGIN TRY
BEGIN TRANSACTION;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @new_identity INTEGER = 0;
	DECLARE @result bit = 0;
    -- Insert statements for procedure here
	Insert into Employee(EmpName, Gender, StartDate) VALUES(@EmpName, @Gender, @StartDate);
	SELECT @new_identity = @@IDENTITY;
	Insert into EmpDepartment(EmpID, DeptID) Values(@new_identity, (select DeptID from Department where DepartmentName = @Department));
	Insert into Payroll(EmpID, BasicPay) values(@new_identity, @BasicPay);	
	Insert into Company(EmpID, EmpName) values(@new_identity, @EmpName);
COMMIT TRANSACTION;	
set @result = 1;
return @result;
END TRY
BEGIN CATCH
--SELECT ERROR_NUMBER() as ErrorNumber, ERROR_MESSAGE() as ErrorMessage;
IF(XACT_STATE()) = -1
	BEGIN
		PRINT
		'transaction is uncommitable' + ' rolling back transaction'
		ROLLBACK TRANSACTION;
		return @result;		
	END;
ELSE IF(XACT_STATE()) = 1
	BEGIN
		PRINT
		'transaction is commitable' + ' commiting back transaction'
		COMMIT TRANSACTION;
		set @result = 1;
		return @result;
	END;
END CATCH
	
END
