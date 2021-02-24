-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE sp_AddEmployeeDetail
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
GO
