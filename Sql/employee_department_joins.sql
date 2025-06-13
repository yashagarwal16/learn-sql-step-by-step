create database Company;
-- =========================================
-- Sample tables creation and data insertion
-- =========================================
CREATE TABLE Employees (
    EmpID INT,
    EmpName VARCHAR(50),
    DeptID INT
);

CREATE TABLE Departments (
    DeptID INT,
    DeptName VARCHAR(50)
);

INSERT INTO Employees (EmpID, EmpName, DeptID) VALUES
(1, 'Alice', 10),
(2, 'Bob', 20),
(3, 'Charlie', NULL);

INSERT INTO Departments (DeptID, DeptName) VALUES
(10, 'HR'),
(20, 'Finance'),
(30, 'IT');

-----------------------------------------------------------------------------------
-- 1. INNER JOIN
-- Definition: Returns only rows where there is a match in both tables.
-- Why use: To get records that have matching keys in both tables.
-----------------------------------------------------------------------------------
SELECT e.EmpID, e.EmpName, d.DeptName
FROM Employees e
INNER JOIN Departments d ON e.DeptID = d.DeptID;

-----------------------------------------------------------------------------------
-- 2. LEFT JOIN (LEFT OUTER JOIN)
-- Definition: Returns all rows from the left table, and matched rows from the right table.
-- Why use: To get all records from the left table, even if there's no match in the right.
-----------------------------------------------------------------------------------
SELECT e.EmpID, e.EmpName, d.DeptName
FROM Employees e
LEFT JOIN Departments d ON e.DeptID = d.DeptID;

-----------------------------------------------------------------------------------
-- 3. RIGHT JOIN (RIGHT OUTER JOIN)
-- Definition: Returns all rows from the right table, and matched rows from the left table.
-- Why use: To get all records from the right table, even if no matching row on left.
-----------------------------------------------------------------------------------
SELECT e.EmpID, e.EmpName, d.DeptName
FROM Employees e
RIGHT JOIN Departments d ON e.DeptID = d.DeptID;

-----------------------------------------------------------------------------------
-- 4. FULL OUTER JOIN
-- Definition: Returns all rows from both tables, matching where possible.
-- Why use: To get all records from both tables, showing NULLs where no match exists.
-----------------------------------------------------------------------------------
SELECT e.EmpID, e.EmpName, d.DeptName
FROM Employees e
LEFT JOIN Departments d ON e.DeptID = d.DeptID;
SELECT e.EmpID, e.EmpName, d.DeptName
FROM Employees e
RIGHT JOIN Departments d ON e.DeptID = d.DeptID;

-----------------------------------------------------------------------------------
-- 5. CROSS JOIN
-- Definition: Returns the Cartesian product of both tables (all combinations).
-- Why use: When you want every combination of rows between two tables.
-----------------------------------------------------------------------------------
SELECT e.EmpID, e.EmpName, d.DeptName
FROM Employees e
CROSS JOIN Departments d;

-----------------------------------------------------------------------------------
-- 6. SELF JOIN
-- Definition: Joining a table to itself, useful for comparing rows within the same table.
-- Why use: To find related records in the same table (e.g., employees in the same department).
-----------------------------------------------------------------------------------
SELECT e1.EmpName AS Employee1, e2.EmpName AS Employee2, e1.DeptID
FROM Employees e1
JOIN Employees e2 ON e1.DeptID = e2.DeptID AND e1.EmpID <> e2.EmpID;

-----------------------------------------------------------------------------------
-- 7. NATURAL JOIN
-- Definition: Automatically joins tables based on all columns with the same name.
-- Why use: To simplify join syntax when columns to join on share the same names.
-- Note: Use carefully — not supported in all databases.
-----------------------------------------------------------------------------------
SELECT *
FROM Employees
NATURAL JOIN Departments;

-----------------------------------------------------------------------------------
-- 8. JOIN using USING clause
-- Definition: Simplifies join syntax by specifying column(s) with the same name.
-- Why use: Cleaner syntax when joining on columns that share the same name.
-----------------------------------------------------------------------------------
SELECT e.EmpID, e.EmpName, d.DeptName
FROM Employees e
JOIN Departments d USING (DeptID);

-----------------------------------------------------------------------------------
-- 9. SEMI JOIN (Simulated with EXISTS)
-- Definition: Returns rows from the left table where a matching row exists in the right table.
-- Why use: To check existence without bringing in columns from the right table.
-----------------------------------------------------------------------------------
SELECT e.EmpID, e.EmpName
FROM Employees e
WHERE EXISTS (
    SELECT 1 FROM Departments d WHERE d.DeptID = e.DeptID
);

-----------------------------------------------------------------------------------
-- 10. ANTI JOIN (Simulated with NOT EXISTS)
-- Definition: Returns rows from the left table where no matching row exists in the right table.
-- Why use: To find unmatched records in the left table.
-----------------------------------------------------------------------------------
SELECT e.EmpID, e.EmpName
FROM Employees e
WHERE NOT EXISTS (
    SELECT 1 FROM Departments d WHERE d.DeptID = e.DeptID
);
