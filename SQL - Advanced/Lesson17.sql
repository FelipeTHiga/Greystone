-- 1. Set up a temporary table named #tmpProduct, and input the data of all the
-- products with a ProductNumber that begins with BK.
SELECT *
INTO
	#tmpProduct
FROM
	Production.Product
WHERE
	ProductNumber LIKE 'BK%';

-- 2
SELECT *
FROM dbo.#tmpProduct; 

-- 3
-- It will not work, because is a different session

-- 4
SELECT
	ProductID,
	ProductNumber,
	Color,
	[Name]
	[Weight],
	ListPrice
INTO
	#tmpNewProduct
FROM	
	Production.Product;

-- PART 2
-- 1
CREATE PROCEDURE spProductList
AS
	BEGIN
		SELECT 
			ProductID,
			ProductNumber,
			[Name]
		FROM 
			Production.Product
	END;

-- 2
EXEC spProductList;

-- 3
DROP PROCEDURE spProductList;

-- 4
CREATE PROCEDURE spRankYears
AS
	BEGIN
		SELECT
			YEAR(soh.OrderDate) AS [Year],
			SUM(sod.OrderQty) AS OrderQty,
			SUM(sod.LineTotal) AS TotalAmount
		FROM
			Sales.SalesOrderHeader soh
				JOIN Sales.SalesOrderDetail sod
					ON soh.SalesOrderID = sod.SalesOrderID
		GROUP BY
			YEAR(soh.OrderDate)
	END;


-- 5
CREATE PROCEDURE spBestSeller
AS
	BEGIN	
		SELECT
			sod.ProductID,
			SUM(sod.OrderQty) AS OrderQty,
			SUM(sod.LineTotal) AS TotalAmount
		FROM
			Sales.SalesOrderHeader soh
				JOIN Sales.SalesOrderDetail sod
					ON soh.SalesOrderID = sod.SalesOrderID
		WHERE
			YEAR(soh.OrderDate) = 2013
		GROUP BY
			sod.ProductID
		ORDER BY 
			TotalAmount DESC
	END

EXEC spBestSeller;

ALTER PROCEDURE spBestSeller
AS
	BEGIN	
		SELECT TOP 20
			sod.ProductID,
			SUM(sod.OrderQty) AS OrderQty,
			SUM(sod.LineTotal) AS TotalAmount,
			RANK() OVER (
				ORDER BY 
					SUM(sod.LineTotal) DESC
			) AS RankByAmount
		FROM
			Sales.SalesOrderHeader soh
				JOIN Sales.SalesOrderDetail sod
					ON soh.SalesOrderID = sod.SalesOrderID
		WHERE
			YEAR(soh.OrderDate) = 2013
		GROUP BY
			sod.ProductID
		ORDER BY 
			TotalAmount DESC
	END

EXEC spBestSeller;

DROP PROCEDURE spBestSeller;


-- PART 3
-- 1
CREATE PROCEDURE spSalesPerYear 
	@Year INT
AS
	BEGIN
		SELECT *
		FROM
			Sales.SalesOrderHeader
		WHERE
			YEAR(OrderDate) = @Year
	END

EXEC spSalesPerYear 2013;
EXEC spSalesPerYear 2014;

ALTER PROCEDURE spSalesPerYear 
	@Year INT,
	@CustID INT
AS
	BEGIN
		SELECT *
		FROM
			Sales.SalesOrderHeader
		WHERE
			YEAR(OrderDate) = @Year
			AND CustomerID = @CustID
	END

EXEC spSalesPerYear 2013, 17767;
EXEC spSalesPerYear 2014, 27386CREATE PROCEDURE spProductList	@ProductNumberPrefix CHAR(2),	@MinListPrice DECIMAL(8,2),	@MaxListPrice DECIMAL(8,2)AS	BEGIN		SELECT			ProductID,			ProductNumber,			[Name],			ListPrice		FROM			Production.Product		WHERE			ProductNumber LIKE CONCAT(@ProductNumberPrefix,'%')			AND ListPrice BETWEEN @MinListPrice AND @MaxListPrice	ENDEXEC spProductList 'bk', 200, 1500;