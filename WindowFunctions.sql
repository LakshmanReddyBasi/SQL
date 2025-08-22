-- Employees Table with Sample Data

CREATE TABLE Employees (
    Name VARCHAR(50),
    Age INT,
    Department VARCHAR(50),
    Salary INT
);

INSERT INTO Employees (Name, Age, Department, Salary) VALUES
('Ramesh', 30, 'Finance', 50000),
('Suresh', 25, 'Finance', 50000),
('Ram', 28, 'Finance', 20000),
('Deep', 32, 'Sales', 30000),
('Pradeep', 29, 'Sales', 20000);
---------------------------------------------------------------------------
select * from employees

-- 1. Aggregate Functions
-- Total Salary of All Employees
SELECT SUM(Salary) AS Total_Salary FROM Employees;

-- Average Salary
SELECT AVG(Salary) AS Average_Salary FROM Employees;

-- Count of Employees
SELECT COUNT(*) AS Total_Employees FROM Employees;

-- Maximum Salary
SELECT MAX(Salary) AS Max_Salary FROM Employees;

-- Minimum Salary
SELECT MIN(Salary) AS Min_Salary FROM Employees;
-------------------------------------------------------------------------------------------------------------

-- 2. Aggregates by Department

SELECT Department,
       SUM(Salary) AS Dept_Total_Salary,
       AVG(Salary) AS Dept_Avg_Salary,
       COUNT(*) AS Dept_Employee_Count,
       MAX(Salary) AS Dept_Max_Salary,
       MIN(Salary) AS Dept_Min_Salary
FROM Employees
GROUP BY Department;

-------------------------------------------------------------------------------------------------------------
-- 2. Aggregate Functions as Window Functions
-- SUM: Total Salary in each Department
SELECT 
    Name, Department, Salary,
    SUM(Salary) OVER(PARTITION BY Department) AS Dept_Total_Salary
FROM Employees;

-- AVG: Average Salary in each Department
SELECT 
    Name, Department, Salary,
    AVG(Salary) OVER(PARTITION BY Department) AS Dept_Avg_Salary
FROM Employees;

-- COUNT: Number of Employees in each Department
SELECT 
    Name, Department, Salary,
    COUNT(*) OVER(PARTITION BY Department) AS Dept_Emp_Count
FROM Employees;

-- MAX: Maximum Salary in each Department
SELECT 
    Name, Department, Salary,
    MAX(Salary) OVER(PARTITION BY Department) AS Dept_Max_Salary
FROM Employees;

-- MIN: Minimum Salary in each Department
SELECT 
    Name, Department, Salary,
    MIN(Salary) OVER(PARTITION BY Department) AS Dept_Min_Salary
FROM Employees;

-------------------------------------------------------------------------------------------------------------

-- Ranking Employees by Salary within Department
SELECT Name, Department, Salary, 
	RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS emp_rank
FROM employees;

-- dense rank (no skipping)
SELECT Name, Department, Salary, 
	DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS emp_dense_rank 
FROM employees;

-- ROW_NUMber(Unique Row Numbers)
SELECT Name, Department, Salary, 
	ROW_NUMBER() OVER(PARTITION BY Department ORDER BY Salary DESC) AS emp_row_no 
FROM employees;


-- Lead: Next Employee Salary within Department
SELECT Name, Department, Salary,
       LEAD(Salary, 1) OVER (PARTITION BY Department ORDER BY Salary) AS Next_Salary
FROM Employees;

-- Lag: Previous Employee Salary within Department
SELECT Name, Department, Salary,
       LAG(Salary, 1) OVER (PARTITION BY Department ORDER BY Salary) AS Previous_Salary
FROM Employees;

-------------------------------------------------------------------------------------------------------------

-- Finding Top N Values in Each Category
SELECT *
FROM (
    SELECT Name, Department, Salary,
           ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary DESC) AS dept_rank
    FROM Employees
) AS Ranked
WHERE dept_rank <= 2;



