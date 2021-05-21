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

