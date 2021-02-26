-- UC8 alter payroll columns make derived from basicpay
alter table Payroll add Deduction as BasicPay * 20 / 100;

alter table Payroll drop column Taxablepay

alter table Payroll add TaxablePay as Basicpay - (BasicPay * 20 / 100);

alter table Payroll drop column IncomeTax

alter table Payroll add IncomeTax as  ((Basicpay - (BasicPay * 20 / 100)) * 10 / 100);

alter table Payroll drop column NetPay

alter table Payroll add NetPay as BasicPay - ((Basicpay - (BasicPay * 20 / 100)) * 10 / 100);