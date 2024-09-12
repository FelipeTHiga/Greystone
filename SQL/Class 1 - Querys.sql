-- LESSON 2 --
-- Part 1 - Basic Data Retrieval --

-- 1. How many records (rows) are in the Production.ProductModel table?
	SELECT * FROM Production.ProductModel;
-- ANS: 128 Rows

-- 2. Examine the data in the table. What is the name of the person in the 20th record of
--the Person.Person table?
	SELECT * FROM Person.Person;
-- ANS: Wanida M Benshoof

-- 3. Examine the table tree in Microsoft SQL Studio Management in your computer
-- and count how many tables there are in HumanResources. (Count manually.)
-- ANS: Six tables.

-- 4. On what date (OrderDate) was Order no. 43742 in the Sales.SalesOrderHeader
-- table issued? (Scroll manually until you find the relevant record/row.)
	SELECT * FROM Sales.SalesOrderHeader;
-- ANS: 2011-06-11 00:00:00.000

-- 5. Write a query that shows all the columns from the Purchasing.Vendor table
	SELECT * FROM Purchasing.Vendor;

-- 6. Write a query that shows the following columns from the Person.Person table:
-- BusinessEntityID, First name, Middle name and Last name
	SELECT 
		Person.BusinessEntityID,
		FirstName,
		MiddleName,
		LastName 
	FROM 
		Person.Person;
  
-- 7. Write a query that shows the following columns from the Production.Product
-- table: ProductID, [Name], ProductNumber, Color.	SELECT 
		ProductID, 
		[Name], 
		Color 
	FROM 
		Production.Product;

-- 8. Write a query that shows all the columns from the Production.Product table.	SELECT * FROM Production.Product;
 