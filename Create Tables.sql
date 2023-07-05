-- Use the right database
USE SQL_Basic_Project;

-- Create Customer Table
CREATE TABLE SQL_Basic_Project..Customer
(
	CustomerID int PRIMARY KEY,
	First_Name varchar(50) NOT NULL,
	Last_Name varchar(50) NOT NULL,
	Gender char(1) NOT NULL, -- M = Male, F = Female
	DoB datetime NOT NULL, --date of birth
	ResAddress varchar(200), --Residential Address
	Email varchar(100) NOT NULL,
	Mobile varchar(15),
)
GO

-- Create Employee Table
CREATE TABLE SQL_Basic_Project..Employee
(
	EmployeeID int PRIMARY KEY,
	Emp_First_Name varchar(50) NOT NULL,
	Emp_Last_Name varchar(50) NOT NULL,
	Emp_Gender char(1) NOT NULL, -- M = Male, F = Female
	Emp_DoB datetime NOT NULL, -- Date of Birth
	Emp_ResAddress varchar(200), --Residential Address
	Emp_Email varchar(100) NOT NULL,
	Emp_Job_Role varchar(20) NOT NULL,
	Emp_Status_ID tinyint NOT NULL
)
GO

-- Create Employee_Status Table
CREATE TABLE SQL_Basic_Project..Employee_Status
(
	Employee_Status_ID tinyint PRIMARY KEY, -- 1 = Available, 2 = Busy, 3 =  Offline
	Employee_Status varchar(20)
)
GO

-- Create Query Table
CREATE TABLE SQL_Basic_Project..Query
(
	QueryID int PRIMARY KEY,
	Query_Category varchar(50),
	Query_Channel varchar(50),
	Query_Creation_Time datetime,
	Query_TAT datetime,
	EmployeeID int FOREIGN KEY REFERENCES Employee(EmployeeID),
	CustomerID int FOREIGN KEY REFERENCES Customer(CustomerID),
	Query_Status_ID tinyint NOT NULL
)
GO

-- Create Query_Status Table
CREATE TABLE SQL_Basic_Project..Query_Status
(
	Query_Status_ID tinyint PRIMARY KEY, -- 1 = Open, 2 = In Progress, 3 =  Resolved, 4 = Closed
	Query_Status varchar(20)
)
GO