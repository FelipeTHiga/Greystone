---------------------------------------------------------
----- Lesson 2 – Basic Retrieval and Data Filtering -----
---------------------------------------------------------

-- 1. Write a query that displays the Order number (SalesOrderID), Order date,
-- Customer Number (CustomerID) and Order amount (SubTotal) from
-- the Sales.SalesOrderHeader table, for the orders above $1500 and an Order date
-- from Jan. 1,2013 onwards.
	SELECT 
		SalesOrderID,
		OrderDate,
		CustomerID,
		SubTotal
	FROM 
		Sales.SalesOrderHeader
	WHERE 
		SubTotal > 1500
		AND OrderDate >= '2013-01-01';

-- 2. Write a query that displays all the data from the Person.Person table, only for
-- people whose BusinessEntityID is above 10,000 and their first name is either Jack
-- or Crystal.
	SELECT 
		*
	FROM
		Person.Person
	WHERE
		BusinessEntityID > 10000
		AND (FirstName = 'Jack' 
		OR FirstName = 'Crystal');

-- 3. Write a query that displays the SalesOrderID, ProductID, and total amount for that
-- order line (LineTotal) only for items with a Line Total between 100 and 1.000,
-- inclusive.
	SELECT 
		SalesOrderID,
		ProductID,
		LineTotal
	FROM 
		Sales.SalesOrderDetail
	WHERE
		LineTotal >= 100
		AND LineTotal <= 1000;

-----------------------------------------------------
----- Lesson 3 – Calculated Columns and Sorting -----
-----------------------------------------------------

-- 1. Write a query that displays the ProductID, Product Name, Color, Weight and the
-- profit margin (ListPrice – StandardCost) from the Production.Product table.
-- Display only the products that have a value for Weight.
-- Sort the results by Color, descending, and Weight, ascending.
	SELECT  
		ProductID,
		[Name],
		Color,
		[Weight],
		ListPrice - StandardCost AS ProfitMargin
	FROM
		Production.Product
	WHERE
		[Weight] IS NOT NULL
	ORDER BY 
		Color DESC,
		[Weight] ASC; 

-- 2. The company wants to check how the prices will change if every order has a $50
-- delivery charge added.
-- Write a query that displays the following columns from
-- the Sales.SalesOrderHeader table:
-- Order number (SalesOrderID), Order amount (SubTotal), and Order amount +
-- $50 (named SubTotalPlus50).
-- Sort the query results according to Order Amount from the highest to lowest.	SELECT 		SalesOrderID,		SubTotal,		SubTotal + 50 AS SubTotalPlus50	FROM		Sales.SalesOrderHeader	ORDER BY		SubTotal DESC;