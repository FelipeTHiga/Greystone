-- Lesson 7 – Union and Conditions --
-- Part 2 – Case When --

-- 1. Write a query based on the Person.Person table, that displays the following data:
-- • First name
-- • Last name
-- • A column named TitleEdited that will contain the following data:
-- If there is a value in the Title column, it will display it, and if there is no value,
-- it will display "No Title".
	SELECT 
		FirstName,
		LastName,
		CASE 
			WHEN Title IS NULL THEN 'No Title'
			ELSE Title
		END AS TitleEdited
	FROM 
		Person.Person

-- 2. Write a query based on the Production.Product table, that displays the following
-- data:
-- • ProductID
-- • Name
-- • A column named StyleEdited that will contain the information to whom the
-- model is suited, according to the value in the Style column and the following
-- key:
-- a. M ?Man
-- b. W ? Woman
-- c. U ? Unisex 
-- d. No value ? Accessories
	SELECT 
		ProductID,
		[Name],
		CASE Style
			WHEN 'M' THEN 'Man'
			WHEN 'W' THEN 'Woman'
			WHEN 'U' THEN 'Unisex'
			ELSE 'Accessories'
		END AS StyleEdited
	FROM 
		Production.Product;


-- 3. Write a query that ranks each row in the Sales.SalesOrderDetail table, and displays
-- the following data:
-- SalesOrderID, OrderQty, Group Code (details below).
-- The Group code will be based on the value that appears in the Order Quantity
-- column, and the following key:
-- a. up to one item = D
-- b. 2-5 items (inclusive) = C
-- c. 6-30 items (inclusive) = B
-- d. more than 30 = A
	SELECT 
		SalesOrderID,
		OrderQty,
		CASE
			WHEN OrderQty <= 1 THEN 'D'
			WHEN OrderQty <= 5 THEN 'C'
			WHEN OrderQty <= 30 THEN 'B'
			WHEN OrderQty > 30 THEN 'A'			
		END AS GroupCode 
	FROM
		Sales.SalesOrderDetail


-- 4. Challenge question (Continuation from the previous question)
-- The previous query produced a list of all the order records with the rank of each
-- record according to the quantity of items ordered.
-- Now, we want to refine the display to see how many times each group code
-- appears. To do this, write a query that shows how many times each group code (A,
-- B, C, D –according to the data in the previous question) appears in the
-- Sales.SalesOrderDetail table.
-- Instruction: Look at the results of the previous query, and think how the answer
-- could be calculated manually.
	SELECT 
		CASE
			WHEN OrderQty <= 1 THEN 'D'
			WHEN OrderQty <= 5 THEN 'C'
			WHEN OrderQty <= 30 THEN 'B'
			WHEN OrderQty > 30 THEN 'A'			
		END AS GroupCode,
		COUNT(*) AS GroupCodeCount
	FROM 
		Sales.SalesOrderDetail
	GROUP BY 
		CASE
			WHEN OrderQty <= 1 THEN 'D'
			WHEN OrderQty <= 5 THEN 'C'
			WHEN OrderQty <= 30 THEN 'B'
			WHEN OrderQty > 30 THEN 'A'			
		END;


-- 5. In order to segment employees according to gender and marital status, write a
-- query based on the HumanResources.Employee table that shows the number of
-- employees in each segment of gender and family status.
-- To make the results clearer, use the following key to change the displayed data:
-- a. Gender column:
-- • F ? Female
-- • M ? Male
-- b. Marital Status column:
-- • S ? Single
-- • M ? Married
-- • Any other value ? Other
-- Note: Currently the values in this column are only 'S' or 'M', but since there
-- are other family statuses (e.g., widowed, divorced, etc.), the query shoud
-- support the other options and classify them as other

	SELECT 
		CASE Gender	
			WHEN 'F' THEN 'Female'
			ELSE 'Male'
		END AS Gender,
		CASE MaritalStatus
			WHEN 'S' THEN 'Single'
			WHEN 'M' THEN 'Married'
			ELSE 'OTHER'
		END AS 'MaritalStatus',
		COUNT(*) AS NoOfEmployee
	FROM
		HumanResources.Employee
	GROUP BY 
		Gender, MaritalStatus;

-- 6. Write a query that displays the SubTotal of every order from the Order Header
-- table according to the following rules:
-- a. All orders under 1000 ? Low
-- b. All orders of 1000 or more, but less than 3000 ? Good
-- c. All other orders ? Excellent

	SELECT 
		SubTotal,
		CASE
			WHEN SubTotal < 1000 THEN 'Low'
			WHEN SubTotal < 3000 THEN 'Good'
			ELSE 'Excellent'
		END AS 'PriceDescription'
	FROM 
		Sales.SalesOrderHeader

-- 7. Challenge question:
-- Continuing from the previous question, now display how many orders of each
-- price type there are.
-- Instruction: Before you start solving it, think about the way you would solve it if you
-- were doing it manually.	SELECT 
		COUNT(*) CountSales,
		CASE
			WHEN SubTotal < 1000 THEN 'Low'
			WHEN SubTotal < 3000 THEN 'Good'
			ELSE 'Excellent'
		END AS 'PriceDescription'
	FROM 		Sales.SalesOrderHeader	GROUP BY		CASE
			WHEN SubTotal < 1000 THEN 'Low'
			WHEN SubTotal < 3000 THEN 'Good'
			ELSE 'Excellent'
		END;