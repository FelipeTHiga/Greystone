-- Lesson 5 – Advanced Filtering -- -- Part 1 – SELECT DISTINCT, SELECT TOP ---- 1. Copy and run the following queries. What is the difference between the results?
-- a. Query 1:
-- select ProductSubcategoryID
-- from Production.Product
	SELECT 
		ProductSubcategoryID
	FROM
		Production.Product
-- b. Query 2:
-- select distinct ProductSubcategoryID
-- from Production.Product	SELECT DISTINCT
		ProductSubcategoryID
	FROM 		Production.Product-- ANS: The difference is that there aren't repeated results on the second query.-- 2. Write a query that displays the 5 first Department names from the
-- HumanResources.Department table.
	SELECT TOP 5
		[Name]
	FROM
		HumanResources.Department;

-- 3. Write a query that displays all the details of the 20 products with the highest cost
-- (StandardCost) from the Production.Product table.
	SELECT TOP 20
		*
	FROM
		Production.Product
	ORDER BY 
		StandardCost DESC;

-- 4. Write a query that displays the list of Colors of the products from the
-- Production.Product table, where each color appears only once.
	SELECT DISTINCT	
		Color
	FROM
		Production.Product;


-- 5. Display the 10 items with the lowest List Price in the Production.Product table. Do
-- not include items without a price (i.e., Price = 0).
	SELECT TOP 10
		ProductID,
		ListPrice
	FROM
		Production.Product 
	WHERE
		ListPrice <> 0
	ORDER BY
		ListPrice;

-- 6. What does the following query do?
-- select DISTINCT TOP 5 Color
-- from Production.Product-- ANS: This query displays the first five different colors from the table Production.Product-- 7. Display the 10 Customer numbers (CustomerID) and Order totals (SubTotal) for
-- the customers with the highest order amounts in 2012 (OrderDate). Base your
-- answer on the Sales.SalesOrderHeader table.
	SELECT TOP 10
		CustomerID,
		SubTotal
	FROM 
		Sales.SalesOrderHeader
	WHERE
		YEAR(OrderDate) = 2012
	ORDER BY
		SubTotal DESC;



-- 8. Challenge question:
-- What is the number of unique (non-repeating) cities in the Person.Address table?
	SELECT 
		COUNT(DISTINCT City)
	FROM
		Person.[Address];

-- 9. Which are the 10 orders with the highest amounts (SubTotal) in 2013 (OrderDate)?
-- Instruction: Figure out how to ensure that the highest amounts will be at the top?
	SELECT TOP 10
		SalesOrderID,
		OrderDate,
		SubTotal
	FROM 
		Sales.SalesOrderHeader
	WHERE 
		YEAR(OrderDate) = 2013
	ORDER BY
		SubTotal DESC;

-- 10.What does the following query return?
-- select distinct top 10 firstName
-- from person.Person
-- order by firstName
-- ANS: Will display the first 10 first names in alphabetical order without repeating.