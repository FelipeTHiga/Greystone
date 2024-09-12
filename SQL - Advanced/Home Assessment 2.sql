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
-- Describe what each function does.
RETURNS INT
AS
	BEGIN
		DECLARE @TotalOrders INT
		SELECT 
		RETURN @TotalOrders
	END
	
	SELECT dbo.fnGetTotalOrder('2013-10-1', '2013-11-4') AS TotalOrder

-- BETWEEN  AND  
RETURNS DECIMAL(18,2)
AS
	BEGIN
		DECLARE @TotalOrderAmount INT
		SELECT 
		RETURN @TotalOrderAmount
	END

-- Create a procedure called spSubcategoryMinMax that executes a query based on
-- the Products table, and displays the following data for each subcategory
-- (ProductSubcategoryID):
-- the ProductSubcategoryID, the ProductID with the lowest ListPrice in this
-- subcategory, and the ProductID with the highest ListPrice in this sub-category.
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
			ps.ProductSubcategoryID;



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