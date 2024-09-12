-- Lesson 15 - DDL
-- Part 1 – Create, Constraints, Index
-- 1. Create a new database called Test_DDL. From now on, in this practice, this is the
-- only database that will be used.
	CREATE DATABASE TEST_DDL
	USE TEST_DDL;

-- 2. Add a new table called Departments to the database.
-- The table will contain the following columns:
-- a. DepartmentCode: an integer, Primary key
-- b. Name: A string up to 10 characters long
	CREATE TABLE Departments
	(
		DepartmentCode INT PRIMARY KEY,
		[Name] VARCHAR(10)
	);
-- 3. Create another index for the Departments table that sorts the data according to the
-- value in the Name column.
	CREATE INDEX IXDepartments_Name
		ON Departments
	(
		[Name] ASC
	);
-- 4. Add a new table called Employees to the database.
-- The table will contain the following columns:
-- a. EmployeeNo : an integer, Primary key
-- b. FirstName: a tring up to 20 characters long
-- c. LastName: a string up to 20 characters long
-- d. PhoneNo : a string up to 15 characters long
-- e. Department: an integer, Foreign key to the DepartmentCode column in the
-- Departments table
-- f. Country: a string up to 20 characters long, default is "USA"
	CREATE TABLE Employees(
		EmployeeNo INT PRIMARY KEY,
		FirstName VARCHAR(20),
		LastName VARCHAR(20),
		PhoneNo VARCHAR(15),
		Department INT FOREIGN KEY REFERENCES Departments(DepartmentCode),
		Country VARCHAR(20) DEFAULT 'USA'
	);


-- 5. Create another index for the Employees table that sorts the data first according to
-- the value in the Department column, in ascending order, and second according to
-- the EmployeeNo column, in descending order

	CREATE INDEX 
		IXEmployees_Department_EmployeeNo
	ON
		Employees(
			Department ASC,
			EmployeeNo DESC
		)