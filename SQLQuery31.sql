USE [WideWorldImporters]
GO
/****** Object:  StoredProcedure [Application].[OrderByCustomerID]    Script Date: 1/11/2023 17:31:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [Application].[OrderByCustomerID]
	@P_CustomerID int = null,
	@P_OrderDateAfter date = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select C.CustomerName, C.CustomerID, O.OrderID, O.OrderDate, OL.Description
		, OL.UnitPrice, OL.Quantity, Sales.LineTotal(OL.Quantity, OL.UnitPrice) as LineTotal
	from Sales.Orders as O
	inner join Sales.OrderLines as OL
	on OL.OrderID = O.OrderID
	inner join Sales.Customers as C
	on C.CustomerID = O.CustomerID
	where --C.CustomerID = @P_CustomerID
	isnull(@P_CustomerID, C.CustomerID) = C.CustomerID
	and isnull(@P_OrderDateAfter, '1900-01-01') < O.OrderDate
	order by OrderID
END

--exec Application.OrderByCustomerID @P_CustomerID = 74 
								--,@P_OrderDateAfter = '2015-01-01';

--exec Application.OrderByCustomerID @P_OrderDateAfter = '2015-01-01';

