--- Lesson 8 – Built-in and Window Functions-- 1. Write a query based on the data in the Orders table that ranks the years according
-- to the profits from all the orders during each year.
-- Instructions:
-- a. Decide which tables are involved in solving the query. Use the ERD for
-- assistance. Hint: 3 tables: SalesOrderHearder, Product and SalesOrderDetail
-- b. How is profit calculated?
-- c. Is the profit calculated per item, or for all the items in the order record?
-- (Pay attention to the OrderQty column.)

SELECT 
	YEAR(OrderDate) YearOrderDate,	
	SUM(sod.LineTotal - (p.StandardCost * sod.OrderQty)) TotalProfit,
	RANK() OVER(
		ORDER BY
			SUM(sod.LineTotal- p.StandardCost * sod.OrderQty) 
	) YearRank
FROM
	Sales.SalesOrderHeader soh
	JOIN Sales.SalesOrderDetail sod
		ON soh.SalesOrderID = sod.SalesOrderID
	JOIN
		Production.Product p
		ON sod.ProductID = p.ProductID
GROUP BY
	YEAR(OrderDate);

--2. Continuing from the previous question: Are the ranking and comparison done
-- annually analytically correct?
-- (To answer this question, examine the order dates and data.)


-- Lesson 9 – Unrelated Nested Queries
-- 1. As an analyst working for AdventureWorks, you are required to check the order
-- data for regular customers only, during 2013.
-- The company defines a regular customer as a customer who already made a
-- purchase from the store in previous years (i.e., bought in 2012 or 2011).
-- For each order in 2013, display the order number, the SubTotal and the difference
-- between the SubTotal of that order and the average for all the orders in 2013,
-- based on the Sales.SalesOrderHeader table,
-- Note: Display the data for regular customers only.
SELECT
	SalesOrderID,
	SubTotal,
	SubTotal - ( 
		SELECT 
			AVG(SubTotal)
		FROM
			Sales.SalesOrderHeader
		WHERE
			YEAR(OrderDate) = 2013
	) DistFromAvg
FROM	
	Sales.SalesOrderHeader
WHERE
	YEAR(OrderDate) = 2013 
	AND CustomerID IN (
		SELECT 
			CustomerID
		FROM
			Sales.SalesOrderHeader
		WHERE 
			YEAR(OrderDate) < 2013
	);


-- 2. Now calculate the same data for all the years and all the customers, similarly to the
-- previous question.
-- For each order in the Sales.SalesOrderHeader table, display the order number,
-- the SubTotal and the difference between the SubTotal of that order and the
-- average for all the orders.

	SELECT
	SalesOrderID,
	SubTotal,
	SubTotal - ( 
		SELECT 
			AVG(SubTotal)
		FROM
			Sales.SalesOrderHeader
	) DistFromAvg
	FROM	
		Sales.SalesOrderHeader;

-- 3. Continuing on from the previous question and based on the query you wrote,
-- display the number of orders that are equal to and above the average, and the
-- number of orders below the average.
-- Hint: You will need to use the tools from previous lessons
-- Instruction: Before you begin writing the query, think how you would solve it
-- manually (i.e., if you got an order table with 10 rows). What calculations would you
-- perform? How would you approach the solution? Once you have found a way to
-- solve this manually, you can convert it into an SQL query

	SELECT 
		CASE 
			WHEN 
				Subtotal > AvgSubtotal
			THEN 'AboveAvg'
			ELSE 'BellowAvg'
		END AS TextDiffFromAvg,
		COUNT(*) AS CountNo
	FROM
		(
		SELECT	
			Subtotal,
			(SELECT AVG(Subtotal) FROM Sales.SalesOrderHeader) AS AvgSubtotal
		FROM
			Sales.SalesOrderHeader
		) AS soh
	GROUP BY 
		CASE 
			WHEN Subtotal > AvgSubtotal
			THEN 'AboveAvg'
			ELSE 'BellowAvg'
		END
			


-- Lesson 10 – Related Nested Queries

-- 1. Write a query that displays the CustomerID, first name and last name of all the
-- customers who ordered at least one product with the word "women" in its model
-- name (Production.ProductModel table, Name column) in 2013. The word can
-- appear at the beginning, middle or end.
-- Instructions:
-- Make sure you have included all the relevant tables in the query.
-- Solve it using "exists".
SELECT 
	c.CustomerID,
	p.FirstName,
	p.LastName
FROM
	Person.Person p
	JOIN Sales.Customer c
		ON p.BusinessEntityID = c.PersonID
WHERE
	EXISTS (
		SELECT 
			soh.CustomerID
		FROM
			Sales.SalesOrderHeader soh
			JOIN 
				Sales.SalesOrderDetail sod
					ON soh.SalesOrderID = sod.SalesOrderID
			JOIN 
				Production.Product p
					ON sod.ProductID = p.ProductID
			JOIN 
				Production.ProductModel pm
					ON p.ProductModelID = pm.ProductModelID
		WHERE
			c.CustomerID = soh.CustomerID
			AND YEAR(soh.OrderDate) = 2013
			AND pm.[Name] LIKE '%women%'
	);


-- 2. Continuing from the previous question, use the query and the tools learned in
-- previous lessons to answer how many customers appeared in question 1.
SELECT 
	COUNT(*) NoOfCustomers
FROM
	(
		SELECT 
		c.CustomerID,
		p.FirstName,
		p.LastName
	FROM
		Person.Person p
		JOIN Sales.Customer c
			ON p.BusinessEntityID = c.PersonID
	WHERE
		EXISTS (
			SELECT 
				soh.CustomerID
			FROM
				Sales.SalesOrderHeader soh
				JOIN 
					Sales.SalesOrderDetail sod
						ON soh.SalesOrderID = sod.SalesOrderID
				JOIN 
					Production.Product p
						ON sod.ProductID = p.ProductID
				JOIN 
					Production.ProductModel pm
						ON p.ProductModelID = pm.ProductModelID
			WHERE
				c.CustomerID = soh.CustomerID
				AND YEAR(soh.OrderDate) = 2013
				AND pm.[Name] LIKE '%women%'
		)	
	) AS Customers;


-- Lesson 11 – CTE (Common Table Expressions)

-- 1. Write a query that shows the salespeople's (SalesPersonID) average annual order
-- amount (from the OrderDate column).
-- First process the data from the Order header table to get the total amount of
-- orders generated by each salesperson in each year. Then calculate the average of
-- the orders per salesperson for each year.
-- Instructions (note all sections):
-- a. Define a CTE that includes the SalesPersonID, year and total orders
-- generated for each year (OrderDate) and salesperson. Calculate only for
-- order records that have a SalesPersonID.--b. Use the CTE you already defined to display the average amount of sellers'
--orders for each year.
WITH Sales_CTE	AS (		SELECT			SalesPersonID,			YEAR(OrderDate) SalesYear,			SUM(SubTotal) TotalYearOrders		FROM			Sales.SalesOrderHeader		WHERE			SalesPersonID IS NOT NULL		GROUP BY			SalesPersonID, 			YEAR(OrderDate) 	)SELECT 	SalesYear,	AVG(TotalYearOrders) YearlyAvgOrderPerSalesPersonFROM	Sales_CTEGROUP BY	SalesYear;