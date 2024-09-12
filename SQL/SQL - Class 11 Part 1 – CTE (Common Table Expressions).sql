-- Lesson 11
-- Part 1 � CTE (Common Table Expressions) --


-- 1. Write a query that defines a CTE named "Sales_CTE", which is based on the Order
-- header table, and contains the following columns: Order Number, SalesPersonID,
-- the year in which the order was placed.
-- Analyze only the data that has a value in the SalesPersonID column.
-- Use the CTE you defined, and write a query that shows the amount of orders that
-- each salesperson generated each year.
-- Sort the query results by SalesPersonID and year.
-- Note: With the results of the query, it is possible to evaluate the salespeople's
-- performance, and see whether the salesperson improved their performance or it
-- needs to be strengthened.
-- In addition, take into account when examining the results that data is not provided
-- for all the months in 2011 and 2014.	WITH Sales_CTE		AS (			SELECT				SalesOrderID,				SalesPersonID,				YEAR(OrderDate) SalesYear			FROM				Sales.SalesOrderHeader			WHERE				SalesPersonID IS NOT NULL		)	SELECT		SalesPersonID,		SalesYear,		COUNT(*) TotalSales	FROM		Sales_CTE	GROUP BY		SalesPersonID, SalesYear	ORDER BY		SalesPersonID, SalesYear;-- 2. Write a query that shows the average number of orders for all the years, for all the
-- salespeople. Analyze only the data that has a value in the SalesPersonID column:
-- a. Define a CTE named "Sales_CTE", which is based on the Order header table,
-- and contains the following columns: SalesPersonID, the amount of orders
-- generated by the salesperson.
-- b. Write a query based on the CTE that displays the average order quantity of
-- all the salespeople.	WITH Sales_CTE		AS (			SELECT				SalesPersonID,				COUNT(*) SalesPerPerson			FROM				Sales.SalesOrderHeader			WHERE				SalesPersonID IS NOT NULL			GROUP BY				SalesPersonID		)	SELECT 		AVG(SalesPerPerson) AvgSales	FROM		Sales_CTE;	-- 3. Write a query that defines a CTE named "Person_CTE", which is based on the
-- Sales.Customer and Person.Person tables and contains the following columns:
-- CustomerID, first name and last name.
-- The purpose of the CTE is to make it easier for us to link the
-- Sales.SalesOrderHeader table to the Person.Person table.
-- Use the Order header table and the Person_CTE that you defined to write a query
-- that displays the order number, customer number, first name, last name, and
-- SubTotal.
	WITH Person_CTE
		AS (
			SELECT
				FirstName,
				LastName,
				c.CustomerID
			FROM
				Person.Person p
					JOIN Sales.Customer c
						ON	p.BusinessEntityID = c.PersonID
		)

	SELECT
		soh.SalesOrderID,
		soh.CustomerID,
		p.FirstName,
		p.LastName,
		soh.SubTotal
	FROM
		Sales.SalesOrderHeader soh
			JOIN Person_CTE p
				ON soh.CustomerID = p.CustomerID;

-- 4. Write a query that displays the amount of orders per product color in 2013, sorted
-- from highest to lowest.
-- Use a CTE to simplify the query:
-- a. Define a CTE named "Sales_CTE", which contains the following columns:
-- Order number, OrderDate, ProductID and OrderQty.
-- b. Use the CTE and the Product table to display the amount of orders per
-- product color in 2013, sorted from highest to lowest
	WITH Sales_CTE
		AS (
			SELECT 
				soh.SalesOrderID,
				soh.OrderDate,
				sod.ProductID,
				sod.OrderQty
			FROM
				Sales.SalesOrderDetail sod
					JOIN Sales.SalesOrderHeader soh
						ON sod.SalesOrderID = soh.SalesOrderID
		)
	
	SELECT	 
		p.Color,
		SUM(s.OrderQty) SalesQty
	FROM
		Production.Product p
			JOIN Sales_CTE s
				ON p.ProductID = s.ProductID
	WHERE
		YEAR(s.OrderDate) = 2013
	GROUP BY
		p.Color
	ORDER BY
		SalesQty DESC
