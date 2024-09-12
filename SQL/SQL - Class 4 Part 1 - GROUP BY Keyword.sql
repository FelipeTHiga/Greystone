-- Lesson 4 --
-- Part 1 � GROUP BY Keyword --

-- 1. How much income (SubTotal) was there in 2012 (OrderDate)?
-- Instruction: Write a query that answers the question, is based on the
-- Sales.SalesOrderHeader table and filters the data by year. (Use the function
-- YEAR().) 	
	SELECT 
		YEAR(OrderDate) AS [Year],
		SUM(SubTotal) AS TotalIncome
	FROM
		Sales.SalesOrderHeader
	WHERE 
		YEAR(OrderDate) = 2012
	GROUP BY 
		YEAR(OrderDate);
	
-- 2. How much income (SubTotal) was there in 2013 (OrderDate)?
-- Instruction: Write a query that answers the question, based on the
-- Sales.SalesOrderHeader table.
	SELECT 
		YEAR(OrderDate) AS [Year],
		SUM(SubTotal) AS TotalIncome
	FROM
		Sales.SalesOrderHeader
	WHERE 
		YEAR(OrderDate) = 2013
	GROUP BY 
		YEAR(OrderDate);


-- 3. Examine the results of the 2 previous questions and answer the following:
-- a. Was there a rise or drop in sales?
-- ANS: There was a rise in the sales.

-- b. Think what the causes for this may be (based on your general knowledge and life experience).
-- (CustomerID). Use the Sales.SalesOrderHeader table.
-- Instruction: Write a query that groups the data in the Sales.SalesOrderHeader
-- table according to Customer ID and displays the Customer ID and a count of the
-- number of orders. Give a significant name to the column with the number of
-- orders per customer.
	SELECT 
		CustomerID,
		COUNT(*) AS NoOfOrders
	FROM 
		Sales.SalesOrderHeader
	GROUP BY
		CustomerID;

-- 5. Continuing from the previous question, sort the query results according to the
-- number of orders from the highest to the lowest.
	SELECT 
		CustomerID,
		COUNT(*) AS NoOfOrders
	FROM 
		Sales.SalesOrderHeader
	GROUP BY
		CustomerID
	ORDER BY 
		NoOfOrders;
	
-- 6. Continuing from the previous question, add code so that the query will run only
-- on the orders with Order Date 2013.
	SELECT 
		CustomerID,
		COUNT(*) AS NoOfOrders		
	FROM 
		Sales.SalesOrderHeader
	WHERE 
		YEAR(OrderDate) = 2013
	GROUP BY
		CustomerID
	ORDER BY 
		NoOfOrders;

-- 7. Write a query that displays descriptive statistics for each Color from the
-- Production.Product table : quantity of items of the same color, maximum list price,
-- average list price, minimum list price,
-- colors for which the minimum price is 0.
-- Since a product cannot have a price to the customer of 0, copy the query and add
-- a filter to it, so that lines with List Price 0 will not be included in the calculation.
	SELECT 

-- 9. Continuing from the 2 previous questions, use the mouse to select the codes of
-- both queries and run them together. Note that both results will appear in the
-- Results window. These are the corresponding query results.
-- Examine the Average Price column for the colors that had a minimum price of 0.
-- Are there discrepancies in the average?
-- Pay attention to this is a very important point!
-- Sometimes we must filter out data that skew the calculations. Therefore, it is
-- important to verify the data and the results.
-- Instruction: Write a query that shows how many times the same last name repeats
-- for each Last Name in the Person.Person table. Sort the results according to the
-- number of repetitions of the last name in descending order.
-- Hint: Use �Group by� and pay attention to how many fields you choose to display
-- in the query (Select)
	SELECT
		LastName,
		COUNT(*) CountLastName
	FROM 
		Person.Person
	GROUP BY
		LastName
	ORDER BY CountLastName DESC;
	
-- ANS: Diaz appear 211

-- 11.Examine the Order details (Sales.SalesOrderHeader) for 2012. Check the
-- following in the Total Payment for Order field (SubTotal):
	SELECT 
		MAX(SubTotal) HighestOrderAmount,
		MIN(SubTotal) MinOrderAmount,
		AVG(SubTotal) AvgOrderAmount,
		SUM(SubTotal) SumOrderAmount,
		COUNT(*) TotalOfOrder
	FROM 
		Sales.SalesOrderHeader
	WHERE
		YEAR(OrderDate) = 2012;

-- a. What is the highest Order amount?
-- b. What is the lowest Order amount?
-- c. What is the average Order amount?
-- d. What is the total of the Orders?
-- e. How many orders (separate records in Sales.SalesOrderHeader) were issued?