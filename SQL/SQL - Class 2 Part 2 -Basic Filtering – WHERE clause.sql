-- Lesson 2 --
-- Part 2: Basic Filtering – WHERE clause --

-- 1. Write a query that returns the First name, Middle name and Last name of the
-- people with the Middle name J in the Person.Person table.
	SELECT 
		FirstName,
		MiddleName, 
		LastName 
	FROM
		Person.Person 
	WHERE 
		MiddleName = 'J';

-- 2. How many orders were made by customer no. 15148 (CustomerID)? Find it in the
-- Sales.SalesOrderHeader table.	
	SELECT 
		* 
	FROM 
		Sales.SalesOrderHeader 
	WHERE 
		CustomerID = 15148;
-- Ans: 2 orders were made. 

-- 3. Write a query that returns all the orders in the Sales.SalesOrderHeader table that
-- were issued on 31/07/2013 (OrderDate).	
	SELECT 
		* 
	FROM 
		Sales.SalesOrderHeader 
	WHERE 
		OrderDate = '2013-07-31'	

-- 4. Write a query that returns all the product details from the Production.Product
-- table for all the products with the Color Black.	
	SELECT 
		* 
	FROM 
		Production.Product 
	WHERE 
		Color = 'Black';

-- 5. Display the product details for the products from the Production.Product table
-- with a List Price of 1079.99 or lower.
-- Display the following columns: ProductID, Color, ListPrice.	
	SELECT
		ProductID,
		Color,
		ListPrice 
	FROM
		Production.Product 
	WHERE 
		ListPrice <= 1079.99;

-- 6. Display the product details for the products from the Production.Product table
-- with a List Price above 3000.
-- Display the following columns: ProductID, Color, ListPrice.
-- How many such products are there?
	SELECT 
		ProductID, 
		Color, 
		ListPrice 
	FROM
		Production.Product 
	WHERE 
		ListPrice > 3000;
-- Ans: There are 13 products.