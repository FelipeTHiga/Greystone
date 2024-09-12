-- Lesson 7

SELECT 
	[Name]
FROM
	Production.ProductModel
UNION 
SELECT 
	[Name]
FROM
	Production.Product
WHERE 
	ProductModelID IS NULL;

SELECT 
	CustomerID,
	'C' as TableOrigin
FROM Sales.Customer
UNION
SELECT 
	BusinessEntityID,
	'S' 
FROM Sales.SalesPerson
ORDER BY 
	 TableOrigin DESC;

SELECT 
	'Total',
	SUM(LineTotal) AS PaymentPerLine,
	SUM(OrderQty) AS Qty
FROM 
	Sales.SalesOrderDetail
UNION
SELECT
	'Average',
	AVG(LineTotal),
	AVG(OrderQty)
FROM
	Sales.SalesOrderDetail
UNION
SELECT
	'Min',
	MIN(LineTotal),
	MIN(OrderQty)
FROM
	Sales.SalesOrderDetail
UNION
SELECT
	'Max',
	MAX(LineTotal),
	MAX(OrderQty)
FROM
	Sales.SalesOrderDetail;

SELECT 
	SalesOrderID,
	OrderDate,
	CustomerID,
	FORMAT(SubTotal, '#,###') AS RoundSubTotal,
	CASE
		WHEN SubTotal < 500 THEN 'A'
		WHEN SubTotal < 10000 THEN 'B'
		WHEN SubTotal < 100000 THEN 'C'
		ELSE 'D'
	END AS OrderCategory
FROM
	Sales.SalesOrderHeader