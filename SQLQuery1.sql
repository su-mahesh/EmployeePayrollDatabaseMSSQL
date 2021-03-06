USE [EmployeePayroll]
GO
/****** Object:  StoredProcedure [dbo].[GetAllEmployeeData]    Script Date: 24-Feb-21 3:55:38 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER   PROCEDURE [dbo].[GetAllEmployeeData] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select Employee.EmpID, EmpName, PhoneNumber, Address, DepartmentName, Gender, BasicPay, Deduction,
TaxablePay, IncomeTax, NetPay, StartDate 
from Employee left join EmpDepartment on Employee.EmpID = EmpDepartment.EmpID
left join Department on EmpDepartment.DeptID = Department.DeptID
left join Payroll on Employee.EmpID = Payroll.EmpID;
END
