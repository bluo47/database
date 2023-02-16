create view Application.CustomerOrders
as
select C.CustomerName, O.OrderID, O.OrderDate, OL.Description
	, OL.UnitPrice, OL.Quantity, (OL.UnitPrice * OL.Quantity) as [LineTotal]
from Sales.Orders as O
inner join Sales.OrderLines as OL
on OL.OrderID = O.OrderID
inner join Sales.Customers as C
on C.CustomerID = O.CustomerID
--order by C.CustomerName, OrderID;

USE [WideWorldImporters]
GO

/****** Object:  View [Application].[CustomerOrders]    Script Date: 1/10/2023 17:33:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER view [Application].[CustomerOrders]
as
select C.CustomerName, C.CustomerID, O.OrderID, O.OrderDate, OL.Description
	, OL.UnitPrice, OL.Quantity, (OL.UnitPrice * OL.Quantity) as [LineTotal]
from Sales.Orders as O
inner join Sales.OrderLines as OL
on OL.OrderID = O.OrderID
inner join Sales.Customers as C
on C.CustomerID = O.CustomerID
--order by C.CustomerName, OrderID;



GO

select *
from Application.CustomerOrders
where CustomerID = 1
order by OrderID;

