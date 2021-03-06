USE [EmployeePayroll]
GO
/****** Object:  StoredProcedure [dbo].[AddEmployeePayrollData]    Script Date: 25-Feb-21 11:00:52 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE or ALTER PROCEDURE InsertEmployeePayrollData
	@EmpName		varchar(255),
	@Gender			char(1),
	@StartDate		Date,
	@Salary			Money,
	@Department		varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @new_identity INTEGER 			

	INSERT INTO EmployeePayroll(EmpName, Gender, StartDate, Salary, Department) output INSERTED.EmpID as new_identity
	VALUES(@EmpName, @Gender, @StartDate, @Salary, @Department);
	SELECT @new_identity = SCOPE_IDENTITY()
	return @new_identity
END
