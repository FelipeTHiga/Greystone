-- Lesson 8
-- Part 1 – Built-in Functions on Number, String and Date Fields

-- 1. What is the maximum OrderQty that was ordered in one order record in the
-- Sales.SalesOrderDetail table?
	SELECT 
		MAX(OrderQty) MaxOrderQty
	FROM 
		Sales.SalesOrderDetail;

-- 2. How many different products (ProductID) were ordered in 2012?
-- Base your answer on the Sales.SalesOrderDetail and Sales.SalesOrderHeader
-- tables.
	SELECT	
		COUNT(DISTINCT ProductID) TotalDifferentProducts
	FROM
		Sales.SalesOrderDetail AS d
	JOIN
		Sales.SalesOrderHeader AS h
		ON d.SalesOrderID = h.SalesOrderID
	WHERE YEAR(h.OrderDate) = 2012;


-- 3. How many letters are there in the longest FirstName in the Person.Person table?
-- ANS: 24 letters
	SELECT
		MAX(LEN(FirstName)) LongestName
	FROM
		Person.Person;

-- 4. In order to analyze the orders, write a query that displays the following data for
-- each order in the Sales.SalesOrderHeader table:
-- SalesOrderID, OrderDate, the year of the order, the month and the day of the
-- week.
	SELECT
		SalesOrderID,
		OrderDate,
		YEAR(OrderDate) OrderYear,
		MONTH(OrderDate) OrderMonth,
		DATENAME(WEEKDAY,OrderDate) OrderWeekday 
	FROM	
		Sales.SalesOrderHeader;

-- 5. Which day of the week has the highest number of orders?
-- In order to check the distribution of orders over the days of the week, write a
-- query that shows how many orders were generated on each day of the week. Sort
-- the results in descending order.
-- Instruction: Take the data from the Sales.SalesOrderHeader table. Use the function
-- and operations that were taught in the lesson.
SELECT 
	COUNT(DATENAME(WEEKDAY,OrderDate)) TotalOrderWeekday, 
	DATENAME(WEEKDAY,OrderDate) OrderWeekday 
FROM 
	Sales.SalesOrderHeader
GROUP BY
	DATENAME(WEEKDAY,OrderDate)
ORDER BY
	TotalOrderWeekday DESC;

-- 6. Which day of the week has the highest order amount?
-- Write a query that displays the total order amount for each day of the week.
-- Instruction: Take the data from the Sales.SalesOrderHeader table.
-- Use the function and operations that were taught in the lesson.
SELECT 
	DATENAME(WEEKDAY,OrderDate) OrderWeekday,
	SUM(SubTotal) TotalAmount	
FROM 
	Sales.SalesOrderHeader
GROUP BY
	DATENAME(WEEKDAY,OrderDate)
ORDER BY
	TotalAmount DESC;
	
-- 7. Continuing from the two previous questions, is there a correlation between the
-- number of orders each day of the week and the profitability on that day?
-- If there are differences in the results of the query, what can cause this difference?
-- ANS: Yes, the tendency is the days with the highest number of orders more profit the day has.
-- Any difference in the results can be due to the price of the products sold.

-- 8. Write a query, based on the product and order details tables, that displays the
-- product type (a calculated field – will be defined later), the number of items
-- ordered and the LineTotal for each type of product.
-- Product type definition:
-- ProductType is a calculated field, designated by the two left characters in the
-- ProductNumber column. 

SELECT 
	LEFT(ProductNumber,2) ProductType,
	SUM (s.LineTotal) LineTotal,
	SUM(s.OrderQty) TotalOrdered
FROM Production.Product p
JOIN
	Sales.SalesOrderDetail s
	ON p.ProductID = s.ProductID
GROUP BY	
	LEFT(ProductNumber,2);

-- 9. Continuing from the previous question, in order to understand each product type,
-- link the data to the Production.ProductSubcategory table. Start out from the
-- previous query and add the Name column from the Subcategories table.
-- Instruction:
-- Examine the query, and consider how to add the Name column to the display so
-- that the query will abide by the syntax rules that were taught.SELECT 
	LEFT(p.ProductNumber,2) ProductType,
	SUM (sod.LineTotal) LineTotal,
	SUM(sod.OrderQty) TotalQty,
	ps.[Name]
FROM Production.Product p
JOIN
	Sales.SalesOrderDetail sod
	ON p.ProductID = sod.ProductID
JOIN
	Production.ProductSubcategory ps
	ON p.ProductSubcategoryID = ps.ProductSubcategoryID
GROUP BY	
	LEFT(ProductNumber,2),
	ps.[Name];

-- 10. To be able to send marketing mailings to customers and employees, display the
-- full name from the Person.Person table and the PhoneNumber listed in the
-- Person.PersonPhone table.
-- Note that the full name consists of: FirstName, MiddleName, LastName, and
-- should appear in one column that connects the three columns.
-- Define the full name column in the two ways that were taught. Examine the results
-- and determine which way is the correct solution.
	SELECT 
		CONCAT(p.FirstName,' ' ,p.MiddleName , ' ' ,p.LastName , ' ' ) AS FullNameConcat,
		p.FirstName + ' ' + p.MiddleName + ' ' +  p.LastName AS FullName,			
		ph.PhoneNumber
	FROM 
		Person.Person AS p 
	JOIN 
		Person.PersonPhone AS ph
		ON p.BusinessEntityID = ph.BusinessEntityID

-- 11.Starting from the HumanResources.Employee table, link the Person.Person table
-- to it, and display the following columns for each employee: Full name of the
-- employee (in the preferred method from the previous question, concat function),
-- date of the employee's birthday (BirthDate) and employee's age today. (Today =
-- the day the query is run.)	SELECT 
		CONCAT(p.FirstName,' ' ,p.MiddleName , ' ' ,p.LastName , ' ' ) AS FullNameConcat,
		e.BirthDate,
		DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age
	FROM
		HumanResources.Employee AS e
	JOIN
		Person.Person AS p
		ON e.BusinessEntityID = p.BusinessEntityID;

