-- LESSON 3 --
-- Part 2 – YEAR() function self-study practice, ORDER BY Keyword --

-- 1. On the internet, search for information about the function YEAR (). Remember to
-- add the words SQL Server to your search in order to target relevant results.
-- In order to understand the method and application of the function, you must find
-- answers to the following questions:

-- a. What is the purpose of the function? What is the result that it returns?
-- ANS: The YEAR() function in SQL Server is used to figure out just the year 
--		from a date or time you give it. It gives you back a number that represents that year.

-- b. Does the function take parameters? (Parameter = information that we give
-- the function within the parentheses) What are they?
-- ANS: the YEAR() function needs the date or datetime expression you want to know the year for.

-- c. What is the syntax of the function?
-- ANS: YEAR(date_expression)

-- d. What are some examples for using the function? (Important because it really
-- helps to understand how to use it.)
	-- SELECT YEAR('2024-04-25') FROM table;
	-- SELECT YEAR(DateColumn) FROM table;
	-- SELECT * FROM table WHERE YEAR(DateColumn) = 2022;

-- 2. Write a query that returns the Order number (SalesOrderID), Order date and the
-- Order year (calculated column) from the Sales.SalesOrderHeader table.
	SELECT
		SalesOrderID,
		OrderDate,
		YEAR(OrderDate) AS OrderYear
	FROM
		Sales.SalesOrderHeader;

-- 3. Write a query that returns the BusinessEntityID, Last name and First name from the
-- Person.Person table. Sort the results according to Last name in ascending order,
	SELECT
		BusinessEntityID,
		LastName,
		FirstName
	FROM
		Person.Person
	Order By 
		LastName;

-- 4. Write a query that returns the BusinessEntityID, Last name and First name from the
-- Person.Person table. Sort the results according to Last name in ascending order,
-- and secondary sort according to First name in descending order.
	SELECT
		BusinessEntityID,
		LastName,
		FirstName
	FROM
		Person.Person
	Order By 
		LastName,
		FirstName DESC;

-- 5. Write a query that returns the BusinessEntityID, Last name and First name from the
-- Person.Person table. Sort the results according to Last name in descending order,
-- and secondary sort according to First name in descending order.
	SELECT
		BusinessEntityID,
		LastName,
		FirstName
	FROM
		Person.Person
	Order By 
		LastName DESC,
		FirstName DESC;

-- 6. Write a query that returns the Employee number (BusinessEntityID), Hire Date and
-- Year of birth (a column calculated by function on the BirthYear column) from the
-- HumanResources.Employee table. Sort the results according to Hire date from the
-- newest employee (will appear first) to the oldest (will appear last).
	SELECT
		BusinessEntityID,
		HireDate,
		YEAR(BirthDate) AS BirthYear
	FROM
		HumanResources.Employee
	ORDER BY
		HireDate DESC;

-- 7. Continuing from the previous question, add a filter to display the data only of
-- employees that began working in 2010.
-- Instruction:
-- In which section of the query are the data filtered?
-- What is the value returned by the function YEAR()?
	SELECT
		BusinessEntityID,
		HireDate,
		YEAR(BirthDate) AS BirthYear
	FROM
		HumanResources.Employee
	WHERE
		YEAR(HireDate) = 2010
	ORDER BY
		HireDate DESC;

	SELECT * FROM HumanResources.EmployeeDepartmentHistory;