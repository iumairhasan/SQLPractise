
-- Without PARTITION BY

/*
If the PARTITIAN BY clause is not used, the entire row set
returned by a query will be treated as a single big partition.
*/

SELECT RANK() OVER (ORDER BY OrderQty DESC) as [Rank],
       SalesOrderID, ProductID, UnitPrice, OrderQty
FROM Sales.SalesOrderDetail
WHERE UnitPrice >75;

-- With PARTITION BY

/*
When the PARTITIAN BY clause is used, the ranking will be
performed within each partitioning value.
*/

SELECT RANK() OVER (PARTITION BY ProductID ORDER BY OrderQty DESC) as [Rank],
       SalesOrderID, ProductID, UnitPrice, OrderQty
FROM Sales.SalesOrderDetail
WHERE UnitPrice >75;


-------------------------------

-- Create a demo table

CREATE TABLE NameList (Name VARCHAR(50));

-- Put some data in the demo table

INSERT NameList (Name)
VALUES ('Peter'),
       ('Mary'),
       ('Josh'),
       ('Peter'),
       ('Amanda');

-- Option 1
-- Use ROW_NUMBER() with PARTITION BY

DELETE dupes
FROM (SELECT ROW_NUMBER()
OVER (PARTITION BY Name ORDER BY Name) rownum
FROM NameList) dupes
WHERE dupes.rownum > 1;

-- Validate duplicates have been removed

SELECT Name FROM NameList ORDER BY Name;


----------------------------------------

SELECT NTILE(5) OVER (ORDER BY TotalDue DESC) as [Rank],
       SalesOrderID, cast(TotalDue as decimal(9,2)) OrderValue
FROM Sales.SalesOrderHeader
WHERE TotalDue > 100000;

----------------------------------------

SELECT ProductID
       , Name
       , ListPrice
       , (SELECT ROUND(AVG(ListPrice), 2)
          FROM Production.Product) AS AvgPrice
       , CASE
			 WHEN ListPrice - (SELECT ROUND(AVG(ListPrice), 2)
							   AS AvgPrice FROM Production.Product) = 0
				  THEN 'Average Price'
			 WHEN ListPrice - (SELECT ROUND(AVG(ListPrice), 2)
							   AS AvgPrice FROM Production.Product) < 0
				  THEN 'Below Average Price'
			 ELSE 'Above Average Price'
		 END AS PriceComparison
FROM Production.Product
ORDER BY ListPrice DESC;


with temp as
(SELECT ROUND(AVG(ListPrice), 2) AS AvgPrice
 FROM Production.Product)
SELECT ProductID
       , Name
       , ListPrice
       , AvgPrice
       , CASE
			 WHEN ListPrice - AvgPrice = 0
				  THEN 'Average Price'
			 WHEN ListPrice - AvgPrice < 0
				  THEN 'Below Average Price'
			 ELSE 'Above Average Price'
		 END AS PriceComparison
FROM Production.Product
cross join temp
ORDER BY ListPrice DESC;


