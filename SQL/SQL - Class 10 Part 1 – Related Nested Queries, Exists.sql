-- Lesson 10 ––
-- Part 1 – Related Nested Queries, Exists --

-- 1. Write a query that displays all the names of the products in the products table that
-- were ordered at least once (Sales.SalesOrderDetail).
-- Solve this twice: once by using In, and a second time by using Exists.
SELECT
	[Name]
FROM
	Production.Product 
WHERE
	ProductID IN (
		SELECT 
			.ProductID
		FROM
			Sales.SalesOrderDetail
	)

SELECT
	[Name]
FROM
	Production.Product p
WHERE EXISTS (
		SELECT 
			sod.ProductID
		FROM
			Sales.SalesOrderDetail sod
		WHERE
			p.ProductID = sod.ProductID
	)

-- 2. Write a query that displays the Name of the product from the Production.Product
-- table that has the word "Wheels" in its sub-category name in the
-- Production.ProductSubcategory table. Solve this using Exists
	SELECT
		[Name]
	FROM
		Production.Product p					
	WHERE EXISTS (
		SELECT *
		FROM
			Production.ProductSubcategory ps
		WHERE
			p.ProductSubcategoryID = ps.ProductSubcategoryID
			AND ps.Name LIKE '%Wheels%'
	)


-- 3. Write a query that displays the data of all the people from the Person.Person table
-- who ordered a product in 2013.
-- Instruction: Consider which tables must be used in the query. (Hint: 3 tables.) Note
-- that each row with person details should appear only once – no more. Solve this
-- using Exists.SELECT 	*FROM	Person.Person pJOIN	Sales.Customer c		ON p.BusinessEntityID = c.PersonIDWHERE EXISTS (	SELECT *	FROM		Sales.SalesOrderHeader soh	WHERE		c.CustomerID = soh.CustomerID		AND YEAR(soh.OrderDate) = 2013) -- 5. Write a query that displays all the columns from the Sales.SalesPerson table but
-- displays only the salespeople who have sold at least one product with the word
-- "frame" in its model name.
-- Instruction:
-- a. Which tables are required for this query? (Hint: 4 tables.) -- Sales.SalesPerson, Production.Product, Sales.SalesOrderDetail, Production.Model 
-- b. Consider which tables link the Sales.SalesPerson table to the
-- Production.ProductModel table, with the knowledge that each item from the
-- Production.Product table has its own ProductModelID.
-- c. Write the outer query, i.e., what is returned as the result of the query.
-- d. Add Exists to the filter, and write the sub-query with the connections
-- between the tables (Join).
-- e. Connect the sub-query to the query that contains it.	
SELECT *
FROM
	Sales.SalesPerson sp
WHERE EXISTS (
	SELECT SalesPersonID
	FROM 
		Sales.SalesOrderHeader soh
	JOIN 
		Sales.SalesOrderDetail sod
			ON soh.SalesOrderID = sod.SalesOrderID
	JOIN 
		Production.Product p
			ON sod.ProductID = p.ProductID			
		WHERE 
			p.ProductModelID IN(
				SELECT 
					ProductModelID
				FROM
					Production.ProductModel
				WHERE
					[Name] like '%frame%'	
			)
		AND sp.BusinessEntityID = soh.SalesPersonID	
)

SELECT *
FROM
	Sales.SalesPerson sp
WHERE EXISTS (
	SELECT 
		SalesPersonID
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
		pm.[Name] like '%frame%'	
		AND sp.BusinessEntityID = soh.SalesPersonID					
)


-- Write a query that displays the first name, last name, JobTitle and the number of
-- employees in that department from the HumanResources.Employee table.
-- Use the HumanResources.Employee and Person.Person tables.
-- Note: This may be solved in several ways. One way includes a link between the
-- internal and outer query, without using Exists. Another solution uses Unrelated
-- Nested Queries.

SELECT
	p.Firstname,
	p.LastName,
	e.JobTitle,
	EmployeeCount.EmployeeTotal
FROM 
	Person.Person p
JOIN
	HumanResources.Employee e
		ON p.BusinessEntityID = e.BusinessEntityID
JOIN 
	HumanResources.EmployeeDepartmentHistory edp
		ON e.BusinessEntityID = edp.BusinessEntityID
JOIN
	(SELECT 
		COUNT(*) EmployeeTotal, 
		DepartmentID 
	FROM 
		HumanResources.EmployeeDepartmentHistory 
	WHERE
		EndDate IS NULL
	GROUP BY DepartmentID) EmployeeCount
		ON edp.DepartmentID = EmployeeCount.DepartmentID
ORDER BY
	e.JobTitle

SELECT
	p.Firstname,
	p.LastName,
	e.JobTitle,
	(SELECT COUNT(*)
	FROM
		HumanResources.Employee e2
	WHERE
		e2.JobTitle = e.JobTitle
	) AmountInDepartiment
FROM 
	Person.Person p
JOIN
	HumanResources.Employee e
		ON p.BusinessEntityID = e.BusinessEntityID;

(SELECT COUNT(*)
	FROM
		HumanResources.Employee e2
	WHERE
		JobTitle = 'Design Engineer'
	)


SELECT
	p.Firstname,
	p.LastName,
	e.JobTitle,
	COUNT(JobTitle)
FROM 
	Person.Person p
JOIN
	HumanResources.Employee e
		ON p.BusinessEntityID = e.BusinessEntityID;