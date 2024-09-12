-- Lesson 5 – Advanced Filtering ---- Part 3 – IS NULL ---- 1. Write a query that displays the product details of the products with the color NULL
-- from the Production.Product table . Check the table for the appropriate column
-- name
	SELECT 
		*
	FROM
		Production.Product
	WHERE
		Color IS NULL;

-- 2. Write a query that displays all the order details from the Sales.SalesOrderHeader
-- table for the orders that have data in the Sales Person ID column.
	SELECT 
		*
	FROM
		Sales.SalesOrderHeader
	WHERE
		SalesPersonID IS NOT NULL;

-- 3. Write a query that displays the customer code and the highest order amount
-- (SubTotal) in the years 2012 and 2013 for each customer in the
-- Sales.SalesOrderHeader table. Display only sales that have values both in the
-- Sales Person column, and in the Purchase Order Number column. Check the table
-- for the appropriate column names.
	SELECT
		CustomerID,
		MAX(SubTotal) HighestOrderAmount
	FROM
		Sales.SalesOrderHeader
	WHERE 
		YEAR(OrderDate) BETWEEN 2012 AND 2013
		AND SalesPersonID IS NOT NULL
		AND PurchaseOrderNumber IS NOT NULL
	GROUP BY CustomerID;
	