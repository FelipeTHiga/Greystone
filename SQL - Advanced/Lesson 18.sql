-- LESSON 18
-- 1.
CREATE PROCEDURE spCustSalesPerYear
	@CustID INT,
	@Year INT,
	@NoOfOrders DECIMAL(18,2) OUT,
	@TotalOrderAmount DECIMAL(18,2) OUT
AS
	BEGIN
		SELECT
			@NoOfOrders = COUNT(DISTINCT SalesOrderID), 
			@TotalOrderAmount = SUM(SubTotal)
		FROM
			Sales.SalesOrderHeader
		WHERE
			CustomerID = @CustID
			AND YEAR(OrderDate) = @Year
	END

-- 2.
DECLARE @vTotalOrders INT,
		@vTotalAmount DECIMAL(18,2);

EXEC spCustSalesPerYear 
		29890, 
		2011, 
		@vTotalOrders OUT, 
		@vTotalAmount OUT;

SELECT @vTotalOrders, @vTotalAmount;


-- 3.
ALTER PROCEDURE spOrdersRangeAmount
	@inFromDate DATE,
	@InToDate DATE,
	@inFromSubCategory INT,
	@inToSubCategory INT,
	@inColor VARCHAR(15),
	@TotalAmount DECIMAL(18,2) OUT
AS
	BEGIN
		SELECT
			@TotalAmount = SUM(sod.LineTotal)
		FROM
			Sales.SalesOrderHeader soh
				JOIN Sales.SalesOrderDetail sod
					ON soh.SalesOrderID = sod.SalesOrderID
				JOIN Production.Product p
					ON sod.ProductID = p.ProductID
		WHERE
			soh.OrderDate BETWEEN @inFromDate AND @InToDate
			AND p.ProductSubcategoryID BETWEEN @inFromSubCategory AND @inToSubCategory
			AND p.Color = @inColor 
	END
	
DECLARE @vTotalAmount DECIMAL (10,2);

EXEC spOrdersRangeAmount 
		'2012-01-01',
		'2012-12-31',
		1,
		5,
		'Yellow', 
		@vTotalAmount OUT

SELECT @vTotalAmount AS TotalOrdersAmount;