--Q1
select st.TerritoryID, st.Name, round(min(soh.totaldue), 2) as Minimum_Order
from sales.salesorderheader soh
join Sales.SalesTerritory st
on soh.TerritoryID = st.TerritoryID
group by st.TerritoryID, st.Name
having min(soh.totaldue) >=4
order by st.TerritoryID

--Q2
select soh.CustomerID, max(soh.totaldue) as'Total Due', max(sod.OrderQty) as 'Order Quantity'
from Sales.SalesOrderHeader soh
join Sales.SalesOrderDetail sod
on soh.SalesOrderID = sod.SalesOrderID
group by soh.CustomerID
order by soh.CustomerID desc
