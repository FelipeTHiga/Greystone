-- LESSON 2 --
-- Part 3: Filtering using AND, OR, NOT Operators --

-- 1. Write a query that returns all the product details from the Production.Product
-- table for all the products with the Colors Silver or Black.
	SELECT 
		* 
	FROM 
		Production.Product 
	WHERE 
		Color = 'Silver' 
		OR Color = 'Black';

-- 2. Display the product details for the products from the Production.Product table
-- with a List Price of 1079.99 or lower, except the products with a price of 0. (In
-- other words, do not display the products with a List price of 0.)
-- Display the following columns: ProductID, Color, ListPrice.
	SELECT 
		ProductID, 
		Color, 
		ListPrice 
	FROM 
		Production.Product 
	WHERE 
		ListPrice <= 1079.99 
		AND NOT ListPrice = 0;


-- 3. Write a query that returns all the employee details from the
-- HumanResources.Employee table for all the employees in the following jobs:
-- Research and Development Engineer
-- Design Engineer
-- Display the Employee code (BusinessEntityID), Job title (JobTitle) and User ID
-- (LoginID).
-- Instruction: If you are unsure which field displays the job, write a query that shows
-- all the data in the table. Afterwards, go over it column by column and determine
-- which is the appropriate column, in your opinion.
	SELECT 
		BusinessEntityID, 
		JobTitle, 
		LoginID 
	FROM 
		HumanResources.Employee
	WHERE 
		JobTitle = 'Research and Development Engineer'		
		OR JobTitle = 'Design Engineer';

-- 4. Display the First name, Last name and ID number (BusinessEntityID) of all the
-- people in the Person.Person table whose first name is not: Diane, James, Aaron.
	SELECT 
		FirstName,
		LastName,
		BusinessEntityID
	FROM 
		Person.Person
	WHERE
		NOT FirstName = 'Diane'
		AND NOT FirstName = 'James'
		AND NOT FirstName = 'Aaron';

	SELECT 
		FirstName,
		LastName,
		BusinessEntityID
	FROM 
		Person.Person
	WHERE
		NOT (FirstName = 'Diane'
		OR FirstName = 'James'
		OR FirstName = 'Aaron');

-- 5. Display the Order number (SalesOrderID) and Order date from the
-- Sales.SalesOrderHeader table for all the orders that were issued during January
-- 2013.
-- Instruction: What are the dates in the month of January. Think of the simplest way
-- to include all the dates in a condition.
	SELECT 
		SalesOrderID, 
		OrderDate
	FROM
		Sales.SalesOrderHeader
	WHERE 
		OrderDate <= '2013-01-31'
		AND OrderDate >= '2013-01-01';

-- 6. Display the Product ID, Color, Standard Cost and List Price from the
-- Production.Product table only for the products with the Color Black, Cost higher
-- than 1,000 and List Price lower than 3,000.
	SELECT 
		ProductID, 
		Color, 
		StandardCost, 
		ListPrice
	FROM 
		Production.Product
	WHERE 
		Color = 'Black'
		AND StandardCost > 1000
		AND ListPrice < 3000;