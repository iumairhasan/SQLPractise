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
