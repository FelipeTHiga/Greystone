-- Lesson 14-- Part 2 – Select into, Insert into, Update, Delete--1. In the NewProductTable, delete the rows with a ListPrice equal to 0. How many lines
--were deleted?DELETE FROM	NewProductTableWHERE	ListPrice = 0;-- 2. Continuing from the previous question, display the data from the NewProductTable
-- table, and check that there are no rows with a list price equal to 0.
SELECT 
	*
FROM
	dbo.NewProductTable;

-- 3. Update the SubCategoryName of product number 709 in the NewProductTable to
-- read: Blue Socks.
-- What was the value before the change?
UPDATE 
	NewProductTable
SET
	SubCategoryName = 'Blue Socks'
WHERE
	ProductID = 709;

SELECT 
	*
FROM 
	dbo.NewProductTable
WHERE 
	ProductID= 709;

-- 4. Update the SubCategoryName of all the products with the ProductSubcategoryID
-- 24 in the NewProductTable table to read: Long tights
-- What was the value before the change?
-- Check your answer.UPDATE 
	dbo.NewProductTable
SET
	SubCategoryName = 'Long tights'
WHERE
	ProductSubcategoryID = 24;
SELECT 
	*
FROM 
	dbo.NewProductTable
WHERE 
	ProductSubcategoryID = 24;

	
-- 5. Preparation for the next question:
-- Write a query that displays the Product ID and ListPrice columns from the
-- NewProductTable only for the items with ProductIDs 100 and 101.
-- What is the list price of these two items? 500 and 490
SELECT
	ProductID,
	ListPrice
FROM
	dbo.NewProductTable
WHERE
	ProductID IN (100,101)


-- 6. The list prices of products number 100 and 101 in the NewProductTable table,
-- increased by 10%. Write a query that will update the new prices of these products in
-- the NewProductTable.
UPDATE 
	dbo.NewProductTable
SET
	ListPrice = ListPrice * 1.1
WHERE
	ProductID IN (100,101);

-- 7. In the NewProductTable, delete all the rows with a product code between 700 and
-- 850 (inclusive) and a ProductCategoryID of 2 or 3.
-- How many rows were deleted?
DELETE FROM 
	dbo.NewProductTable
WHERE 
	ProductID BETWEEN 700 AND 850
	AND (ProductCategoryID = 2 
	OR ProductCategoryID = 3);

-- 8. Delete all the rows in the NewProductTable.
-- Check your answer
DELETE FROM 
	dbo.NewProductTable;

TRUNCATE TABLE dbo.NewProductTable
