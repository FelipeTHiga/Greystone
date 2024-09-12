-- Lesson 15
-- Part 3

-- 1. Create a new VIEW called vSaleFullDetails that will display data from an Order
-- details table (to be defined in next paragraph), together with important fields from
-- an Order header table.
-- The fields to be displayed:
-- Order number, Order date, Customer number, Quantity ordered, Item price after
-- discount (calculated field � give it a name), total to be paid per row.
-- Note : Examine the columns, recognize the meaning of the values in the columns,
-- and calculate the price after discount. There are several ways to calculate the value
-- in this column. Be sure that you are calculating correctly. It is best to take one line
-- as an example and calculate it manually to check the result.
-- 2. Continuing from the previous question, display the VIEW that was created
-- (vSaleFullDetails).
SELECT 
	* 
FROM
	vSaleFullDetails;

-- 3. Continuing from the previous question, add the following data to the VIEW in the
-- place that seems to be most correct column order:
-- First name of the customer, Last name of the customer.
-- In addition, limit sales details to sales in 2013 only

ALTER VIEW 
-- check that the changes were successfully done
	* 
FROM
	vSaleFullDetails;

-- 5. Create a new VIEW called vSalePerYearSeller that will display the total quantity and
-- value of sales for each SalesPersonID each year (i.e., record for seller 1 for 2011,
-- record for seller 1 year 2012 ... record for seller 2 year 2011, etc.)
-- The fields that to be displayed: Year, SalesPersonID, Total quantity of items sold and
-- Total sales price, grouped by year and seller.
-- an "Annual sales report by seller":
-- a. Try to find a way to sort the records as requested. Only after you have tried,
-- move on to the next section � whether you succeeded and especially if you
-- did not.
-- b. The ORDER BY phrase cannot be written into VIEW, so in order to sort data, a
-- query must be written to retrieve the data and sort it. Do this.

SELECT