SELECT
	HumanResources.Employee.NationalIDNumber,
	HumanResources.Employee.JobTitle,
	HumanResources.Employee.HireDate,
	HumanResources.Department.Name as "DepartmentName",
	HumanResources.Department.GroupName,
	HumanResources.EmployeeDepartmentHistory.StartDate,
	HumanResources.EmployeeDepartmentHistory.EndDate
		FROM HumanResources.EmployeeDepartmentHistory 
			JOIN HumanResources.Employee 
				ON HumanResources.EmployeeDepartmentHistory.BusinessEntityID = HumanResources.Employee.BusinessEntityID
			JOIN HumanResources.Department
				ON HumanResources.EmployeeDepartmentHistory.DepartmentID = HumanResources.Department.DepartmentID;
				
SELECT * FROM HumanResources.Employee ;

