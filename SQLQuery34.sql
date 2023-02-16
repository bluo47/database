alter view [Application].[OrderByCustomer]
as
select C.CustomerName, C.CustomerID, O.OrderID, O.OrderDate
	, SUM(Sales.LineTotal(OL.Quantity, OL.UnitPrice)) as OrderTotal
	, sales.Discount(SUM(Sales.LineTotal(OL.Quantity, OL.UnitPrice))) as ShippingDiscount
	--, count(OL.Quantity) NumLinePerOrder
from Sales.Orders as O
inner join Sales.OrderLines as OL
on OL.OrderID = O.OrderID
inner join Sales.Customers as C
on C.CustomerID = O.CustomerID
where YEAR(O.OrderDate) >=2015
--and C.CustomerID=1
group by C.CustomerName, C.CustomerID, O.OrderID, O.OrderDate
union
select C.CustomerName, C.CustomerID, O.OrderID, O.OrderDate
	, SUM(Sales.LineTotal(OL.Quantity, OL.UnitPrice)) as OrderTotal
	, 0 as ShippingDiscount
	--, count(OL.Quantity) NumLinePerOrder
from Sales.Orders as O
inner join Sales.OrderLines as OL
on OL.OrderID = O.OrderID
inner join Sales.Customers as C
on C.CustomerID = O.CustomerID
where YEAR(O.OrderDate) <2015
--and C.CustomerID=1
group by C.CustomerName, C.CustomerID, O.OrderID, O.OrderDate
--order by C.CustomerName, OrderID
GO

select *
,  (case when Year(OrderDate) >=2015 then sales.Discount(OrderTotal)
	else 0 end) Disc
from [Application].[OrderByCustomer]
where CustomerID = 1

--select C.CustomerName, C.CustomerID, O.OrderID, O.OrderDate
--	, OL.OrderTotal
--	, ol.OrderLineCount
--from Sales.Orders as O
--inner join
--(select OrderId
--	, SUM(Sales.LineTotal(OL.Quantity, OL.UnitPrice)) as OrderTotal
--	, count(OrderId) as OrderLineCount
--	from Sales.OrderLines as OL
--	group by OrderId) as OL
--  on OL.OrderID = O.OrderID
--inner join Sales.Customers as C
--  on C.CustomerID = O.CustomerID
--where C.CustomerID=1
--order by C.CustomerName, OrderID