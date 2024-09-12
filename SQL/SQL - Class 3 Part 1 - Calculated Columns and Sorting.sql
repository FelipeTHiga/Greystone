-- LESSON 3 --
-- Part 1 – Calculated columns and aliases --

-- 1. Margin = the difference between the price list price of the item and its cost, i.e.,
-- the company's profit from the sale of the item.
-- Write a query that returns the Product ID, Product name and Margin from the
-- Production.Product table.
-- To calculate the margin, use the fields ListPrice and StandardCost.
	SELECT 
		ProductID,
		[Name],
		(ListPrice - StandardCost) AS Margin
	FROM 
		Production.Product;

-- 2. Continuing from the previous question, note that there are products with a list
-- price of 0.
-- Adjust the query so that it only displays the products with a list price that is
-- different than 0.
	SELECT 
		ProductID,
		[Name],
		(ListPrice - StandardCost) AS Margin
	FROM 
		Production.Product
	WHERE 
		NOT ListPrice = 0;

-- 3. Write a query that returns the Product ID, List price and List price+12% (a
-- calculated column) from the Production.Product table. Display only the products
-- with a list price that is different than 0.
-- *In the presentation from today’s lesson, you will find the formula for calculating a
-- percentage change.
	SELECT 
		ProductID,
		ListPrice,
		(ListPrice * 1.12) AS 'ListPrice + 12%' 
	FROM
		Production.Product
	WHERE 
		ListPrice <> 0;
	
-- 4. The company learned that item costs will be going up by 12%, so they want to
-- raise prices by 12%.
-- Write a query that returns the following columns from the Production.Product
-- table. only for products with a list price that is different than 0.
-- a. ProductID
-- b. ListPrice
-- c. StandardCost
-- d. Current profit (calculated column: ListPrice less StandardCost)
-- e. List Price after a 12% rise (calculated column)
-- f. Cost after a 12% rise (calculated column)
-- *In the presentation from today’s lesson, you will find the formula for
-- calculating a percentage change.
	SELECT
		ProductID,
		ListPrice,
		StandardCost,
		(ListPrice - StandardCost) AS Profit,
		(ListPrice * 1.12) AS ListPriceRise,
		(StandardCost * 1.12) AS StandardCostRise		
	FROM
		Production.Product
	WHERE 
		ListPrice <> 0;


-- 5. Challenge question:
-- Continuing from the previous question, the company wants to know the difference
-- between the new profit and the old.
-- Add an additional column to the query that displays the difference between the
-- old and new profits (New profit less Old profit).
	SELECT
		ProductID,
		ListPrice,
		StandardCost,
		(ListPrice - StandardCost) AS Profit,
		(ListPrice * 1.12) AS ListPriceRise,
		(StandardCost * 1.12) AS StandardCostRise,
		(1.12 * (ListPrice - StandardCost) - (ListPrice - StandardCost)) AS ProfitDiff
	FROM
		Production.Product
	WHERE 
		ListPrice <> 0;
	
	WITH ProfitCalculation AS(
		SELECT
			ProductID,
			ListPrice,
			StandardCost,
			(ListPrice - StandardCost) AS Profit,
			(ListPrice * 1.12) AS ListPriceRise,
			(StandardCost * 1.12) AS StandardCostRise
		FROM
			Production.Product
		WHERE 
			ListPrice <> 0
		)
	SELECT 
		*,
		((ListPriceRise - StandardCostRise) - Profit) AS ProfitDiff
	FROM
		ProfitCalculation;

-- 6. Continuing from the previous question, examine the results. Will the company
-- profit or lose from the 12% price rise? 
-- ANS: The company will profit with the 12% price rise, 
-- because de difference between the new profit and the old one are positive.