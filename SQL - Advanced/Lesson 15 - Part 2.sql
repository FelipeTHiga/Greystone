-- Lesson 15
-- Part 2

ALTER TABLE 
	Departments
ADD
	[Location] VARCHAR(50) DEFAULT 'Main Office';

ALTER TABLE
	Departments
ADD
	BirthDate DATETIME;

ALTER TABLE 
	Employees
DROP COLUMN PhoneNO;

DROP TABLE Employees;

-- 5 
USE AdventureWorks2016;

SELECT
	soh.SalesOrderID,
	soh.OrderDate,
	soh.CustomerID,
	sod.ProductID,
	sod.OrderQty,
	sod.LineTotal
INTO
	TEST_DDL.dbo.Orders
FROM
	Sales.SalesOrderHeader soh
		JOIN Sales.SalesOrderDetail sod
			ON soh.SalesOrderID = sod.SalesOrderID

USE TEST_DDL;

SELECT 
	* 
FROM dbo.Orders

-- 6
ALTER TABLE 
	dbo.Orders
ADD
	EspecialSale INT DEFAULT 0;

-- 7
SELECT 
	* 
FROM dbo.Orders

-- 8

UPDATE 
	dbo.Orders 
SET
	EspecialSale = 0;

-- 9
UPDATE 
	dbo.Orders 
SET
	EspecialSale = 1
WHERE
	LineTotal > 10000;

-- 10
SELECT 
	*
FROM
	dbo.Orders
ORDER BY
	LineTotal DESC;

-- 11
DELETE FROM 
	dbo.Orders
WHERE
	YEAR(OrderDate) >= 2012
	AND EspecialSale = 1;

-- 12
TRUNCATE TABLE dbo.Orders;

-- 13
DROP TABLE dbo.Orders;