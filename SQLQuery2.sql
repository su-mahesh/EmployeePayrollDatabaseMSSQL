USE [EmployeePayroll]
GO
/****** Object:  StoredProcedure [dbo].[sp_AddEmployeeDetail]    Script Date: 23-Feb-21 4:16:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_AddEmployeeDetail]
	-- Add the parameters for the stored procedure here
	@EmpName		varchar(255),
	@Gender			char(1),
	@PhoneNumber	bigint,
	@Address		varchar(255),
	@StartDate		Date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Employee(EmpName, Gender, PhoneNumber, Address, StartDate)
	VALUES(@EmpName, @Gender, @PhoneNumber, @Address, @StartDate);
END
