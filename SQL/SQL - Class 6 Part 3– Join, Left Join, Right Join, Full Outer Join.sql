-- Lesson 6 – Diagram and Join Tables ---- Part 3– Join, Left Join, Right Join, Full Outer Join --


-- 1. Write a query that links the Sales.SalesOrderHeader table to the
-- Sales.SalesOrderDetail table and displays all the columns from both tables.
	SELECT 
		* 
	FROM
		Sales.SalesOrderHeader h
			JOIN
				Sales.SalesOrderDetail d
				ON h.SalesOrderID = d.SalesOrderDetailID;

-- 2. Write a query that links the Sales.SalesOrderDetail table to the Production.Product
-- table and displays the following columns: SalesOrderID, ProductID, Name,
-- ProductNumber, and LineTotal.
-- Think which table should be used to display the ProductID column.
	SELECT 
		s.SalesOrderID,
		s.ProductID,
		p.[Name],
		p.ProductNumber,
		s.LineTotal
	FROM
		Sales.SalesOrderDetail s
			JOIN 
				Production.Product p
				ON s.ProductID = p.ProductID;
	

-- 3. In this query we will examine the profitability of each order record:
-- Write a query that links the Sales.SalesOrderDetail table to the Production.Product
-- table and displays the following columns: SalesOrderID, ProductID, LineTotal,
-- StandardCost, OrderQty, and the profit per order record (calculated column).
	SELECT 
		s.SalesOrderID,
		s.ProductID,
		s.LineTotal,
		p.StandardCost,
		s.OrderQty,
		(s.LineTotal - (p.StandardCost * s.OrderQty)) AS Profit
	FROM
		Sales.SalesOrderDetail s
			JOIN
				Production.Product p
				ON s.ProductID = p.ProductID;

	SELECT 
		s.SalesOrderID,
		s.ProductID,
		s.LineTotal,
		p.StandardCost,
		s.OrderQty,
		(s.LineTotal - p.StandardCost) * s.OrderQty AS Profit
	FROM
		Sales.SalesOrderDetail s
			JOIN
				Production.Product p
				ON s.ProductID = p.ProductID;

-- 4. Write a query that links the Sales.SalesOrderHeader table to the
-- Sales.SalesOrderDetail table and displays the following columns: SalesOrderID,
-- OrderDate, ProductID, and LineTotal.
-- Display only the details of the orders from 2012.
	SELECT
		h.SalesOrderID,
		h.OrderDate,
		d.ProductID,
		d.LineTotal
	FROM
		Sales.SalesOrderHeader h
		JOIN
			Sales.SalesOrderDetail d
			ON h.SalesOrderID = d.SalesOrderID
	WHERE
		YEAR(h.OrderDate) = 2012;

-- 5. Write a query that links the Sales.SalesOrderDetail table to the Production.Product
-- table.
-- a. Display the following columns: SalesOrderID, ProductID, and Name.
-- Display only the details of the products for which the color is "Null".
	SELECT
		s.SalesOrderID,
		s.ProductID,
		p.[Name]
	FROM
		Sales.SalesOrderDetail s
			JOIN
				Production.Product p
				ON s.ProductID = p.ProductID
	WHERE
		p.Color IS NULL;

-- b. Must the Color field be selected in the Select section In order to filter the
-- data according to color?-- ANS: No, it not necessary to be selected.-- c. If the columns are not displayed, how can the correctness of the results be
-- verified?-- ANS: You can add the column, verify the results and remove the column again.-- 6. Write a query that links between the Sales.SalesOrderDetail table, the
-- Production.Product table and the Sales.SalesOrderHeader table and displays the
-- following columns: SalesOrderID, OrderDate, ProductID, Color and LineTotal.
	SELECT
		d.SalesOrderID,
		h.OrderDate,
		p.ProductID,
		p.Color,
		d.LineTotal
	FROM
		Sales.SalesOrderDetail d 
			JOIN
				Production.Product p
				ON d.ProductID = p.ProductID
			JOIN
				Sales.SalesOrderHeader h
				ON d.SalesOrderID = h.SalesOrderID;

-- 7. Write a query that displays the quantity of products ordered each year.
-- Instructions: Write a query that links the Sales.SalesOrderDetail table to the
-- Sales.SalesOrderHeader table and groups the data according to year (in a column
-- calculated from the OrderDate field). The query will display the following
-- columns: Year and OrderQty.
	SELECT
		YEAR(h.OrderDate) [Year],
		SUM(d.OrderQty) OrderQty
	FROM
		Sales.SalesOrderDetail d
		JOIN
			Sales.SalesOrderHeader h
			ON d.SalesOrderID = h.SalesOrderID
	GROUP BY
		YEAR(h.OrderDate);


-- 8. Write a query that displays the ProductID and LineTotal only for orders from 2011
-- in which the total paid (LineTotal) is greater than 1,000. (Calculate the date from
-- the OrderDate column.)
	SELECT 
		d.ProductID,
		d.LineTotal
	FROM
		Sales.SalesOrderHeader h
			JOIN
				Sales.SalesOrderDetail d
				ON  h.SalesOrderID = d.SalesOrderID
	WHERE
		YEAR(h.OrderDate) >= 2011
		AND d.LineTotal > 1000;

-- 9. Write a query that displays the customer details of each order in the
-- Sales.SalesOrderHeader table, The following columns should be displayed:
-- SalesOrderID, Order Date, CustomerID, First Name, Last Name, and SubTotal.
-- Sort the data by last name and then by first name.
-- Instruction: Check in ERD which are the relevant tables and what are the
-- relationships between the tables.
	
	SELECT *
	FROM	
		Sales.SalesOrderHeader h
			JOIN
				Sales.Customer c
				ON h.CustomerID = c.StoreID;			
				


	
	
	
	
	SELECT 
		h.SalesOrderID,
		h.OrderDate,
		c.CustomerID,
		p.FirstName,
		p.LastName,
		h.SubTotal
	FROM
		Sales.SalesOrderHeader h
			JOIN
				Sales.Customer c
				ON h.CustomerID = c.CustomerID
			JOIN 
				Person.Person p 
				ON c.PersonID = p.BusinessEntityID
	ORDER BY
		LastName, 
		FirstName;	
-----
	SELECT 
		h.SalesOrderID,
		h.OrderDate,
		h.CustomerID,
		p.FirstName,
		p.LastName,
		h.SubTotal
	FROM
		Sales.SalesOrderHeader h
			JOIN
				Sales.PersonCreditCard c
				ON h.CreditCardID = c.CreditCardID
			JOIN
				Person.Person p
				ON p.BusinessEntityID = c.BusinessEntityID
	ORDER BY
		LastName, 
		FirstName;
		
	SELECT 
		CustomerID,
		CreditCardID
	FROM 
		Sales.SalesOrderHeader;
	
	SELECT 
		COUNT(CustomerID)
	FROM 
		Sales.SalesOrderHeader
	WHERE
		CustomerID IS NULL; -- 1131

	SELECT 31465 - 30334;
-- 10.Read the following query and explain what it does: (Don't run it in SSMS.)
-- select p.ProductID,
-- p.ProductSubcategoryID,
-- c.[Name]
-- From Production.Product
-- left join Production.ProductSubcategory c
-- on p.ProductSubcategoryID = c.ProductSubcategoryID

-- ANS: This query will display the ProductID and the ProductSubcategoryID from the table Product and the the name of the correspondent subcategory from 
-- the ProductSubcategory table. If the table don't have any value in the field Name, then it will be displayed as NULL.

-- 11.Read the following queries: (Don't run them.)
-- a. What will the following query return? Will there be one record or more in the
-- results?
-- select prd.ProductID
-- from Production.product prd
-- where prd.ProductID = 921

-- ANS: 

-- b. Look at the following query. Note that this query is based on the query from
--the previous section, but with an extra link to the Sales.SalesOrderDetail
--table.
--What will the query return? Will one record or more appear in the query
--results? Why?
--select prd.ProductID,
-- prd.[Name],
-- sod.SalesOrderID
--from Production.product prd
-- join Sales.SalesOrderDetail so
-- on sod.ProductID = prd.ProductID
--where prd.ProductID = 921
--12.In order to send marketing mailings to customers, write a query that displays the
--following data for each BusinessEntityID from the Person.BusinessEntityAddress
--table, by linking to the Person.Address table:
--BusinessEntityID, AddressLine1, AddressLine2, City, StateProvinceID.
--13.Continuing from the previous question, can the First and Last Names be added, as
--well? If so, link the table and add the relevant columns to the query results.
--14.Write a query that displays the customer code and the highest order amount
--(SubTotal) in 2012 and 2013 for each customer from the Sales.SalesOrderHeader
--table, Display only the orders with values in both the salesman column and the
--PurchaseOrderNumber column. Check the names of the appropriate columns in
--the table.