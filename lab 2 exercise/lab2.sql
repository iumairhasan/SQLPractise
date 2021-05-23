select p.ProductID, p.Name, p.SellStartDate, p.SellEndDate, p.Size, p.Weight
from Production.product p

select * 
from Sales.SalesOrderHeader soh
where soh.CreditCardID is null

select *
from Production.Product p
where p.Size is not null

--4
select *
from Production.Product p
where cast(p.SellStartDate as date) between '2007-01-01' and '2007-12-31'

--5
select *, dateadd(day, 7, soh.OrderDate) as 'delivery date' 
from Sales.SalesOrderHeader soh
where soh.OrderDate between '2007-06-01' and '2007-06-30'

--6		
select format(dateadd(day, 30, getdate()), 'MM/dd/yyyy') as 'date after 30 days'--7