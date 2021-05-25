
SELECT c.CustomerID, c.TerritoryID,
COUNT(o.SalesOrderid) [Total Orders],
Case	
	when COUNT(o.SalesOrderid) = 0 then 'No Order'
	when COUNT(o.SalesOrderid) = 1 then 'One Time'
	when COUNT(o.SalesOrderid) <= 5 and COUNT(o.SalesOrderid) >= 2 then 'Regular'
	when COUNT(o.SalesOrderid) <= 10 and COUNT(o.SalesOrderid) >=6 then 'Often'
	else 'Loyal'
	end as 'Comment'
FROM Sales.Customer c
LEFT OUTER JOIN Sales.SalesOrderHeader o
 ON c.CustomerID = o.CustomerID
WHERE DATEPART(year, OrderDate) = 2007
GROUP BY c.TerritoryID, c.CustomerID;

SELECT c.CustomerID, c.TerritoryID,
 COUNT(o.SalesOrderid) [Total Orders], 
 DENSE_RANK() over (Partition by c.TerritoryID order by COUNT(o.SalesOrderid) desc) as [Rank]
FROM Sales.Customer c
LEFT OUTER JOIN Sales.SalesOrderHeader o
 ON c.CustomerID = o.CustomerID
WHERE DATEPART(year, OrderDate) = 2007
GROUP BY c.TerritoryID, c.CustomerID;


--3.3
select top 1 with ties sp.BusinessEntityID, sp.Bonus
from Sales.SalesPerson sp
join Sales.SalesTerritory st
on sp.TerritoryID = st.TerritoryID
join HumanResources.Employee e
on sp.BusinessEntityID = e.BusinessEntityID
where e.Gender = 'F' and st.[Group] = 'North America'
order by sp.bonus desc

--3.4
with temp as
(select soh.SalesPersonID, 
dense_rank() over(partition by DATEPART(month, soh.orderdate) order by sum(soh.totaldue)desc) as 'rank',
DATEPART(month, soh.orderdate) as 'month ',
sum(soh.totaldue) as' Sales'
from sales.SalesOrderHeader soh
where  DATEPART(Year, soh.orderdate) = 2007 and soh.SalesPersonID is not null
group by DATEPART(month, soh.orderdate), soh.SalesPersonID)
select temp.[month ], temp.SalesPersonID, temp.[ Sales] , sp.Bonus
from temp
join Sales.SalesPerson sp
on sp.BusinessEntityID = temp.SalesPersonID
where temp.rank = 1
--order by  DATEPART(month, soh.orderdate)

select month, temp.SalesPersonID, round(TotalSale, 2) [Total Sales], Bonus from
(
select month(OrderDate) Month, SalesPersonID, sum(TotalDue) TotalSale,
rank() over (partition by month(OrderDate) order by sum(TotalDue) desc) as rank
from Sales.SalesOrderHeader
where SalesPersonID is not null and year(OrderDate) = 2007
group by month(OrderDate), SalesPersonID) temp
join Sales.SalesPerson s
on temp.SalesPersonID = s.BusinessEntityID
where rank =1
order by month;

--3.5
select soh.CustomerID, soh.AccountNumber
from sales.SalesOrderHeader soh
join Sales.SalesOrderDetail sod
on soh.SalesOrderID = sod.SalesOrderID
join Production.Product p
on sod.ProductID = p.ProductID
where p.Color = 'Red' and soh.OrderDate > '2008-05-01'
intersect
select soh.CustomerID, soh.AccountNumber
from sales.SalesOrderHeader soh
join Sales.SalesOrderDetail sod
on soh.SalesOrderID = sod.SalesOrderID
join Production.Product p
on sod.ProductID = p.ProductID
where p.Color = 'Yellow' and soh.OrderDate > '2008-05-01'
order by soh.CustomerID

