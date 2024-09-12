-- 5. in the same way as in the previous question, create a new function called
-- fnGetProductOrderQty that takes a ProductID and a year, and returns the OrderQty
-- for that product in that year.
-- Think what data type the function returns.
-- Call the function and send a parameter. Check that the result is correct.

CREATE FUNCTION fnGetProductOrderQty(
		@ProdID INT,
		@Year INT
)
RETURNS INT
AS 
	BEGIN
		DECLARE @Result INT
		SELECT 
			@Result = SUM(sod.OrderQty)
		FROM
			Sales.SalesOrderDetail sod
				JOIN Sales.SalesOrderHeader soh
					ON sod.SalesOrderID = soh.SalesOrderID
		WHERE
			sod.ProductID = @prodID
			AND YEAR(soh.OrderDate) = @year
			
		RETURN @Result
	END
