-- Exemple 1
	SELECT
		*
	FROM
		Person.Person
	WHERE
		FirstName = 'Ken';

-- Exemple 2
	SELECT 
		* 
	FROM 
		Production.Product
	WHERE 
		ListPrice > 500.00;

-- Exemple 3
	SELECT 
		* 
	FROM 
		Production.Product
	WHERE 
		ProductNumber > 'N';

-- Exemple 4	
	SELECT 
		*
	FROM 
		Sales.SalesOrderHeader
	WHERE
		OrderDate > '2013-11-07';

-- Exemple 5
	SELECT 
		FirstName,
		LastName
	FROM
		Person.Person
	WHERE 
		FirstName <> 'Ken';

-- Exemple 6
	SELECT 
		*
	FROM 
		Sales.SalesOrderHeader
	WHERE 
		SalesOrderID = 43662

-- Exercice 7
	SELECT 
		ProductID, 
		[Name], 
		ProductNumber, 
		Color 
	FROM 
		Production.Product;

-- Exercice 8
	SELECT 
		* 
	FROM 
		Production.Product;

-- WHERE Clause
-- Example 1
	SELECT 
		BusinessEntityID,
		FirstName
	FROM 
		Person.Person
	WHERE
		 FirstName = 'Diane'
		 OR FirstName = 'Mary'
		 OR FirstName = 'Latoya';

-- Example 2
	SELECT 
		ProductID,
		Color,
		ListPrice
	FROM
		Production.Product
	WHERE 
		NOT Color = 'Silver';

		SELECT 
		ProductID,
		Color,
		ListPrice
	FROM
		Production.Product
	WHERE 
		NOT (Color = 'Silver' AND  ListPrice < 700);

		SELECT 
		ProductID,
		Color,
		ListPrice
	FROM
		Production.Product
	WHERE 
		NOT (Color = 'silver' AND ListPrice < 700)
	ORDER BY Color;
	-- Color: Silver/ ListPrice: 800

		SELECT 
		ProductID,
		Color,
		ListPrice
	FROM
		Production.Product
	WHERE 
		NOT (Color = 'Silver') AND  ListPrice < 700
		ORDER BY Color;



