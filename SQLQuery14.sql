SELECT YEAR(OrderDate) AS Year, COUNT(OrderID) AS [Number Orders] FROM Sales.Orders
GROUP BY YEAR(OrderDate)
ORDER BY YEAR(OrderDate) ASC;

SELECT TOP 50 * FROM Sales.Customers;
SELECT TOP 50 * FROM Sales.Orders;


SELECT C.CustomerID, C.CustomerName
--,O.OrderDate
, COUNT(O.OrderID) AS [Number of Orders] 
FROM Sales.Customers AS C
LEFT OUTER JOIN Sales.Orders AS O
	ON YEAR(O.OrderDate) = 2015
	AND C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, CustomerName;

SELECT CustomerID, CustomerName
FROM Sales.Customers
WHERE UPPER(CustomerName) LIKE '%BEN%'

create table #tempCustomers (
CustomerId int,
CustomerName nvarchar(100)
)

insert into #tempCustomers
select CustomerId, CustomerName from Sales.Customers

insert into #tempCustomers values (1000, 'benjamin'), (1001,'ben')
insert into #tempCustomers values (1002, 'Hi ben')

-- temp table
SELECT CustomerID, CustomerName
	, REPLACE(CustomerName, 'ben','benjamin') ModifiedName
into #temp2
FROM #tempCustomers
WHERE CustomerName LIKE '% BEN %'
OR CustomerName = 'BEN'
OR CustomerName LIKE 'BEN %'
OR CustomerName LIKE '% BEN'

select t1.CustomerID, t1.CustomerName, t2. ModifiedName
	,isnull(t2.ModifiedName, t1.CustomerName) as OutputName
from #tempCustomers t1
left outer join #temp2  t2
on t1.CustomerID = t2.CustomerId
WHERE t1.CustomerName LIKE '%BEN%'

-- subquery
select t1.CustomerID
	--, t1.CustomerName
	--, t2. ModifiedName
	,isnull(t2.ModifiedName, t1.CustomerName) as OutputName
from #tempCustomers t1
left outer join (
	SELECT CustomerID, CustomerName
		, REPLACE(CustomerName, 'ben','benjamin') ModifiedName
	FROM #tempCustomers
	WHERE CustomerName LIKE '% BEN %'
	OR CustomerName = 'BEN'
	OR CustomerName LIKE 'BEN %'
	OR CustomerName LIKE '% BEN'
)  t2
on t1.CustomerID = t2.CustomerId
--WHERE t1.CustomerName LIKE '%BEN%'

SELECT 
 CustomerID
 , OrderDate
	--, getdate() [now]
	--, cast(getdate() as date) [today]
	, DateAdd(month, -81, cast(getdate() as date)) [sometime ago]
--CustomerID, CustomerName, 
FROM Sales.Orders
WHERE OrderDate < DateAdd(MONTH, -81, cast(getdate() as date))
order by 1

select CustomerID, max(orderdate) as [MaxOrderDate]
from Sales.Orders
group by CustomerID
order by 2 asc

SELECT 
 CustomerID
 , MaxOrderDate
	--, getdate() [now]
	--, cast(getdate() as date) [today]
	, DateAdd(month, -81, cast(getdate() as date)) [sometime ago]
--CustomerID, CustomerName, 
FROM (select CustomerID, max(orderdate) as [MaxOrderDate]
	from Sales.Orders
	group by CustomerID) Orders
WHERE MaxOrderDate < DateAdd(MONTH, -81, cast(getdate() as date))