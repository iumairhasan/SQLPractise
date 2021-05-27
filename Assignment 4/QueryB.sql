with temp as (
select distinct SalesPersonID, CustomerID 
		from Sales.SalesOrderHeader
		where SalesPersonID is not null
)

select distinct soh.CustomerID,
Stuff(
	(select ', ' + rtrim(cast(SalesPersonID as char))
	from temp
	where temp.CustomerID = soh.CustomerID 
	order by SalesOrderID
	for xml path('')) , 1, 2, '') as salespersonid
from sales.SalesOrderHeader soh
right join temp
on temp.customerid = soh.CustomerID
order by CustomerID desc

--Part c
select distinct SalesOrderID, 
stuff((select ', ' + rtrim(cast(ProductID as char))
	from Sales.SalesOrderDetail so
	where so.SalesOrderID = sod.SalesOrderID
	order by ProductID asc
	for xml path('')), 1, 2, '') as ProductID
from Sales.SalesOrderDetail sod
order by sod.SalesOrderID

select * from Sales.SalesOrderDetail
