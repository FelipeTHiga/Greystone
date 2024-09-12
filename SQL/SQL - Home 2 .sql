-------                Assessment-2                -------

-------------------------------------------------
-----   Lesson 4 – Grouping and Aggregate   -----
-------------------------------------------------

-- 1. Write a query that displays the ProductID and total quantity of that product sold
-- from the Sales.SalesOrderDetail table.
-- Display only the products with an Order quantity (OrderQty) between 600 and
-- 850 units.
	SELECT 
		ProductID,
		SUM(OrderQty) AS TotalSold		
	FROM
		Sales.SalesOrderDetail
	GROUP BY
		ProductID
	HAVING
		SUM(OrderQty) >= 600 
		AND SUM(OrderQty) <= 850;

-- 2. Write a query that displays how many people with each Title there are in the
-- Persons table.
-- Sort the results according the number of people with the Title, in descending
-- order.

	SELECT
		Title,
		COUNT(*) TotalPeople
	FROM
		Person.Person
	GROUP BY 
		Title
	ORDER BY 
		TotalPeople DESC;

-----------------------------------------------
-----    Lesson 5 – Advanced filtering   ------------------------------------------------------- 1. Write a query that displays the Business Entity ID, First Name, Middle Name, Last
-- Name, and Modified Date from the Person.Person table.
-- Display the data only for the people whose name ends with the letter "O" and for
-- whom the Modified Date is not between the dates March 1, 2008 and Dec. 1,
-- 2008.
	SELECT 
		BusinessEntityID,
		FirstName,
		MiddleName,
		LastName,
		ModifiedDate
	FROM 
		Person.Person
	WHERE 
		FirstName LIKE '%O'
		AND ModifiedDate NOT BETWEEN '2008-03-01' AND '2008-12-01';

-- 2. Write a query that displays the Product number from the Sales.SalesOrderDetail
-- table for the products with a total order quantity over all the years between 600
-- and 850 units.
	SELECT
		ProductID
	FROM	
		Sales.SalesOrderDetail
	GROUP BY
		ProductID
	HAVING
		SUM(OrderQty) BETWEEN 600 AND 850;


---------------------------------------------------
-----   Lesson 6 – Diagram and Join Tables   ---------------------------------------------------------

-- 1. What are the 3 product colors with the highest order amounts ?
-- Instructions: Write a query that shows the total order amount for each product
-- color. Sort the results from highest to lowest, and display only the first three rows
-- Think which tables contain the detailed data for the orders and the products. Use
-- the ERD page for assistance.

	SELECT TOP 3
		SUM(d.OrderQty) AS TotalOrderQty,
		p.Color
	FROM	
		Sales.SalesOrderDetail d
		JOIN 
			Production.Product p
				ON d.ProductID = p.ProductID
	WHERE
		p.Color IS NOT NULL
	GROUP BY 
		p.Color
	ORDER BY
		TotalOrderQty DESC;



-- 2. Write a query that shows the 10 orders in 2013 (from the Order Header table) with
-- the highest SubTotals, where the customer's last name contains the string 'lan' and
-- the customer's first name does not contain the letter 'r'.
	SELECT TOP 10
		h.SalesOrderID,
		h.SubTotal,
		p.FirstName,
		p.LastName
	FROM
		Sales.SalesOrderHeader h
		JOIN Sales.Customer c
			ON h.CustomerID = c.CustomerID
		JOIN Person.Person p
			ON c.PersonID = p.BusinessEntityID
	WHERE
		 YEAR(h.OrderDate) = 2013
		 AND p.LastName LIKE '%lan%'
		 AND p.FirstName NOT LIKE '%r%'
	ORDER BY
		h.SubTotal DESC

-- 3. Check whether there are products in the Products table that were never sold. If so,
-- display the products’ codes and names.
-- Instructions:
-- Think what "never sold" means and how it is reflected in the data.
-- Think about what type of JOIN is appropriate, and between which tables
	SELECT
		p.ProductID,
		p.[Name]
	FROM
		Production.Product p
		LEFT JOIN Sales.SalesOrderDetail d
			ON p.ProductID = d.ProductID
	WHERE
		d.ProductID IS NULL;


------------------------------------------------
-----   Lesson 7 – Union and Conditions   ------------------------------------------------------

-- 1. In order to better arrange the store and provide a larger display space for items
-- with a higher average order amount, analyze the average quantity of each product
-- ordered during May 2012.
	SELECT 
		ProductID,
		SUM(OrderQty) TotalQty,
		COUNT(*) NoOfSales ,
		CASE	
			WHEN AVG(OrderQty) < 3 THEN 'Low quantity'
			WHEN AVG(OrderQty) <= 6 THEN 'Reasonable quantity'
			ELSE 'High quantity'
		END AS AvgQtyDescribe
	FROM
		Sales.SalesOrderDetail AS d
	JOIN
		Sales.SalesOrderHeader AS h
		ON d.SalesOrderID = h.SalesOrderID
	WHERE 
		h.OrderDate BETWEEN '2012-05-01' AND '2012-05-31'
	GROUP BY
		ProductID
	ORDER BY
		AVG(OrderQty) DESC;



