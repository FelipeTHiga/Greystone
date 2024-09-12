-- Lesson 11
-- Part 2 – Multiple CTE’s (Common Table Expressions)

-- 1. In order to prepare an annual order report by customer, which includes both the
-- customer's details and the summarized sales data, proceed according to the
-- following instructions:
-- a. Define a Person_CTE, based on the Sales.Customer and Person.Person
-- tables, which displays the following columns: CustomerID, First name, and
-- Last name.
-- b. Define a Sales_CTE that compiles the number of orders and SubTotals for
-- each year and customer, in the following columns: CustomerID, Year, Total
-- order quantity and SubTotal.
-- c. Join between the two CTEs you created in the two preceding sections.
-- Display only the data for 2012.
-- d. A point to consider: Where should the filter to display only 2012 data be
-- placed – in the query or in the CTE?

WITH Person_CTE
	AS (
		SELECT 
			c.CustomerID,
			p.FirstName,
			p.LastName
		FROM
			Sales.Customer c
				JOIN Person.Person p
				ON c.PersonID = p.BusinessEntityID
	),
	Sales_CTE
	AS (
		SELECT 
			CustomerID,
			YEAR(OrderDate) OrderYear,
			SUM(SubTotal) YearTotal,
			COUNT(*) OrderTotal
		FROM
			Sales.SalesOrderHeader 
		GROUP BY
			CustomerID,
			YEAR(OrderDate)			
	)
SELECT
	*
FROM
	Person_CTE p
		JOIN Sales_CTE s
			ON p.CustomerID = s.CustomerID
WHERE
	OrderYear = 2012


-- 2. In order to compare the quantity of items offered and the quantity ordered for
-- each color, write a query that displays the product color, the quantity of units of
-- each color ordered, the quantity of order rows per color, and the quantity of items
-- of each color offered in the Products table.
-- Instruction:
-- e. Define a CTE that is based on the Order details and Products tables and
-- contains the following columns: color, total order quantity and quantity of
-- order rows.
-- f. Define a CTE that is based on the Products table only and contains the
-- following columns: color, quantity of products per color.
-- g. Use the two CTEs you defined, and display the following columns for all the
-- colors (i.e., without colorless products): color, total order quantity, total
-- orders, and quantity of products of this color in the Products table. 

WITH Sales_CTE
	AS (
		SELECT
			p.Color,
			SUM(sod.OrderQty) SalesQty,
			COUNT(*) NoOfSales
		FROM 
			Sales.SalesOrderDetail sod
				JOIN Production.Product p
					ON sod.ProductID = p.ProductID
		GROUP BY
			p.Color
	),
	Product_CTE
		AS (
			SELECT
				Color,
				COUNT(*) NoOfItems
			FROM
				Production.Product
			GROUP BY
				Color
		)
SELECT
	s.Color,
	s.SalesQty,
	s.NoOfSales,
	p.NoOfItems
FROM
	Sales_CTE s	
	JOIN Product_CTE p
		ON s.Color = p.Color
WHERE
	p.Color IS NOT NULL