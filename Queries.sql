USE SQL_Basic_Project;

-- View all records in Customer Table
Select * from Customer;
-- View all records in Employee Table
Select * from Employee;
-- View all records in Employee_Status Table
Select * from Employee_Status;
-- View all records in Query Table
Select * from Query;
-- View all records in Query_Status Table
Select * from Query_Status;


-- QUERY 1: Find the number of queries under each category
-- Business Case: Determine which category receives the most inquiries so that the company can enhance services in that category

SELECT Query_Category as [Query Category], COUNT(QueryID) as [Number of Queries] from Query
Group By Query_Category
Order By [Number of Queries] DESC;



-- QUERY 2: Display number of queries for each query category and their current status
-- Business Case: Tracking the amount of 'Open' and 'Closed' enquiries for each category to make sure they are being answered in order to uphold business standards 

SELECT Query.Query_Category as [Query Category], Query_Status.Query_Status as [Query Status], COUNT(QueryID) as [Number of Queries]
from Query LEFT JOIN Query_Status 
ON Query.Query_Status_ID = Query_Status.Query_Status_ID
Group By Query_Category, Query_Status
Order By Query_Category;



-- QUERY 3: Find the average turnaround time (TAT in minutes) for solving queries for each category through each channel
-- Business Case: To monitor the time it takes to respond to queries through each channel and make sure that service levels are up to industry standards

SELECT QueryID as [Query ID], Query_Category as Category, Query_Channel as Channel, AVG(DATEDIFF(MINUTE,Query_Creation_Time,Query_TAT)) as [Average Response Time in Minutes]
from Query 
where Query.Query_Status_ID = 4
GROUP BY QueryID, Query_Category, Query_Channel
ORDER BY Query_Category, Query_Channel;



-- QUERY 4: Age groups of the customer and the type of their query
-- Business Case: To determine which age group experiences which problems using the e-commerce website so that the company can make the website user-friendly for all age groups

SELECT Query.Query_Category as [Query Category],AVG(DATEDIFF(year,Customer.DoB,GETDATE())) as [Average Age of Customers]
from Customer JOIN Query 
ON Customer.CustomerID = Query.CustomerID
GROUP BY Query_Category
ORDER BY [Query Category];



-- QUERY 5: Number of queries by Job Role and category
-- Business Case: To look into the company training module allocation, it is necessary to determine what types of query categories are resolved by different job positions

SELECT Employee.Emp_Job_Role as [Job Title], Query_Category as [Query Category], COUNT(QueryID) as [Number of Queries]
from Query LEFT JOIN Employee
ON Query.EmployeeID = Employee.EmployeeID 
GROUP BY Emp_Job_Role, Query_Category
ORDER BY [Job Title], [Query Category];



-- QUERY 6: Job Title and Category by Average Turnaround Time (TAT in minutes) for closed queries
-- Business Case: To reduce the time needed to respond to queries, verify the average TAT for each employee's job title and query category

SELECT Employee.Emp_Job_Role as [Job Title], Query_Category as [Query Category], COUNT(QueryID) as [Number of Queries], AVG(DATEDIFF(MINUTE,Query_Creation_Time,Query_TAT)) as [Average Turnaround Time (in minutes)]
from Query LEFT JOIN Employee
ON Query.EmployeeID = Employee.EmployeeID 
WHERE Query_Status_ID = 4
GROUP BY Emp_Job_Role, Query_Category
ORDER BY [Job Title], [Query Category];



-- QUERY 7: Check the number of queries alloted to employees who are offline
-- Business Case: To assign the queries that are not "Closed" to the agents who are available

SELECT Status_Table.Employee_Fullname as [Employee Full Name], Status_Table.emp_status as [Current Status], Query_Status_Table.query_status_desc as [Query Status], COUNT(Query_Status_Table.qid) as [Number of Queries]
FROM
(SELECT Query.QueryID as qid, Query.EmployeeID as assigned_emp, Query.Query_Status_ID as qstat_id, Query_Status.Query_Status as query_status_desc 
from Query LEFT JOIN Query_Status ON Query.Query_Status_ID = Query_Status.Query_Status_ID) as Query_Status_Table
JOIN
(SELECT Employee.EmployeeID as empid, CONCAT(Emp_First_Name, ' ',Emp_Last_Name) as Employee_Fullname, Employee_Status_ID, Employee_Status as emp_status
from Employee JOIN Employee_Status ON Employee.Emp_Status_ID =  Employee_Status.Employee_Status_ID) as Status_Table
ON Query_Status_Table.assigned_emp = Status_Table.empid
where Query_Status_Table.qstat_id <> 4 and Status_Table.emp_status='Offline'
GROUP BY Status_Table.Employee_Fullname, Status_Table.emp_status, Query_Status_Table.query_status_desc;



