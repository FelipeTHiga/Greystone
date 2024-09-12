-- Lesson 4 --
-- Part 2 – HAVING Clause --

-- 1. Write a query based on the Sales.SalesOrderDetail table , that counts how many
-- rows there are in each order (SalesOrderID). Display the Order number, and the
-- quantity of lines in the order. Display data only for orders that have more than 3
-- lines.
	SELECT 
		SalesOrderID,
		COUNT(*) NoOfOrders
	FROM
		Sales.SalesOrderDetail
	GROUP BY 
		SalesOrderID
	HAVING
		COUNT(*) > 3;
	
-- 2. Write a query based on the Sales.SalesOrderDetail table, that adds up the Line
-- Total for each order (SalesOrderID). Display the Order number, and the Total for
-- Payment for orders that have a Total for Payment above 1000.
	SELECT
		SalesOrderID,
		SUM(LineTotal) PaymentTotal
	FROM
		Sales.SalesOrderDetail
	GROUP BY 
		SalesOrderID
	HAVING
		SUM(LineTotal) > 1000; 

-- 3. How many customers made more than 20 orders? (Each row in the
-- Sales.SalesOrderHeader table represents an order.)
-- Instruction: Write a query based on the data in the Order details table
-- (Sales.SalesOrderDetail) that groups the data according to CustomerID. Add a
-- filter after aggregation, such that only the rows with a Count higher or equal to 20
-- will be displayed.
	SELECT
		CustomerID,
		COUNT(CustomerID) TotalOfOrders
	FROM 
		Sales.SalesOrderHeader
	GROUP BY
		CustomerID
	HAVING
		COUNT(CustomerID) > 20;

-- 4. Which jobs in the company (JobTitle) have 10 employees or more in the same
-- job?
-- Display the list of Jobs (JobTitle) that answer the criteria and the number of
-- employees in that job. Base your answers on the HumanResources.Employee
-- table.
-- Instruction: Write a query that displays the Job Titles and the number of
-- employees in each job from the HumanResources.Employee table. Add a filter
-- that will display only the jobs with 10 employees or more
	SELECT 
		JobTitle,
		COUNT(*) CountJobTitle
	FROM
		HumanResources.Employee
	GROUP BY
		JobTitle
	HAVING
		COUNT(*) >= 10

-- 5. Write a query based on the Sales.SalesOrderDetail table that displays the amount
-- of each product ordered only for products with an amount above 50 units.
-- Instruction: Write a query based on the Sales.SalesOrderDetail table. The query
-- groups the data according to Product ID and calculates the total number of items
-- ordered for each item. (Pay attention to which aggregate function you are using
-- and on which field. Use ERD.)
	SELECT 
		ProductID,
		SUM(OrderQty) ProductsCount
	FROM
		Sales.SalesOrderDetail
	GROUP BY
		ProductID
	HAVING 
		SUM(OrderQty) > 50	

-- 6. Write a query that displays the Last names from the Person.Person table for
-- people whose last name appears 100 times or more in the Person.Person table.
	SELECT 
		LastName,
		COUNT(LastName) TotalAppearances
	FROM
		Person.Person
	GROUP BY 
		LastName
	HAVING
		COUNT(LastName) >= 100;

-- 7. Write a query that displays the Customer ID and total purchase amount (SubTotal)
-- for customers who purchased a total amount over 100,000 in 2012 (all the orders
-- in that year). Base your answer on the Sales.SalesOrderHeader table.
	SELECT 
		CustomerID,
		SUM(SubTotal) TotalPurchased
	FROM
		Sales.SalesOrderHeader
	WHERE
		YEAR(OrderDate)= 2012
	GROUP BY -- Same customer should be agrouped
		CustomerID
	HAVING 
		SUM(SubTotal) > 100000;

	SELECT * from sales.SalesOrderHeader


-- 8. Write a query based on the Sales.SalesOrderDetail table that displays the Order
-- number and the number of lines in each order only for orders with more than 3
-- lines and Order numbers between 45,000 and 50,000, inclusive.
-- Instruction: Before you begin writing the query, examine the columns and data in
-- the Sales.SalesOrderDetail table.
	
	SELECT 
		SalesOrderID,
		Count(*) OrderNumberNoOfLines
	FROM 
		Sales.SalesOrderDetail
	WHERE
		SalesOrderID >= 45000
		AND SalesOrderID <= 50000
	GROUP BY 
		SalesOrderID
	HAVING
		Count(*) > 3;

-- 9. Write a query based on the Person.Person table that displays the Last names and
-- the number of appearances of that name. Display only the Last names that appear
-- between 10 and 50 times.
	SELECT	
		LastName,
		COUNT(*) TotalAppearances
	FROM
		Person.Person
	GROUP BY 
		LastName
	HAVING
		COUNT(*) > 10
		AND COUNT(*) < 50;



	