-- 1. Write a query that displays the BusinessEntityID, Vendor name and Account
-- number from the Vendor table.
-- Examine the query results. How many records are there in the table? 104 records
	SELECT
		BusinessEntityID,
		[Name],
		AccountNumber
	FROM
		Purchasing.Vendor

-- 2. Write a query that displays the BusinessEntityID, Vendor name and Account *********
-- number from the Vendor table for vendors whose names end with the word
-- "Company". 	SELECT
		BusinessEntityID,
		[Name],
		AccountNumber
	FROM
		Purchasing.Vendor	WHERE		[Name] LIKE '%Company'-- 3. Write a query that displays the Purchase order ID, Vendor ID, Order date, and total
-- cost per order from the Purchase order header table. 
	SELECT
		PurchaseOrderID,
		VendorID,
		OrderDate,
		TotalDue
	FROM	
		Purchasing.PurchaseOrderHeader

-- 4. Continuing from the previous section, add also the vendor's name to the table.
-- Consider which table can provide the vendor name, and which kind of table
-- connection should be used. (Check the different JOIN types, and whether all the
-- vendors appear in the Vendor table.)
	SELECT
		PurchaseOrderID,
		VendorID,
		v.[Name],
		OrderDate,
		TotalDue
	FROM	
		Purchasing.PurchaseOrderHeader poh
		JOIN Purchasing.Vendor v
			ON poh.VendorID = v.BusinessEntityID

-- 5. Continuing from the previous question, add also the account number from the
-- Vendors table. Display only the orders issued in 2012, and only those from
-- vendors whose account numbers begin with the letters A-I and end with the
-- number 2.
-- In order to filter by vendor name, must the "vendor name" field be chosen in
-- select, as well?
	SELECT
		PurchaseOrderID,
		VendorID,
		v.[Name],
		OrderDate,
		TotalDue,
		v.AccountNumber
	FROM	
		Purchasing.PurchaseOrderHeader poh
		JOIN Purchasing.Vendor v
			ON poh.VendorID = v.BusinessEntityID
	WHERE
		YEAR(OrderDate) = 2012
		AND v.AccountNumber LIKE '[A-I]%2'

-- 6. For each vendor, display the purchase orders that were ordered from them in *********
-- 2012-2013.
-- a. Display the following columns:
-- Purchase order ID, Vendor ID, Vendor name, Order date, and total cost per
-- order.
-- b. Sort by Vendor ID and date in ascending order.
	SELECT
		PurchaseOrderID,
		VendorID,
		v.[Name],
		OrderDate,
		TotalDue
	FROM
		Purchasing.PurchaseOrderHeader poh
			JOIN Purchasing.Vendor v
				ON poh.VendorID = v.BusinessEntityID
	WHERE
		YEAR(OrderDate) BETWEEN 2012 AND 2013
	ORDER BY
		VendorID 

-- 7. Write a query that collects the following data from the Purchase order header *********
-- table for each vendor:
-- Vendor ID, Order Amount and total cost for all orders.
-- Sort the results by total cost per order in descending order.

	SELECT
		VendorID,
		COUNT(*) OrderAmount, -- Calculating the order amount
		SUM(TotalDue) SumTotalDue  -- TotalCost
	FROM
		Purchasing.PurchaseOrderHeader
	GROUP BY
		VendorID
	ORDER BY
		SUM(TotalDue) DESC 

-- 8. Continuing from the previous question, add a column with the total amount of *********
-- items stocked from each vendor.
-- Note that the quantity of items entered into stock (StockedQty) is in the
-- Purchasing.PurchaseOrderDetail table. Consider how best to add the required
-- column.

	WITH Sales_CTE
		AS (
			SELECT
				SUM(StockedQty) SumStockedQtyPerOrder, -- Get the total stocked qty per Order
				pod.PurchaseOrderID
			FROM
				Purchasing.PurchaseOrderDetail pod				
			GROUP BY
				 pod.PurchaseOrderID
		)
	SELECT
		poh.VendorID,
		COUNT(*) OrderAmount,
		SUM(SumStockedQtyPerOrder) SumStockedQtyPerVender,
		SUM(TotalDue) SumTotalDue
	FROM
		Purchasing.PurchaseOrderHeader poh
			JOIN Sales_CTE s
				ON poh.PurchaseOrderID = s.PurchaseOrderID
	GROUP BY
		poh.VendorID
	ORDER BY
		SUM(SumStockedQtyPerOrder) DESC 

-- 9. Write a query that displays the vendor for each product.
-- If there are two vendors for the same product, the product will appear twice in the
-- list: once for the first vendor and a second time for the second vendor.
	SELECT DISTINCT
		ProductID,
		VendorID
	FROM
		Purchasing.PurchaseOrderHeader poh
			JOIN Purchasing.PurchaseOrderDetail pod
				ON  poh.PurchaseOrderID = pod.PurchaseOrderID
	ORDER BY
		ProductID;

--10.Continuing from the previous question, display the number of different products
--that each vendor supplies.
--Instruction: Before beginning to solve, consider how to arrive at the query results
--and plan the method
	SELECT DISTINCT
		VendorID,
		(
			SELECT 
				COUNT(*)
			FROM
			 ( 
				SELECT DISTINCT
					ProductID,
					VendorID
				FROM
					Purchasing.PurchaseOrderHeader poh
						JOIN Purchasing.PurchaseOrderDetail pod
							ON  poh.PurchaseOrderID = pod.PurchaseOrderID
				WHERE
					poh.VendorID = poh2.VendorID
			) CountProductsPerVendor
		) AS ProductSuply 
	FROM	
		Purchasing.PurchaseOrderHeader poh2
	ORDER BY
		ProductSuply DESC

	WITH Product_CTE
		AS (
			SELECT DISTINCT
				ProductID,
				VendorID
			FROM
				Purchasing.PurchaseOrderHeader poh
					JOIN Purchasing.PurchaseOrderDetail pod
						ON  poh.PurchaseOrderID = pod.PurchaseOrderID
		)
	SELECT
		VendorID,
		COUNT(*) ProductSuply
	FROM
		Product_CTE
	GROUP BY
		VendorID
	ORDER BY
		ProductSuply DESC

-- 11.Write a query that displays, the Purchase order ID, the ShipMethodID and the *************
-- Name of the shipping method of each purchase order
	SELECT
		poh.PurchaseOrderID,
		poh.ShipMethodID,
		sm.[Name]
	FROM
		Purchasing.PurchaseOrderHeader poh
			JOIN Purchasing.ShipMethod sm
				ON poh.ShipMethodID = sm.ShipMethodID


-- 12.Continuing from the previous question, display the total number of orders *************
-- shipped by each shipping method.
-- Display the following columns: ShipMethodID, Shipping method Name, Number
-- of Orders shipped by this method. Sort by number of orders shipped by this
-- method in descending order.

-- CTE
	WITH Sales_CTE
		AS ( 		
			SELECT 
				COUNT(*) NoOfOrders,
				ShipMethodID
			FROM 
				Purchasing.PurchaseOrderHeader		
			GROUP BY 
				ShipMethodID	
		)		

	SELECT DISTINCT
		poh.ShipMethodID,
		sm.[Name],
		s.NoOfOrders
	FROM
		Purchasing.PurchaseOrderHeader poh
			JOIN Purchasing.ShipMethod sm
				ON poh.ShipMethodID = sm.ShipMethodID
			JOIN Sales_CTE s
				ON sm.ShipMethodID = s.ShipMethodID
	ORDER BY
		NoOfOrders DESC

-- Only JOIN
	SELECT 
		poh.ShipMethodID,
		sm.[Name],
		COUNT(*) NoOfOrders
	FROM
		Purchasing.PurchaseOrderHeader poh
			JOIN Purchasing.ShipMethod sm
				ON poh.ShipMethodID = sm.ShipMethodID
	GROUP BY
		poh.ShipMethodID, sm.[Name]
	ORDER BY
		NoOfOrders DESC

-- 13.Continuing from the previous question, copy the query and add that only the *************
-- shipping methods used for more than 500 orders will be displayed. 

-- CTE
	WITH Shipment_CTE
		AS (
			SELECT 
				COUNT(*) NoOfOrders,
				ShipMethodID
			FROM 
				Purchasing.PurchaseOrderHeader
			GROUP BY 
				ShipMethodID
		)

	SELECT DISTINCT
		poh.ShipMethodID,
		sm.[Name],
		s.NoOfOrders
	FROM
		Purchasing.PurchaseOrderHeader poh
			JOIN Purchasing.ShipMethod sm
				ON poh.ShipMethodID = sm.ShipMethodID
			JOIN Shipment_CTE s
				ON poh.ShipMethodID =s.ShipMethodID
	WHERE
		NoOfOrders > 500
	ORDER BY
		NoOfOrders DESC

-- Only JOIN
	SELECT 
		poh.ShipMethodID,
		sm.[Name],
		COUNT(*) NoOfOrders
	FROM
		Purchasing.PurchaseOrderHeader poh
			JOIN Purchasing.ShipMethod sm
				ON poh.ShipMethodID = sm.ShipMethodID
	GROUP BY
		poh.ShipMethodID, sm.[Name]
	HAVING
		COUNT(*)> 500
	ORDER BY
		NoOfOrders DESC

--14.Continuing from the previous question, display only the shipping methods used **********
--for more than one quarter of the orders.

-- CTE
	WITH Shipment_CTE
		AS (
			SELECT 
				COUNT(*) NoOfOrders,
				ShipMethodID
			FROM 
				Purchasing.PurchaseOrderHeader
			GROUP BY 
				ShipMethodID
		)
	SELECT DISTINCT
		poh.ShipMethodID,
		sm.[Name],
		s.NoOfOrders
	FROM
		Purchasing.PurchaseOrderHeader poh
			JOIN Purchasing.ShipMethod sm
				ON poh.ShipMethodID = sm.ShipMethodID
			JOIN Shipment_CTE s
				ON poh.ShipMethodID =s.ShipMethodID
	WHERE
		NoOfOrders > (
			SELECT
				SUM(NoOfOrders)/4
					FROM Shipment_CTE
			)
	ORDER BY
		NoOfOrders DESC

-- Subquery
	SELECT 
		poh.ShipMethodID,
		sm.[Name],
		COUNT(*) NoOfOrders
	FROM
		Purchasing.PurchaseOrderHeader poh
			JOIN Purchasing.ShipMethod sm
				ON poh.ShipMethodID = sm.ShipMethodID
	GROUP BY
		poh.ShipMethodID, sm.[Name]
	HAVING
		COUNT(*) > (
				SELECT	
					COUNT(*)/4 
				FROM
					Purchasing.PurchaseOrderHeader
		) 
	ORDER BY
		NoOfOrders DESC


-- 15.Write a query that displays all the order records for the year 2012, and how many
-- items are missing in each order record.
-- a. Display the following columns:
-- Vendor ID, Product ID, OrderQty, Quantity of items missing out of the
-- quantity ordered. (A calculated field. The fields required for the calculation
-- are: Quantity ordered and Stocked Quantity.)
-- b. Sort by Vendor ID in ascending order. 
	SELECT 
		VendorID,
		ProductID,
		OrderQty,
		StockedQty - OrderQty AS MissingQty
	FROM
		Purchasing.PurchaseOrderHeader poh
			JOIN Purchasing.PurchaseOrderDetail pod
				ON  poh.PurchaseOrderID = pod.PurchaseOrderID
	WHERE
		YEAR(OrderDate) = 2012
	ORDER BY
		VendorID;

-- 16.Continuing from the previous question, copy the previous query, adding that only
-- the order records in which all the ordered items were not provided will be
-- displayed.
	SELECT 
		VendorID,
		ProductID,
		OrderQty,
		(StockedQty - OrderQty) * -1 AS MissingQty
	FROM
		Purchasing.PurchaseOrderHeader poh
			JOIN Purchasing.PurchaseOrderDetail pod
				ON  poh.PurchaseOrderID = pod.PurchaseOrderID
	WHERE
		YEAR(OrderDate) = 2012
		AND StockedQty - OrderQty < 0
	ORDER BY
		VendorID;

-- 17.Continuing from the previous questions, write a query that displays the Vendor ID,
-- the quantity of items ordered from them and the quantity items that they failed to
-- deliver for each vendor from whom items were ordered in 2012.
-- Sort by the number of missing items in descending order.
-- CTE
	WITH Vendor_CTE
		AS (
			SELECT 
				VendorID,
				ProductID,
				OrderQty,
				(StockedQty - OrderQty) * -1 AS MissingQty
			FROM
				Purchasing.PurchaseOrderHeader poh
					JOIN Purchasing.PurchaseOrderDetail pod
						ON  poh.PurchaseOrderID = pod.PurchaseOrderID
			WHERE
				YEAR(OrderDate) = 2012
		)
	
	SELECT
		VendorID,
		SUM(OrderQty) TotalOrderQty,
		SUM(MissingQty) TotalMissingQty
	FROM
		Vendor_CTE
	GROUP BY
		VendorID
	ORDER BY
		TotalMissingQty DESC

	-- Only JOIN
	SELECT
		VendorID,
		SUM(OrderQty) TotalOrderQty,
		SUM((StockedQty - OrderQty) * -1) TotalMissingQty
	FROM
			Purchasing.PurchaseOrderHeader poh
				JOIN Purchasing.PurchaseOrderDetail pod
					ON  poh.PurchaseOrderID = pod.PurchaseOrderID
	WHERE
		YEAR(OrderDate) = 2012
	GROUP BY
		VendorID
	ORDER BY
		TotalMissingQty DESC

-- 18.Continuing from the previous question, calculate the percentage of items not
-- delivered out of all the items ordered from the vendor.
-- a. Display the following fields:
-- Vendor ID, total quantity of items ordered, total quantity of missing items,
-- percentage of missing items from all the items ordered (calculated column).
-- b. Hint: The formula for the percentage of missing items from the ordered
-- items: (lack_amount) / (Total_ordered _amount) * 100.
-- c. Display only vendors who were short.
-- d. Sort the data by the missing percentage in descending order. 

--	CTE
	WITH Vendor_CTE
		AS (
			SELECT 
				VendorID,
				ProductID,
				OrderQty,
				StockedQty,
				(StockedQty - OrderQty) * -1 AS MissingQty
			FROM
				Purchasing.PurchaseOrderHeader poh
					JOIN Purchasing.PurchaseOrderDetail pod
						ON  poh.PurchaseOrderID = pod.PurchaseOrderID
			WHERE
				YEAR(OrderDate) = 2012
		)
	SELECT
		VendorID,
		SUM (OrderQty) TotalOrderQty,
		SUM (MissingQty) TotalMissingQty,
		(SUM (StockedQty - OrderQty) * -1.0 / SUM(OrderQty)) * 100 AS MissingPercentage
	FROM
		Vendor_CTE
	GROUP BY
		VendorID
	ORDER BY
		MissingPercentage DESC

-- Only JOIN
	SELECT
		poh.VendorID,
		SUM (pod.OrderQty) AS TotalOrderQty,
		SUM ((pod.StockedQty - pod.OrderQty) * -1) AS TotalMissingQty,
		(SUM ((pod.StockedQty - pod.OrderQty) * -1) / SUM (pod.OrderQty)) * 100 AS MissingPercentage
	FROM
		Purchasing.PurchaseOrderHeader poh
		JOIN Purchasing.PurchaseOrderDetail pod 
			ON poh.PurchaseOrderID = pod.PurchaseOrderID
	WHERE
		YEAR(poh.OrderDate) = 2012
	GROUP BY
		poh.VendorID
	ORDER BY
	 MissingPercentage DESC;


-- 19.Write a query that shows how many items of each product (ProductID) were
-- stocked (StockedQty).
-- Sort by quantity stocked in descending order.

	SELECT
		ProductID,
		SUM(StockedQty) TotalStockedQty
	FROM
		Purchasing.PurchaseOrderDetail
	GROUP BY
		ProductID
	ORDER BY
		TotalStockedQty DESC

-- 20.Continuing from the previous question, display also the product name (from the
-- Production.Product table.) 
	SELECT
		pod.ProductID,
		SUM(StockedQty) TotalStockedQty,
		[Name]
	FROM
		Purchasing.PurchaseOrderDetail pod
			JOIN Production.Product p
				ON pod.ProductID = p.ProductID
	GROUP BY
		pod.ProductID, [Name]
	ORDER BY
		TotalStockedQty DESC

-- 21.In this question, the vendors will be sorted into 4 groups according to the quantity
-- of items purchased from them. In this way we can distinguish who are the main
-- vendors of the store. The groups will be formed to have the same number of
-- suppliers in each group.
-- Write a query that displays the Vendor ID, the total cost of the products purchased
-- from them (in all the years), and Group (Group 1 = the vendors who supplied the
-- highest amount, Group 4 = the vendors who supplied the lowest amount).
	SELECT
		VendorID,
		SUM(TotalDue) TotalPurchased,
		NTILE(4) OVER 
			(ORDER BY SUM(TotalDue) DESC) SuppGroup
	FROM	
		Purchasing.PurchaseOrderHeader
	GROUP BY
		VendorID;


-- 22.Continuing from the previous question, rank the vendors annually according to
-- the amount purchased from them.
-- a. Display the following fields:
-- Vendor ID, year, total cost of items purchased from the vendor, vendor
-- ranking according to total cost of items in descending order (1 = the highest
-- amount purchased in that year).
-- Hint: Window function - rank / dense_rank
-- b. Display a row for each vendor and year (i.e., vendor number 1 - year 2011;
-- vendor number 1 - year 2012; etc.)
-- c. Sort by vendor ID.

	SELECT
		VendorID,
		YEAR(OrderDate) OrderYear,
		SUM(TotalDue) TotalPurchased,
		RANK() OVER 
			(PARTITION BY YEAR(OrderDate)
				ORDER BY SUM(TotalDue) DESC) YearlyRank
	
	FROM	
		Purchasing.PurchaseOrderHeader
	GROUP BY
		VendorID, YEAR(OrderDate)
	ORDER BY
		VendorID

-- 23.For each purchase order from a vendor, display the following columns:
-- Purchase order ID, Vendor ID, OrderDate, DueDate, number of days for the arrival
-- of the shipment (calculated column: Due date - Order date)
-- Sort by number of days for the arrival of the shipment in descending order.	SELECT 		pod.PurchaseOrderID,		VendorID,		OrderDate,		DueDate,		DATEDIFF(DAY, OrderDate,DueDate ) ShipDays	FROM		Purchasing.PurchaseOrderHeader poh			JOIN Purchasing.PurchaseOrderDetail pod				ON poh.PurchaseOrderID = pod.PurchaseOrderID	ORDER BY		ShipDays DESC-- 24.Continuing from the previous question, display the average days for the arrival of
-- the shipment for each vendor.
	SELECT 		VendorID,		AVG(			DATEDIFF(DAY, OrderDate,DueDate)		) AvgShipDays	FROM		Purchasing.PurchaseOrderHeader poh			JOIN Purchasing.PurchaseOrderDetail pod				ON poh.PurchaseOrderID = pod.PurchaseOrderID	GROUP BY		VendorID	ORDER BY		AvgShipDays DESC