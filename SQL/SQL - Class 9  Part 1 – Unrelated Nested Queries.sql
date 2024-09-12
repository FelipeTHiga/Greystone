-- Lesson 9 
-- Part 1 – Unrelated Nested Queries --

-- 1. Write a query that displays the ProductID, the ListPrice, and the average list price
-- of all the items in the product table.
	SELECT
		ProductID,
		ListPrice,
		(SELECT 
			AVG(ListPrice)
		 FROM
			Production.Product
		) AS AvgListPrice
	FROM 
		Production.Product

-- 2. Continuing from the previous question, name the column with the average list
-- price "AverageListPrice".
-- In addition, make sure that the average price list price is calculated only with the
-- items with a list price greater than 0, so as not to skew the result.
	SELECT
		ProductID,
		ListPrice,
		(SELECT 
			AVG(ListPrice)
		 FROM
			Production.Product
		 WHERE
			ListPrice <> 0
		) AS AverageListPrice
	FROM 
		Production.Product
	

-- 3. Write a query that displays the ProductID and the Item Color from the
-- Production.Product table for the items with the color identical to that of item
-- number 741.
	SELECT
		ProductID,
		Color
	FROM	
		Production.Product
	WHERE
		Color = (
			SELECT 
				Color
			FROM
				Production.Product
			WHERE
				ProductID = '741'
		)

-- 4. Write a query that displays the BusinessEntityID and Gender of all the employees
-- in the employee table whose gender is the same as the gender of the employee
-- with code 38.
	SELECT 
		BusinessEntityID,
		Gender
	FROM
		HumanResources.Employee
	WHERE
		Gender = (
			SELECT Gender
			FROM
				HumanResources.Employee
			WHERE
				BusinessEntityID = 38
		);

-- 5. Continuing from the previous question, add the first and last names of the
-- employees from the Persons table. Use the diagram or ERD to check which
-- column links the tables.
	SELECT 
		e.BusinessEntityID,
		e.Gender,
		p.FirstName,
		p.LastName
	FROM
		HumanResources.Employee e
	JOIN
		Person.Person p
		ON e.BusinessEntityID = p.BusinessEntityID
	WHERE
		Gender = (
			SELECT Gender
			FROM
				HumanResources.Employee
			WHERE
				BusinessEntityID = 38
		);

-- 6. Write a query that displays the orders from the Sales.SalesOrderHeader table that
-- have a SubTotal lower than the average of the SubTotals of all the orders. Display
-- only the order number.
	SELECT
		SalesOrderID
	FROM	
		Sales.SalesOrderHeader
	WHERE 
		SubTotal < (
			SELECT
				AVG(SubTotal)
			FROM
				Sales.SalesOrderHeader -- 3491,0656
		);

-- 7. Continuing from the previous question, display how many orders meet the
-- condition.
	SELECT		
		COUNT(*) CountOrder
	FROM	
		Sales.SalesOrderHeader
	WHERE 
		SubTotal < (
			SELECT
				AVG(SubTotal)
			FROM
				Sales.SalesOrderHeader -- 3491,0656
		);

-- 8. Write a query that displays, the product code, price per item after discount
-- (calculated column), and the difference between the LineTotal of each order
-- record and the average of the LineTotals (a calculated column, named
-- DiffFromAVG) for all the records in the order details table.
	SELECT
		ProductID,
		UnitPrice - UnitPriceDiscount PriceAfterDiscount,
		LineTotal - (
			SELECT 
				AVG(LineTotal)
			FROM
				Sales.SalesOrderDetail
		) AS DiffFromAVG
	FROM	
		Sales.SalesOrderDetail

-- 9. Continuing from the previous question, write a query that displays the product
-- codes and names of all the products in the products table that were ordered at
-- least once in 2013.	
	SELECT DISTINCT
		d.ProductID,			
		p.[Name]
	FROM	
		Sales.SalesOrderDetail d
	JOIN
		Production.Product p
		ON d.ProductID = p.ProductID
	WHERE 
		p.ProductID IN (
			SELECT DISTINCT
				sod.ProductID
			FROM
				Sales.SalesOrderHeader s
			JOIN
				Sales.SalesOrderDetail sod
				ON s.SalesOrderID = sod.SalesOrderID
			WHERE
				YEAR(OrderDate) = 2013
		)

	SELECT
		ProductID,
		[Name]
	FROM
		Production.Product
	WHERE
		ProductID IN (
			SELECT d.ProductID
			FROM
				Sales.SalesOrderDetail d
				JOIN Sales.SalesOrderHeader h
					ON d.SalesOrderID = h.SalesOrderID
				WHERE YEAR(h.OrderDate) = 2013	
		)

-- 10.Continuing from the previous question, write a query that displays the product
-- codes and names of all the products in the product table where the total quantity
-- ordered in 2013 was at least 300 units.
	SELECT DISTINCT
		d.ProductID,
		[Name]
	FROM	
		Sales.SalesOrderDetail d
	JOIN
		Production.Product p
		ON d.ProductID = p.ProductID
	WHERE 
		p.ProductID IN (
			SELECT DISTINCT
				sod.ProductID
			FROM
				Sales.SalesOrderHeader soh
			JOIN
				Sales.SalesOrderDetail sod
				ON soh.SalesOrderID = sod.SalesOrderID
			WHERE
				YEAR(OrderDate) = 2013
			GROUP BY
				ProductID
			HAVING 
				SUM(OrderQty) >= 300
		)

	SELECT
		ProductID,
		[Name]
	FROM
		Production.Product
	WHERE
		ProductID IN (
			SELECT d.ProductID
			FROM
				Sales.SalesOrderDetail d
				JOIN Sales.SalesOrderHeader h
					ON d.SalesOrderID = h.SalesOrderID
				WHERE YEAR(h.OrderDate) = 2013
				GROUP BY ProductID
				HAVING
					SUM(d.OrderQty) >= 300
		)

-- 11.In this query, you must check the quantity and value of orders in 2013, of the ten
-- products with the highest quantity of orders in 2012.In other words, check how the
-- ten products that were ordered the most in 2012 functioned in 2013. (Were they
-- ordered many times? Not ordered at all? Are they still profitable?)
-- Instructions: Write a query that shows the order number, product code, product
-- name, quantity of items in the order, and LineTotal per order record of the
-- products ordered in 2013. The query results should show the data for only the ten
-- best-selling products in 2012.
-- Think which tables and columns are involved in the query. Use the ERD for
-- assistance.
	SELECT 
		d.SalesOrderID,
		d.ProductID,		
		p.[Name],
		OrderQty,
		LineTotal
	FROM
		Sales.SalesOrderDetail d
	JOIN Sales.SalesOrderHeader h
		ON d.SalesOrderID = h.SalesOrderID
	JOIN Production.Product p
		ON d.ProductID = p.ProductID
	WHERE
		YEAR(h.OrderDate) = 2013
		AND d.ProductID IN (
				SELECT TOP 10 
					d.ProductID
				FROM
					Sales.SalesOrderDetail d
				JOIN Sales.SalesOrderHeader h
					ON d.SalesOrderID = h.SalesOrderID
				WHERE
					YEAR(h.OrderDate) = 2012
				GROUP BY
					d.ProductID
				ORDER BY
					SUM(d.OrderQty) DESC
		)	
-- 12.Challenge Question:
-- Continuing from the previous question, write a query that displays the following
-- data for each of the ten most ordered products in 2012: product code, product
-- name, total quantity of items ordered in 2013 and total order amount in 2013.