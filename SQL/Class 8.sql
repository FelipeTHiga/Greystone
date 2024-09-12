-- Example 1 - ROUND, ABS, SQRT
SELECT 
	ROUND(520.85, 1) AS RoundExample,
	ABS(-100) AS AbsExample,
	SQRT(144) AS SqrtExample;


-- Example 2 - LEN, LEFT, TRIM, RIGHT
SELECT 
	LEN([Name])	AS NameLength,
	LEFT([Name],4) AS LeftName,
	TRIM('		We study SQL		') AS TrimSpace,
	RIGHT([Name],4) AS RightName
FROM
	Production.Product

-- Example 3 - UPPER, CONCAT
SELECT 
	[Name],
	UPPER([Name]) AS UppercaseName,
	CONCAT('We sell ', [Name], ', come and buy!') AS Concatinate
FROM
	Production.Product;

-- Example 4 - REVERSE. SUBSTRING
SELECT 
	[Name],
	REVERSE([Name]) AS ReverseName,
	SUBSTRING([Name], 4, 3) GetSubStr
FROM 
	Production.Product;

-- Example 5 - DATEADD
SELECT 
	DATEADD(YEAR,1,'2020-12-01') Year_1,
	DATEADD(yy,2,'2020-12-01') Year_2,
	DATEADD(QUARTER,1,'2020-12-01') Quorter_1,
	DATEADD(qq,2,'2020-12-01') Quorter_2,
	DATEADD(WEEKDAY,1,'2020-12-01') Weekday_1,
	DATEADD(ww,1,'2020-12-01') Week_1;

-- Example 6 - GETDATE, DATEDIFF
SELECT 
	GETDATE() AS TodayDate,
	DATEDIFF(yy,BirthDate, GETDATE()) EmpAgeInYears
FROM 
	HumanResources.Employee;


-- Example 7 Window Function
SELECT
	AVG(SubTotal),
	YEAR(OrderDate)
FROM	
	Sales.SalesOrderHeader
GROUP BY
	YEAR(OrderDate)

SELECT
	SalesOrderID,
	OrderDate,
	SubTotal,
	AVG(SubTotal) OVER(
			PARTITION BY YEAR(OrderDate)			
		) AS YearAVG
FROM
	Sales.SalesOrderHeader


-- Example 2
SELECT 
	YEAR(OrderDate) AS OrderYear,
	MONTH(OrderDate) AS OrderMonth,
	SUM(SubTotal) AS MonthSumAmonth,
	RANK() OVER(
			PARTITION BY YEAR(OrderDate)
			ORDER BY SUM(SubTotal) DESC
		) MonthRank
FROM
	Sales.SalesOrderHeader
GROUP BY 
	YEAR(OrderDate), MONTH(OrderDate)
ORDER BY
	OrderYear, OrderMonth;
	
SELECT 
	CustomerId,
	SUM(Subtotal) AS TotalPerCustomer	
FROM
	Sales.SalesOrderHeader
WHERE
	YEAR(OrderDate) = 2013
GROUP BY
	CustomerID
Order By SUM(Subtotal) DESC;

SELECT 
	CustomerId,
	SUM(Subtotal) AS TotalPerCustomer,
	NTILE(10) OVER (Order By SUM(Subtotal) DESC) AS Decicle
FROM
	Sales.SalesOrderHeader
WHERE
	YEAR(OrderDate) = 2013
GROUP BY
	CustomerID;

SELECT 
	CustomerID,	
	SalesOrderID,
	OrderDate,
	Subtotal,
	SUM(SubTotal) OVER (PARTITION BY CustomerID ORDER BY SalesOrderID) AS SumTotal
FROM
	Sales.SalesOrderHeader
ORDER BY
	CustomerID;