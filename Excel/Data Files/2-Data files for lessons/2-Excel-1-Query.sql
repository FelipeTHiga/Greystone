select 	d.SalesOrderID,
		h.OrderDate,
		h.CustomerID,
		isnull (s.FirstName, '') as FirstName,
		isnull (s.LastName, '') as LastName,
		d.OrderQty,
		d.ProductID,
		p.[Name],
		p.StandardCost,
		d.UnitPrice,
		d.UnitPriceDiscount,
		d.LineTotal

from sales.SalesOrderDetail d
	left join Sales.SalesOrderHeader h 
		on d.SalesOrderID = h.SalesOrderID
	left join Production.Product p 
		on d.ProductID = p.ProductID
	left join Sales.Customer c 
		on h.CustomerID = c.CustomerID
	left join Person.Person s 
		on c. PersonID = s.BusinessEntityID

where year(h.OrderDate)=2012 and month (h.OrderDate)= 4
