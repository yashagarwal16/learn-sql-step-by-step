-- ✅ Create a new database named 'college'
CREATE DATABASE college;

-- ✅ Select the 'college' database to work in
USE college;

-- ✅ Create the 'student' table with appropriate columns
CREATE TABLE student(
    rollno VARCHAR(10) PRIMARY KEY,  -- Unique student roll number
    name VARCHAR(50),                -- Student's full name
    marks INT NOT NULL,              -- Student's marks (cannot be NULL)
    grade VARCHAR(4),                -- Grade assigned based on marks (e.g., A, B+, etc.)
    city VARCHAR(20)                 -- Student's hometown or current city
);

-- ✅ Create a table for department (note: spelling as "depertment" kept as requested)
CREATE TABLE depertment(
    id INT PRIMARY KEY,              -- Unique department ID
    name_sub VARCHAR(50)             -- Name of the subject or department
);

-- ✅ Insert records into 'depertment' table
INSERT INTO depertment
VALUES
('101', 'eng'),
('102', 'hin');   -- Inserting English and Hindi as departments

-- ✅ View all departments
SELECT * FROM depertment;

-- ✅ Update department ID from 102 to 103
UPDATE depertment
SET id = 103
WHERE id = 102;

-- ✅ Create the 'teacher' table with a foreign key referencing department
CREATE TABLE teacher(
    id INT PRIMARY KEY,              -- Unique teacher ID
    name VARCHAR(50),                -- Teacher's name
    dept_id INT,                     -- Foreign key that refers to department ID
    FOREIGN KEY (dept_id) REFERENCES depertment(id)
    ON DELETE CASCADE                -- If department is deleted, delete associated teacher
    ON UPDATE CASCADE                -- If department ID is updated, auto-update teacher's dept_id
);

-- ✅ Insert teacher records
INSERT INTO teacher
VALUES
('101', 'Adam', 101),
('102', 'Shirkant', 103);  -- Linked with updated dept_id (103)

-- ✅ View all teacher records
SELECT * FROM teacher;

-- ✅ Insert multiple student records into the table
INSERT INTO student (rollno, name, marks, grade, city)
VALUES
("22EAIAD107", "Somya", 94, "A++", "Haryana"),
("22EAIAD110", "Surya", 98, "A+++", "Jaipur"),
("22EAIAD115", "Tarun", 75, "B+", "Jaipur"),
("22EAIAD122", "Vishesh", 81, "A", "Jaipur"),
("22EAIAD123", "Yaduvesh", 73, "B+", "KOTPUTLI"),
("22EAIAD124", "Yash", 90, "A+", "ASSAM"),
("22EAIAD125", "YASH", 87, "A", "JAIPUR");

-- ✅ Show student roll numbers and names only
SELECT rollno, name FROM student;

-- ✅ Display all student details
SELECT * FROM student;

-- ✅ Show all unique cities (no duplicates)
SELECT DISTINCT city FROM student;

-- ✅ List students with marks > 89
SELECT name FROM student WHERE marks > 89;

-- ✅ List students with marks > 80 and their marks
SELECT name, marks FROM student WHERE marks > 80;

-- ✅ List students from Jaipur who scored 87 or above
SELECT * FROM student 
WHERE city = "Jaipur" AND marks >= 87;

-- ✅ List students who are either from Jaipur or have marks >= 87
SELECT * FROM student 
WHERE city = "Jaipur" OR marks >= 87;

-- ✅ Students from Jaipur with grade A++, or any student with marks >= 87
SELECT * FROM student 
WHERE (city = "Jaipur" AND grade = "A++") OR marks >= 87;

-- ✅ Students scoring between 80 and 90
SELECT * FROM student 
WHERE marks BETWEEN 80 AND 90;

-- ✅ Students from specific cities
SELECT * FROM student 
WHERE city IN ("haryana", "kotputli", "delhi");

-- ✅ Students NOT from specific cities
SELECT * FROM student 
WHERE city NOT IN ("haryana", "Jaipur", "delhi");

-- ✅ Return only 2 students who scored more than 89 (any 2)
SELECT * FROM student 
WHERE marks > 89 
LIMIT 2;

-- ✅ Same as above, but sort by city (descending)
SELECT * FROM student 
WHERE marks > 89 
ORDER BY city DESC 
LIMIT 2;

-- ✅ Same as above, but sort by city (ascending)
SELECT * FROM student 
WHERE marks > 89 
ORDER BY city ASC 
LIMIT 2;

-- ✅ Find the highest marks scored
SELECT MAX(marks) FROM student;

-- ✅ Count total number of students
SELECT COUNT(rollno) FROM student;

-- ✅ Count how many students are from each city
SELECT city, COUNT(name) FROM student 
GROUP BY city;

-- ✅ Group by marks and name, and show highest marks in each group
SELECT marks, name, MAX(marks) 
FROM student 
GROUP BY marks, name;

-- ✅ Group by city and name, and filter groups where max marks > 89
SELECT city, name 
FROM student 
GROUP BY city, name 
HAVING MAX(marks) > 89;

-- ✅ Students who have grade A and scored more than 86 (grouped by city and name)
SELECT city, name
FROM student
WHERE grade = 'A'
GROUP BY city, name
HAVING MAX(marks) > 86;

-- ✅ Disable safe updates to allow bulk UPDATE/DELETE (MySQL-specific)
SET sql_safe_updates = 0;

-- ✅ Update grade: convert B+ to B
UPDATE student 
SET grade = "B" 
WHERE grade = "B+";

-- ✅ Increase all students' marks by 1
UPDATE student 
SET marks = marks + 1;

-- ✅ Check updated student data
SELECT * FROM student;

-- ✅ Delete records where marks are less than 33 (i.e., failed students)
DELETE FROM student 
WHERE marks < 33;

-- ✅ Enable safe updates again
SET sql_safe_updates = 1;

-- ✅ (This will fail now if safe mode is on)
DELETE FROM student 
WHERE marks < 33;

-- ✅ Add a new column 'age' with default value of 20
ALTER TABLE student 
ADD COLUMN age INT NOT NULL DEFAULT 20;

-- ✅ Change 'age' column data type to VARCHAR(2)
ALTER TABLE student 
MODIFY COLUMN age VARCHAR(2);

-- ✅ Insert new student records with age included
INSERT INTO student (rollno, name, marks, city, age, grade)
VALUES
("22EAIAD111", "kamran", 83, "jaipur", "21", "A"),
("22EAIAD119", "xyz", 60, "Jaipur", "22", "B+");

-- ✅ Show all current student records
SELECT * FROM student;

-- ✅ Remove the 'age' column
ALTER TABLE student 
DROP COLUMN age;

-- ✅ Verify column removed
SELECT * FROM student;

-- ✅ Clear all student records but keep the structure
TRUNCATE TABLE student;


-- ✅ INNER JOIN between 'teacher' and 'depertment'
-- Shows teachers with matching department information
SELECT t.id AS teacher_id, t.name AS teacher_name, d.name_sub AS subject
FROM teacher AS t
INNER JOIN depertment AS d
ON t.dept_id = d.id;

-- ✅ LEFT JOIN between 'teacher' and 'depertment'
-- Shows all teachers, even if they don't have a matching department
SELECT t.id AS teacher_id, t.name AS teacher_name, d.name_sub AS subject
FROM teacher AS t
LEFT JOIN depertment AS d
ON t.dept_id = d.id;

-- ✅ RIGHT JOIN between 'teacher' and 'depertment'
-- Shows all departments, even those without any teacher assigned
SELECT t.id AS teacher_id, t.name AS teacher_name, d.name_sub AS subject
FROM teacher AS t
RIGHT JOIN depertment AS d
ON t.dept_id = d.id;

-- ✅ FULL OUTER JOIN (simulated using UNION of LEFT and RIGHT JOINs)
-- Shows all teacher-department combinations including unmatched rows on both sides
SELECT t.id AS teacher_id, t.name AS teacher_name, d.name_sub AS subject
FROM teacher AS t
LEFT JOIN depertment AS d
ON t.dept_id = d.id

UNION

SELECT t.id AS teacher_id, t.name AS teacher_name, d.name_sub AS subject
FROM teacher AS t
RIGHT JOIN depertment AS d
ON t.dept_id = d.id;

-- ✅ LEFT EXCLUSIVE JOIN (teachers without departments)
-- Shows only teachers who do NOT belong to any department
SELECT t.id AS teacher_id, t.name AS teacher_name
FROM teacher AS t
LEFT JOIN depertment AS d
ON t.dept_id = d.id
WHERE d.id IS NULL;

-- ✅ RIGHT EXCLUSIVE JOIN (departments without teachers)
-- Shows only departments that do NOT have any teachers assigned
SELECT d.id AS dept_id, d.name_sub AS subject
FROM teacher AS t
RIGHT JOIN depertment AS d
ON t.dept_id = d.id
WHERE t.id IS NULL;
