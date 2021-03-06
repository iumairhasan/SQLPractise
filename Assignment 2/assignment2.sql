USE AdventureWorks2008R2;

SELECT c.CustomerID,
PersonID,
COUNT(SalesOrderID) AS "Total Order"
FROM Sales.Customer c INNER JOIN Sales.SalesOrderHeader oh
ON c.CustomerID = oh.CustomerID
GROUP BY c.CustomerID, PersonID
HAVING COUNT(SalesOrderID) > 20
ORDER BY "Total Order" DESC;

SELECT Name [Product],
ListPrice,
(SELECT MAX(ListPrice) FROM Production.Product) AS [Max Price],
(ListPrice / (SELECT MAX(ListPrice) FROM Production.Product)) * 100 AS [Percent of MAX]
FROM Production.Product
WHERE ListPrice > 0
ORDER BY ListPrice DESC;

--Question 1
select [CustomerID], [SalesOrderID], CAST([OrderDate] as DATE) as OrderDate, ROUND([TotalDue], 2) as 'Total Due'
from Sales.SalesOrderHeader soh
where OrderDate>'2008-05-01' and TotalDue>50000

--QUestion 2
select CustomerID, AccountNumber, cast(max(OrderDate) as date) as 'Order Date', count(salesorderid) as 'total orders'
from Sales.SalesOrderHeader
group by CustomerID, AccountNumber
order by CustomerID

--Question 3
select ProductID, Name, ListPrice
from Production.Product p
where p.ListPrice> (select ListPrice from Production.Product where ProductID = 912)
order by ListPrice DESC

--Question 4
select sod.ProductID, name, cast(count(sod.ProductID) as int) as 'No.of Times sold'
from sales.SalesOrderDetail sod
	join Production.Product p
	on sod.ProductID = p.ProductID
group by sod.ProductID, name
having count(sod.ProductID) > '5'
order by 'No.of Times sold' desc, sod.ProductID asc

--Question 5
select temp.CustomerID, temp.AccountNumber
from (select CustomerID, AccountNumber, cast(max(OrderDate) as date) as 'OrderDate'
		from sales.SalesOrderHeader
		group by CustomerID, AccountNumber
		having cast(max(OrderDate) as date) <= '2008-01-01') temp
order by temp.CustomerID asc

select  oh.CustomerID as"Customer ID", oh.AccountNumber as "Account Number" 
from sales.SalesOrderHeader oh
group by CustomerID, AccountNumber
having max(oh.OrderDate) <= '2008-01-01' --not placed an order after january 1st 2008, so including orders placed on jan 1st 2008
order by  oh.CustomerID

--Question 6
select c.CustomerID, p.FirstName, p.LastName, ea.EmailAddress 
from sales.Customer c
	join person.person p
	on c.PersonID = p.BusinessEntityID
	join person.EmailAddress ea
	on p.BusinessEntityID = ea.BusinessEntityID

