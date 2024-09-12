-- Lesson 8
-- Part 2 – Window Functions

--1. Introductory Question:
--Display the last names and first names of all the people who have the last name
--Adams and a first name that starts with the letter J. Sort the data by last name +
--first name.
--Base your answer on the person.person table
	SELECT 
		LastName,
		FirstName
	FROM	
		Person.Person
	WHERE 
		LastName = 'Adams' 
		ANd FirstName LIKE 'J%'

-- 2. Continuing from the previous question, add a column called NameRank in which
-- you rank the results so that for each last name there is an internal ranking
-- according to the alphabetical order of the first names.
	SELECT 
		LastName,
		FirstName,
		RANK() OVER (
				PARTITION BY LastName 
				ORDER BY FirstName
			) AS NameRank
	FROM	
		Person.Person
	WHERE 
		LastName = 'Adams' 
		ANd FirstName LIKE 'J%'

-- 3. Continuing on, copy the query and add another column called NameDenseRank
-- in which you rank the results with the DENSE_RANK function, so that for each last
-- name, there is an internal ranking according to the alphabetical order of the first
-- name.
-- Examine the differences in the results between RANK and DENSE_RANK.

	SELECT 
		LastName,
		FirstName,
		RANK() OVER(
			PARTITION BY LastName 
			ORDER BY FirstName) AS NameRank,
		DENSE_RANK() OVER(
				PARTITION BY LastName 
				ORDER BY FirstName
			) AS NameDenseRank
	FROM	
		Person.Person
	WHERE 
		LastName = 'Adams' 
		ANd FirstName LIKE 'J%'


--4. Display the orders generated on the dates 01/01/2013 - 02/01/2013, based on
--the Order heading table.
--Rate each day's orders from the order with the highest SubTotal amount (rating 1)
--to the lowest. If there are orders with identical amounts, they receive the same
--rating, and then the rating continues from the next number
	SELECT 
		SalesOrderID,
		OrderDate,
		SubTotal,
		DENSE_RANK() OVER (
				PARTITION BY OrderDate
				ORDER BY SubTotal DESC
			) DailyRank
	FROM 
		Sales.SalesOrderHeader
	WHERE
		OrderDate BETWEEN '2013-01-01' AND '2013-01-02';

-- 5. Write a query that displays a line for each month of the year (i.e., a line for each of
-- the months: January 2011, February 2011 ... January 2012, February 2012...), and
-- rank the months of each year separately according to the total sales (SubTotal) in
-- that month. (2011 has its own ranking, and the ranking starts again for 2012.)
-- Sort the query results by year, and ranking.	SELECT		YEAR(OrderDate) AS [Year],		MONTH(OrderDate) AS [Month],		SUM(SubTotal) MonthlyTotalAmount,		RANK() OVER(				PARTITION BY YEAR(OrderDate)				ORDER BY SUM(SubTotal) DESC			) AS MonthRank	FROM		Sales.SalesOrderHeader	GROUP BY		YEAR(OrderDate), MONTH(OrderDate)	ORDER BY 		[Year], MonthRank-- 6. Continuing from the previous question, copy the query code, replace the ranking
-- function with the percent_rank() function and run the query.
-- (This function does not turn pink, which is fine.)
-- Replace the sorting within the ranking to ascending.	SELECT		YEAR(OrderDate) AS [Year],		MONTH(OrderDate) AS [Month],		SUM(SubTotal) MonthlyTotalAmount,		PERCENT_RANK() OVER(				PARTITION BY YEAR(OrderDate)				ORDER BY SUM(SubTotal) DESC			) AS MonthRank	FROM		Sales.SalesOrderHeader	GROUP BY		YEAR(OrderDate), MONTH(OrderDate)	ORDER BY 		[Year], MonthRank