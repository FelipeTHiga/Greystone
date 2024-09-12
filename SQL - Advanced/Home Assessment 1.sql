--Write a query that creates a new table named panel_EDA
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
--Name the table SalesOrderHeader2011.	SELECT 		*	INTO		Test_DML.dbo.SalesOrderHeader2011	FROM 		Sales.SalesOrderHeader	WHERE		OrderDate BETWEEN '2011-01-01' AND '2011-12-31';	SELECT 		sod.*	INTO		Test_DML.dbo.SalesOrderDetail2011	FROM 		Sales.SalesOrderHeader soh			JOIN Sales.SalesOrderDetail sod				ON soh.SalesOrderID = sod.SalesOrderID	WHERE		OrderDate BETWEEN '2011-01-01' AND '2011-12-31';	SELECT *	FROM Test_DML.dbo.SalesOrderDetail2011;	USE Test_DML;	UPDATE 		dbo.SalesOrderHeader2011	SET 		OrderDate = '2011-01-31'	WHERE		MONTH(OrderDate) = 5;	SELECT *	FROM 		dbo.SalesOrderHeader2011	WHERE		MONTH(OrderDate) = 5;	SELECT		soh2011.SalesOrderID,		soh2011.OrderDate OrderDateUpdated,		soh.OrderDate OrderDateOriginal	FROM		dbo.SalesOrderHeader2011 soh2011			JOIN AdventureWorks2016.Sales.SalesOrderHeader soh				ON soh2011.SalesOrderID = soh.SalesOrderID	WHERE		MONTH(soh.OrderDate) = 5;CREATE TABLE Student (
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

CREATE VIEW 	vSaleItemDetailsAS 	SELECT		sod.SalesOrderID,		sod.UnitPrice * (1 - UnitPriceDiscount) DiscountedItemPrice,		soh.SubTotal, 		soh.OrderDate,		soh.CustomerID,		p.FirstName,		p.LastName,		pdc.[Name],		pdc.Color	FROM		Sales.SalesOrderHeader soh			JOIN Sales.SalesOrderDetail sod				ON soh.SalesOrderID = sod.SalesOrderID			JOIN Sales.Customer c				ON soh.CustomerID = c.CustomerID			JOIN Person.Person p				ON c.PersonID =	p.BusinessEntityID			JOIN Production.Product pdc 				ON sod.ProductID = pdc.ProductID;SELECT *FROM	vSaleItemDetails;-- 11			CREATE VIEW 		vSalesPersonPerformance	AS 		SELECT			soh.SalesPersonID,			YEAR(soh.OrderDate) [Year],			p.FirstName,			p.LastName,			COUNT(*) TotalSold,			SUM(soh.SubTotal) TotalAmountSold		FROM			Sales.SalesOrderHeader soh				JOIN Sales.SalesPerson s					ON soh.SalesPersonID = s.BusinessEntityID				JOIN Person.Person p					ON s.BusinessEntityID=	p.BusinessEntityID		GROUP BY			soh.SalesPersonID,			YEAR(soh.OrderDate),			p.FirstName,			p.LastName;						CREATE VIEW 		vCustomerOrderDetails	AS 		SELECT			soh.CustomerID,			p.FirstName,			p.LastName,			COUNT(*) TotalOrders,			SUM(soh.SubTotal) TotalSpent,			MIN(OrderDate) FirstBuy,			MAX(OrderDate) LastBuy		FROM			Sales.SalesOrderHeader soh				JOIN Sales.Customer c					ON soh.CustomerID = c.CustomerID				JOIN Person.Person p					ON c.PersonID =	p.BusinessEntityID		GROUP BY			soh.CustomerID,			p.FirstName,			p.LastName					CREATE VIEW 		vOrderShippingDetails	AS 		SELECT			soh.SalesOrderID,			soh.OrderDate,			soh.ShipDate,			soh.Freight,			s.ShipMethodID,			s.[Name],			a.AddressID,			a.City,			a.PostalCode		FROM			Sales.SalesOrderHeader soh				JOIN Purchasing.ShipMethod s					ON soh.ShipMethodID= s.ShipMethodID				JOIN Person.[Address] a					ON soh.ShipToAddressID = a.AddressID;		