/* Lesson 4 */
/* COUNT example */
SELECT
	ProductID,
	Color
FROM
	Production.Product
WHERE
	ProductID < 320;

SELECT
	COUNT(*) AS CountLine,
	COUNT(Color) AS CountColor
FROM
	Production.Product
WHERE
	ProductID < 320;

/* GROUP BY Keyword */
SELECT
	CustomerID,
	COUNT(*) AS NoOfSales
FROM
	Sales.SalesOrderHeader
GROUP BY
	CustomerID;

SELECT
	CustomerID,
	COUNT(*) AS NoOfSales,
	SUM(SubTotal) AS SumSubTotal
FROM
	Sales.SalesOrderHeader
GROUP BY
	CustomerID
ORDER BY 
	SumSubTotal;


/* GROUP BY Clause */
SELECT 
	FirstName,
	COUNT(FirstName) AS CountName
FROM
	Person.Person
GROUP BY 
	FirstName
HAVING 
	COUNT(FirstName) > 20;

SELECT 
	Color,
	AVG(ListPrice) AS AvgListPrice
FROM
	Production.Product
WHERE
	ListPrice > 0
GROUP BY 
	Color
HAVING 
	AVG(ListPrice) > 500
ORDER BY 
	AvgListPrice DESC

SELECT Color FROM Production.Product