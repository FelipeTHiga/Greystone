﻿--Write a query that creates a new table named panel_EDA
--, which contains the
--following data:
--(Select the data from the tables that seem appropriate.)
--● SalesOrderID,
--● OrderDate,
--● ShipToAddressID,
--● ShipDate,
--● CustomerID,
--● OrderQty,
--● ProductID,
--● LineTotal

		SELECT 
			soh.SalesOrderID,
			soh.OrderDate,
			soh.ShipToAddressID,
			soh.ShipDate,
			soh.CustomerID,
			sod.ProductID,
			sod.LineTotal
		INTO
			#panel_EDA
		FROM
			Sales.SalesOrderHeader soh
				JOIN Sales.SalesOrderDetail sod
					ON soh.SalesOrderID = sod.SalesOrderID;


		SELECT * 
		FROM #panel_EDA; 
			
			create database Test_DML2

--	2. In the Test_DML database, create a table with the same format as the Order header
--table, with all the data about the orders in 2011.
--Name the table SalesOrderHeader2011.
    StudentNumber INT PRIMARY KEY,
    FirstName VARCHAR(15),
    LastName VARCHAR(15)
);

CREATE NONCLUSTERED INDEX IX_FirstName_LastName
ON Student (FirstName, LastName);


ALTER TABLE Student
ADD 
	Email VARCHAR(255);

INSERT INTO Student (StudentNumber, FirstName, LastName, Email)
VALUES 
	(1, 'Felipe', 'Higa', 'felipetsibana.h@gmail.com'),
	(2, 'Carlos', 'Lozano', 'carlosLnz@gmail.com');


UPDATE student
SET LastName = 'Smith'
WHERE StudentNumber = 2;

SELECT *
FROM Student
WHERE StudentNumber = 2;

UPDATE Student
SET Email = 'felipehiga@gmail.com'
WHERE StudentNumber = 1;

SELECT *
FROM Student
WHERE StudentNumber = 1;


ALTER TABLE Student
DROP COLUMN Email;


-- 10. Go back to the AdventureWorks database we usually work with, and create a VIEW
-- called vSaleItemDetails that contains the detailed order data, i.e., a combination of
-- the data from Order details, Order header, Customer data and Product details, as
-- follows:
-- a. Order details: Order number, Discounted item price (calculated), Total
-- payment per order.
-- b. Order header: Order Date, Customer ID.
-- c. Persons table: First name, Last name.
-- d. Items table: Item name, Item color.

CREATE VIEW 