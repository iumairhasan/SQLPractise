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
select format(dateadd(day, 30, getdate()), 'MM/dd/yyyy') as 'date after 30 days'--7select count (*) as 'Total Orders',	sum(soh.TotalDue) as 'Sum',	avg(soh.TotalDue) as'Average',	min(soh.TotalDue) as 'Minimum',	max(soh.TotalDue) as 'Maximum'	from sales.SalesOrderHeader sohwhere datepart(Month, soh.OrderDate) = 5 and datepart(year, soh.OrderDate) = 2008SELECT COUNT(*) [Total Orders],
 SUM(TotalDue) [Overall Total],
 AVG(TotalDue) [Order Ave.],
 MIN(TotalDue) [Smallest Total],
 MAX(TotalDue) [Largest Total]
FROM Sales.SalesOrderHeader
WHERE (DATEPART(MONTH, OrderDate) = 5) AND
 (DATEPART(YEAR, OrderDate) = 2008);

 --8
select soh.CustomerID, count(soh.CustomerID) as 'No.of Orders',
	sum(soh.TotalDue) as 'Sum of due'
from Sales.SalesOrderHeader soh
where DATEPART(Year, soh.OrderDate) = 2007
group by soh.CustomerID
having count(soh.CustomerID) > 1
order by sum(soh.TotalDue) desc

--9
select distinct soh.SalesPersonID
from Sales.SalesOrderDetail sod 
join Sales.SalesOrderHeader soh
on soh.SalesOrderID = sod.SalesOrderID
where sod.ProductID = 777
order by soh.SalesPersonID
--10select p.ProductID, p.Name, p.ListPrice, p.Size
from Production.Product p
join Production.ProductSubcategory psc
on p.ProductSubcategoryID = psc.ProductSubcategoryID
where psc.ProductCategoryID = 1 and psc.Name = 'Mountain Bikes';--11select soh.SalesOrderID, crc.Name
from Sales.SalesOrderHeader soh
join Sales.CurrencyRate c
on soh.CurrencyRateID = c.CurrencyRateID
join Sales.Currency crc
on c.ToCurrencyCode = crc.CurrencyCode;