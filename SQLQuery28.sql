USE WideWorldImporters;

alter function Sales.LineTotal (
	@Quantity int,
	@UnitPrice decimal(8, 2)
)
returns decimal(8, 2) as
begin
return @Quantity * @UnitPrice
end

select Sales.LineTotal(5,7.99) lineTotal;

alter function Sales.RecentOrdersByEffDate (
	@EffDate date
)
returns table
as
return
	select
		-- columns
		CustomerID, OrderID, OrderDate
	from
		-- table
		Sales.Orders
	where
		-- constraint
		OrderDate > @EffDate

select *
from Sales.RecentOrdersByEffDate('2016-01-01') [Orders after 2016]

select C.CustomerName, COUNT(RO.OrderID) as [NumberOfOrders]
from Sales.RecentOrdersByEffDate('2016-01-01') as RO
inner join Sales.Customers as C
	on C.CustomerID = RO.CustomerID
group by CustomerName