SELECT
	d.SalesOrderDetailID,
	d.OrderQty,
	d.UnitPrice,
	d.UnitPriceDiscount,
	YEAR(h.OrderDate) AS YearSale,
	p.Color,
	p.StandardCost,
	d.LineTotal,
	d.LineTotal/d.OrderQty - p.StandardCost AS UnitProfit
INTO 
	#Temp_panel
FROM
	Sales.SalesOrderDetail AS d
		LEFT JOIN Sales.SalesOrderHeader h
			ON d.SalesOrderID = h.SalesOrderID
		LEFT JOIN Production.Product AS p
			ON d.ProductID = p.ProductID
WHERE
	p.ListPrice >= 400;

-- Lesson 14 - DML
-- Part 1 – Select into, Insert into


--1. Write a query that creates a new table called MarketingContacts with the following
--columns from the PersonPerson and Person.EmailAddress tables:
--BusinessEntityID, First name, Middle name, Last name, Email address.
--Display only people who are classified in PersonType as 'IN' and for whom the type
--of business promotion specified in their EmailPromotion details is 1.
SELECT 
	p.BusinessEntityID,
	p.FirstName,
	p.MiddleName,
	p.LastName,
	e.EmailAddress
INTO
	MarketingContacts
FROM
	Person.Person p
		JOIN Person.EmailAddress e
				ON p.BusinessEntityID = e.BusinessEntityID
WHERE
	p.PersonType = 'IN' AND p.EmailPromotion = 1;


-- 2. Display all the data from the new table, MarketingContacts.
SELECT 
	*
FROM
	dbo.MarketingContacts;

-- 3. The cashier made an error while typing the data and a line was omitted. Therefore,
-- add the following data as one more row in the MarketingContacts table:
-- BusinessEntityID = 30000
-- First name = Noam
-- Last name = Morchi
-- Email = noam811@adventure-works.comINSERT INTO		dbo.MarketingContacts (		BusinessEntityID, 		FirstName, 		LastName, 		EmailAddress	)VALUES	(30000,'Noam', 'Morchi','noam811@adventure-works.com');-- 4. Continuing from the previous question, in order to check that the data was input to
-- the MarketingContacts table correctly, write a query that displays only the input
-- rowSELECT 
	*
FROM
	dbo.MarketingContacts
WHERE
	BusinessEntityID = 30000;

-- 5. Write a query that creates a new table called NewProductTable with the following
-- columns from the tables we are working with:
-- a. Product ID
-- b. Category code
-- c. Category name
-- d. Sub-category code
-- e. Sub-category name
-- f. List price
-- g. Item cost
-- Note: Consider from which table each field should be taken.

SELECT	
	pp.ProductID,
	pc.ProductCategoryID,
	pc.[Name] CategoryName,
	ps.ProductSubcategoryID,
	ps.[Name] SubcategoryName,
	pp.ListPrice,
	pp.StandardCost
INTO
	NewProductTable
FROM
	Production.Product pp
		JOIN Production.ProductSubcategory ps
			ON pp.ProductSubcategoryID = ps.ProductSubcategoryID
		JOIN Production.ProductCategory pc
			ON ps.ProductCategoryID = pc.ProductCategoryID		 
			
-- 6. Continuing from the previous question, display the table you created.SELECT 	*FROM 	dbo.NewProductTable;INSERT INTO 	dbo.NewProductTable (		ProductID,		ProductCategoryID,		CategoryName,		ProductSubcategoryID,		SubcategoryName,		ListPrice,		StandardCost	)VALUES 	(100,2,'Components',12,'Mountain Frames', 500, 280),	(101,3 ,'Clothing', 20, 'Gloves', 490, 110);-- 8. Continuing from the previous question, write a query that displays only the two rows
-- that were added to the table.SELECT 	*FROM	dbo.NewProductTableWHERE	ProductID IN (100,101);-- 9. To prepare for the next section, create a new database.CREATE DATABASE Test_DML-- 10.Write a query that creates a new table called SalesPerCustomer2012 in the new
-- database (Test_DML) that displays the SubTotal of each customer for the orders they
-- placed in 2012.
-- The table should consist of the following columns:
-- Customer ID, First name, Last name and SubTotal of the orders from 2012SELECT	c.CustomerID,	p.FirstName,	p.LastName,	SUM(soh.SubTotal) AS TotalSales	INTO	Test_DML.dbo.SalesPerCustomer2012 FROM	Sales.SalesOrderHeader soh		JOIN Sales.Customer c			ON soh.CustomerID = c.CustomerID		JOIN Person.Person p			ON c.PersonID = p.BusinessEntityIDWHERE	OrderDate BETWEEN '2012-01-01' AND '2012-12-31'GROUP BY	c.CustomerID,	p.FirstName,	p.LastName;-- 11.Write a query that displays the resulting table. Pay attention which database you are
-- running the query on.SELECT * FROM	Test_DML.dbo.SalesPerCustomer2012