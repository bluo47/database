USE WideWorldImporters;

SELECT [PersonID], [FullName], [IsSalesperson] FROM Application.People
WHERE IsSalesperson = 1;

SELECT TOP 10 * FROM Application.People
WHERE IsSalesperson = 0
ORDER BY FullName;

SELECT * FROM Sales.OrderLines
WHERE (Quantity * UnitPrice) > 10000
ORDER BY (Quantity * UnitPrice) DESC;

SELECT OrderID, SUM(Quantity * UnitPrice) AS [Total Value] FROM Sales.OrderLines
GROUP BY OrderID
HAVING SUM(Quantity * UnitPrice) > 10000
ORDER BY [Total Value] DESC;

SELECT TOP 5 C.CustomerID AS [Customer ID], C.CustomerName AS [Customer Name], SUM(IL.LineProfit) AS [Line Profit]
FROM Sales.InvoiceLines AS IL, Sales.Invoices AS IV, Sales.Customers AS C
WHERE IL.InvoiceID = IV.InvoiceID
AND IV.CustomerID = C.CustomerID
GROUP BY C.CustomerID, C.CustomerName
ORDER BY SUM(IL.LineProfit) DESC;

SELECT TOP 5 C.CustomerID AS [Customer ID], C.CustomerName AS [Customer Name], SUM(IL.LineProfit) AS [Line Profit]
FROM Sales.InvoiceLines AS IL
JOIN Sales.Invoices AS IV 
	ON IL.InvoiceID = IV.InvoiceID
JOIN Sales.Customers AS C
	ON IV.CustomerID = C.CustomerID
	AND C.CustomerID < 500
GROUP BY C.CustomerID, C.CustomerName
ORDER BY SUM(IL.LineProfit) DESC;

CREATE TABLE [Sales].[MyOrders](
	OrderID int IDENTITY(1, 1) NOT NULL,
	OrderDescription nvarchar(50)
)

INSERT INTO Sales.MyOrders (OrderDescription) 
VALUES ('Something3')

INSERT INTO Sales.MyOrders
VALUES ('Something4')

ALTER TABLE Sales.MyOrders
ADD Cost decimal(8, 2)

INSERT INTO Sales.MyOrders (OrderDescription)
VALUES ('Something5')

INSERT INTO Sales.MyOrders
VALUES ('Something6', null)

INSERT INTO Sales.MyOrders2 
SELECT * FROM Sales.MyOrders;

SELECT * 
INTO Sales.MyOrders3
FROM Sales.MyOrders 