--UC12 remove employee from payroll
	USE [EmployeePayroll]
	GO
	SET ANSI_NULLS ON
	GO
	SET QUOTED_IDENTIFIER ON
	GO
	-- =============================================
	-- Author:		<Author,,Name>
	-- Create date: <Create Date,,>
	-- Description:	<Description,,>
	-- =============================================
CREATE OR ALTER   PROCEDURE Er_RemoveEmployeeFromPayroll
	-- Add the parameters for the stored procedure here
	@EmpID		int
AS
SET XACT_ABORT on;
SET NOCOUNT ON;
BEGIN
BEGIN TRY
BEGIN TRANSACTION;
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @result bit = 0;
	DECLARE @active bit = 0;
	DECLARE @Emp_ID int = 0;
	-- Insert statements for procedure here
	set @Emp_ID = (SELECT EmpID from Employee where EmpID =  @EmpID);

	IF (@Emp_ID = @EmpID)
	BEGIN;
		UPDATE Employee SET IsActive = 0 where EmpID = @EmpID;		
	END
	ELSE
		BEGIN;
		THROW 50001,'employee dont exist', -1;
	END	

COMMIT TRANSACTION;	
set @result = 1;
return @result;
END TRY
BEGIN CATCH

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
