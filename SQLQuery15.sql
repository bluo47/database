create view Application.jPotter
AS
select OrderID, OrderDate
from Sales.Orders as O
inner join Application.People as P
on P.PersonID = O.SalespersonPersonID
and P.PersonID = 20

--drop view Application.jPotter

select *
from Application.jPotter