-- Lesson 7 – Union and Conditions ---- Part 1 – Union, Union All ---- 1. Write a query that returns a single list of all customer numbers from the
-- Sales.Customer table and sales people from the Sales.SalesPerson table.
-- Check the names of the appropriate columns in the table.
	SELECT
		'C' AS DataOrigin,
		CustomerID
	FROM
		Sales.Customer -- 19.820 records
	UNION
	SELECT
		'S',
		BusinessEntityID
	FROM
		Sales.SalesPerson; -- 17 records


-- 2. Write a query that displays the ProductID for the products that meet at least one of
-- the following requirements. If the item meets more than one requirement, the
-- product code should be displayed only once. Solve with union only:

-- a. The product was ordered (Sales.SalesOrderDetail) at a unit price after
-- discount (calculated using the existing columns) greater than 1800, and the
-- CarrierTrackingNumber starts with the letters 4E.

-- b. The order record is for a quantity of product greater than 10 units and the
-- tracking number ends with the number 4.

	SELECT 
		ProductID
	FROM 
		Sales.SalesOrderDetail
	WHERE
		(UnitPrice - UnitPriceDiscount) > 1800
		AND CarrierTrackingNumber LIKE '4E%' -- 17 Records
	UNION
	SELECT 
		ProductID
	FROM 
		Sales.SalesOrderDetail
	WHERE
		OrderQty > 10
		AND CarrierTrackingNumber LIKE '%4'; -- 133 Records

-- 3. In the following query, we want to compare the quantity of products of each color
-- in the product table to the quantity of items of each color ordered, in order to
-- understand which colors are ordered most by customers.
-- a. The query will return 3 columns: Color, number of items (a calculated column
-- named NoOfItems), and the data source (a calculated column named
-- SourceOfData).
-- b. The query will return a single row for each color from the product table. The
-- row will contain the color, the number of products of that color and the
-- constant text 'P', to show that the data came from the product table.
-- c. In addition, the query will return one row for each color from the
-- Sales.SalesOrderDetail table. The row will contain the color, the number of
-- products of that color ordered and the constant text 'O', to show that the
-- data came from the orders table.
-- d. Sort the results according to color code.	SELECT 		Color,		COUNT(*) AS NoOfItems,		'P' AS SourceOfData	FROM		Production.Product	GROUP BY		Color	UNION	SELECT 		Color,		SUM(OrderQty),		'O'	FROM 		Sales.SalesOrderDetail AS s	JOIN 		Production.Product AS p	ON			s.ProductID = p.ProductID	GROUP BY		Color	ORDER BY 		Color;	SELECT 		Color,		COUNT(Color) AS NoOfItems,		'P' AS SourceOfData	FROM		Production.Product	GROUP BY		Color	UNION	SELECT 		Color,		COUNT(Color),		'O'	FROM 		Sales.SalesOrderDetail AS s	JOIN 		Production.Product AS p	ON			s.ProductID = p.ProductID	GROUP BY		Color	ORDER BY 		Color;