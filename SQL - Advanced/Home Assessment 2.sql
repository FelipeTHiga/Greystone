-- 1. Define a function that takes as parameters a year and a customer number, and
-- returns the quantity of sales for that customer in that year.
-- Call the function and check that it is working properly
CREATE FUNCTION fnGetCustomerSales(
		@CustID INT,
		@Year INT
)
RETURNS INT
AS
	BEGIN
		DECLARE @Result INT
		SELECT
			@Result = COUNT(*)			
		FROM
			Sales.SalesOrderHeader
		WHERE
			 YEAR(OrderDate) = @Year
			AND CustomerID = @CustID
		GROUP BY
			CustomerID,
			YEAR(OrderDate) 
	RETURN @Result
	END
	
	-- 29540 2013 4	
	SELECT dbo.fnGetCustomerSales(29540,2013) SalesQtyFnc

	SELECT
		 COUNT(*) SalesQtyQry		
	FROM
		Sales.SalesOrderHeader
	WHERE
		YEAR(OrderDate) = 2013
		AND CustomerID = 29540
	GROUP BY
		CustomerID,
		YEAR(OrderDate) 

-- 2. Make a list of 4 functions that could be useful in the day-to-day work of a data
-- analyst.
-- Describe what each function does.CREATE FUNCTION fnGetTotalOrder(@MaxDate DATE, @MinDate DATE)
RETURNS INT
AS
	BEGIN
		DECLARE @TotalOrders INT
		SELECT 			@TotalOrders = COUNT(*)		FROM			Sales.SalesOrderHeader		WHERE			OrderDate BETWEEN @MaxDate AND @MinDate  
		RETURN @TotalOrders
	END
	
	SELECT dbo.fnGetTotalOrder('2013-10-1', '2013-11-4') AS TotalOrder

-- BETWEEN  AND  CREATE FUNCTION fnGetTotalOrderAmount(@MaxDate DATE, @MinDate DATE)
RETURNS DECIMAL(18,2)
AS
	BEGIN
		DECLARE @TotalOrderAmount INT
		SELECT 			@TotalOrderAmount = SUM(SubTotal)		FROM			Sales.SalesOrderHeader		WHERE			OrderDate BETWEEN @MaxDate AND @MinDate  
		RETURN @TotalOrderAmount
	END	SELECT dbo.fnGetTotalOrderAmount('2013-10-1', '2013-11-4') AS TotalOrderAmount
CREATE FUNCTION fnGetCustomerFullName(@CustomerID INT)RETURNS VARCHAR(30)AS	BEGIN		DECLARE @FullName Varchar(30)		SELECT 			@FullName = CONCAT_WS(' ', p.FirstName, MiddleName, LastName)		FROM			Person.Person p				JOIN Sales. Customer c					ON p.BusinessEntityID = c.PersonID		WHERED			c.CustomerID = @CustomerID		RETURN @FullName	END--22831SELECT dbo.fnGetCustomerFullName(22831) CustomerFullNameCREATE FUNCTION fnGetProductCategory(@ProductID INT)RETURNS VARCHAR(30)AS	BEGIN		DECLARE @CategoryName Varchar(30)		SELECT			@CategoryName = CASE 				WHEN p.ProductSubcategoryID IS NOT NULL 					AND ps.ProductCategoryID IS NOT NULL THEN pc.[Name]				ELSE 'Product w/o category' 			END		FROM			Production.Product p				LEFT JOIN Production.ProductSubcategory ps					ON p.ProductSubcategoryID = ps.ProductSubcategoryID				LEFT JOIN Production.ProductCategory pc					ON ps.ProductCategoryID = pc.ProductCategoryID		WHERE			p.ProductID = @ProductID		RETURN @CategoryName	END		SELECT dbo.fnGetProductCategory(1) AS CategoryName		SELECT dbo.fnGetProductCategory(900) AS CategoryName	SELECT * FROM Production.Product		-- LESSON 16-- 1. ** Challenge Question **
-- Create a procedure called spSubcategoryMinMax that executes a query based on
-- the Products table, and displays the following data for each subcategory
-- (ProductSubcategoryID):
-- the ProductSubcategoryID, the ProductID with the lowest ListPrice in this
-- subcategory, and the ProductID with the highest ListPrice in this sub-category.		CREATE FUNCTION fnGetProductMaxListPrice(@SubcatID INT)	RETURNS INT	AS		BEGIN			DECLARE @MaxProductID INT			 SELECT TOP 1				@MaxProductID = ProductID			FROM				Production.Product			WHERE				ListPrice = (					SELECT						MAX(ListPrice)					FROM						Production.Product 					WHERE						ProductSubcategoryID = @SubcatID)				AND ProductSubcategoryID = @SubcatID			RETURN @MaxProductID		END	CREATE FUNCTION fnGetProductMinListPrice(@SubcatID INT)	RETURNS INT	AS		BEGIN			DECLARE @MinProductID INT			 SELECT TOP 1				@MinProductID = ProductID			FROM				Production.Product			WHERE				ListPrice = (					SELECT						MIN(ListPrice)					FROM						Production.Product 					WHERE						ProductSubcategoryID = @SubcatID)				AND ProductSubcategoryID = @SubcatID					RETURN @MinProductID		END						CREATE PROCEDURE spSubcategoryMinMaxAS	BEGIN		WITH MinMaxListPrice AS (
			SELECT 
				ProductID,
				ProductSubcategoryID,
				ListPrice,
				MAX(ListPrice) OVER (PARTITION BY ProductSubcategoryID) AS MaxListPrice,
				MIN(ListPrice) OVER (PARTITION BY ProductSubcategoryID) AS MinListPrice
			FROM
				Production.Product
		)
		SELECT
			ps.ProductSubcategoryID,
			(SELECT TOP 1 
				ProductID 
			FROM 
				MinMaxListPrice 
			WHERE 
				ProductSubcategoryID = ps.ProductSubcategoryID 
				AND ListPrice = MinListPrice) AS MinID,
			(SELECT TOP 1 
				ProductID 
			FROM 
				MinMaxListPrice 
			WHERE 
				ProductSubcategoryID = ps.ProductSubcategoryID 
				AND ListPrice = MaxListPrice) AS MaxID  
		FROM
			Production.ProductSubcategory ps
		ORDER BY
			ps.ProductSubcategoryID;	END		EXEC dbo.spSubcategoryMinMax	WITH Max_ListPrice AS (		SELECT 		ProductID,		ProductSubcategoryID	FROM		Production.Product AS p	WHERE		ListPrice = (			SELECT				MAX(ListPrice)			FROM				Production.Product 			WHERE				ProductSubcategoryID = p.ProductSubcategoryID)	), 	Min_ListPrice AS (	SELECT		ProductID,		ProductSubcategoryID	FROM		Production.Product AS p	WHERE		ListPrice = (			SELECT				MIN(ListPrice)			FROM				Production.Product 			WHERE				ProductSubcategoryID = p.ProductSubcategoryID))	SELECT		ps.ProductSubcategoryID,		(SELECT TOP 1			ProductID		 FROM 			Max_ListPrice 		 WHERE			ProductSubcategoryID = ps.ProductSubcategoryID		) MaxID,		(SELECT TOP 1			ProductID		 FROM 			Min_ListPrice 		 WHERE			ProductSubcategoryID = ps.ProductSubcategoryID		) MinID	FROM		Production.ProductSubcategory ps	ORDER BY ps.ProductSubcategoryID



	SELECT 
        psc.ProductSubcategoryID,
        MIN(p.ProductID) AS ProductIDWithLowestListPrice,
        (SELECT p1.ProductID
         FROM Production.Product p1
         WHERE p1.ProductSubcategoryID = psc.ProductSubcategoryID
         ORDER BY p1.ListPrice ASC
         OFFSET 0 ROWS FETCH NEXT 1 ROW ONLY) AS ProductIDWithLowestListPrice,
        (SELECT p2.ProductID
         FROM Production.Product p2
         WHERE p2.ProductSubcategoryID = psc.ProductSubcategoryID
         ORDER BY p2.ListPrice DESC
         OFFSET 0 ROWS FETCH NEXT 1 ROW ONLY) AS ProductIDWithHighestListPrice
    FROM
        Production.Product p
        JOIN Production.ProductSubcategory psc
            ON p.ProductSubcategoryID = psc.ProductSubcategoryID
    GROUP BY 
        psc.ProductSubcategoryID;