
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