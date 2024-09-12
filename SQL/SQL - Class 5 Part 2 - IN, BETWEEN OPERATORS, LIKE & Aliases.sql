-- Lesson 5 – Advanced Filtering ---- Part 2 – IN, BETWEEN OPERATORS, LIKE & Aliases ---- 1. Display the names of the people in the People table that have one of the following
-- Last names: Adams, Kelly, Perry, Wilson. Use the “IN” operator.
	SELECT
		FirstName,
		LastName
	FROM
		Person.Person
	WHERE LastName IN ('Adams','Kelly','Perry', 'Wilson');

-- 2. Write a query that displays the product code (ProductID), the Product name and
-- the subcategory code (ProductSubcategoryID) from the Production.Product table,
-- Display the data only for products for which the subcategory is one of the
-- following: 2,5,9,14,15,30.
-- Sort the data by subcategory
	SELECT 
		ProductID,
		[Name],
		ProductSubcategoryID
	FROM
		Production.Product
	WHERE 
		ProductSubcategoryID IN (2,5,9,14,15,30)
	ORDER BY
		ProductSubcategoryID;

-- 3. Write a query that displays the product code (ProductID) and product cost
-- (StandardCost) from the Production.Product table for products with a cost
-- between 100 and 500,
	SELECT 
		ProductID,
		StandardCost
	FROM 
		Production.Product
	WHERE 
		StandardCost BETWEEN 100 AND 500;

-- 4. Write a query that shows the order number (SalesOrderID), order date
-- (OrderDate) and total for payment (SubTotal), for orders generated on the dates
-- 10/01/2012 to 10/02/2012, inclusive . Base your answer on the Order title table.
-- * The dates in the question are written in dd/mm/yyyy format.
	SELECT 
		SalesOrderID,
		OrderDate,
		SubTotal
	FROM
		Sales.SalesOrderHeader
	WHERE
		OrderDate BETWEEN '2012-01-10' AND '2012-02-10'

-- 5. Write a query that displays the product code (ProductID), the product name and
-- the Product number for all the products in the Production.Product table that begin
-- with the letter “C”.
	SELECT
		ProductID,
		[Name],
		ProductNumber
	FROM
		Production.Product
	WHERE
		ProductNumber LIKE 'C%'
	
-- 6. Write a query that displays the product code (ProductID), the product name and
-- the Product number for all the products in the Production.Product table that begin
-- with the letters “C”, “B” or “E”.
	SELECT
		ProductID,
		[Name],
		ProductNumber
	FROM 
		Production.Product
	WHERE
		ProductNumber LIKE '[C,B,E]%';

-- 7. Write a query that displays the product code (ProductID), the product name and
-- the Product number for all the products in the Production.Product table that end
-- with the number “8”.
	SELECT
		ProductID,
		[Name],
		ProductNumber
	FROM 
		Production.Product
	WHERE
		ProductNumber LIKE '%8';

-- 8. Display the records from the Person.Address table with the word “New” in their
-- Address 1 line (beginning/middle/end).		SELECT		*	FROM		Person.Address	WHERE		AddressLine1 LIKE '%New%';	-- 9. Display the First names of the people in the Person.Person table where the First
-- name has only 5 letters, the first letter is “D” and the third letter is “N”. Display the
-- names without repetition.
	SELECT DISTINCT
		FirstName
	FROM
		Person.Person
	WHERE
		FirstName LIKE 'D_N__';		

-- 10.Write a query that displays the data from the Sales.SalesOrderDetail table where
-- the total per line (LineTotal) is between 1,000 and 5,000 (use “Between”) and the
-- Carrier Tracking Number contains the sequence F89. Sort the results by Unit price
-- in ascending order.
	SELECT 
		*
	FROM
		Sales.SalesOrderDetail
	WHERE
		LineTotal BETWEEN 1000 AND 5000
		AND CarrierTrackingNumber LIKE '%F89%'
	ORDER BY
		UnitPrice;

-- 11.Write a query that displays the product code (ProductID) and product name from
-- the Production.Product table for all the products that have the word “Red” in their
-- name and their List Price is between 600 and 1,500, inclusive.	SELECT 		ProductID,		[Name]	FROM		Production.Product	WHERE		[Name] LIKE '%red%'		AND ListPrice BETWEEN 600 AND 1500;	