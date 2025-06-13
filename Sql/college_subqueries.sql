-- -------------------------------------------------
-- 🎓 Step 1: Create and Use College Database
-- -------------------------------------------------
CREATE DATABASE IF NOT EXISTS colleges;
USE colleges;

-- -------------------------------------------------
-- 🧱 Step 2: Create Tables
-- -------------------------------------------------

-- Students Table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    department_id INT
);

-- Departments Table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- Courses Table
CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    department_id INT
);

-- Enrollments Table (Which student enrolled in which course)
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT
);

-- Results Table
CREATE TABLE results (
    result_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    marks INT
);

-- -------------------------------------------------
-- 📥 Step 3: Insert Sample Data
-- -------------------------------------------------

-- Departments
INSERT INTO departments VALUES 
(1, 'Computer Science'),
(2, 'Mechanical'),
(3, 'Electrical');

-- Students
INSERT INTO students VALUES 
(101, 'Ravi', 20, 1),
(102, 'Neha', 21, 1),
(103, 'Ankit', 22, 2),
(104, 'Priya', 20, 3),
(105, 'Arjun', 23, 1);

-- Courses
INSERT INTO courses VALUES 
(201, 'Data Structures', 1),
(202, 'Thermodynamics', 2),
(203, 'Circuits', 3),
(204, 'Algorithms', 1),
(205, 'Machine Design', 2);

-- Enrollments
INSERT INTO enrollments VALUES 
(1, 101, 201),
(2, 101, 204),
(3, 102, 201),
(4, 103, 202),
(5, 104, 203),
(6, 105, 201),
(7, 105, 204);

-- Results
INSERT INTO results VALUES 
(1, 101, 201, 85),
(2, 101, 204, 92),
(3, 102, 201, 75),
(4, 103, 202, 60),
(5, 104, 203, 90),
(6, 105, 201, 88),
(7, 105, 204, 80);

-- -------------------------------------------------
-- 🔍 Step 4: Subqueries with Explanation
-- -------------------------------------------------

-- 1️⃣ Students who scored above the average marks in 'Data Structures'
SELECT name, marks
FROM students
JOIN results ON students.student_id = results.student_id
WHERE course_id = 201
  AND marks > (
    SELECT AVG(marks)
    FROM results
    WHERE course_id = 201
);

-- 2️⃣ Departments that have more than 2 students
SELECT department_name
FROM departments
WHERE (
    SELECT COUNT(*) FROM students
    WHERE students.department_id = departments.department_id
) > 2;

-- 3️⃣ Students in the same department as 'Ravi'
SELECT name
FROM students
WHERE department_id = (
    SELECT department_id FROM students WHERE name = 'Ravi'
);

-- 4️⃣ Courses that no student has enrolled in
SELECT course_name
FROM courses
WHERE course_id NOT IN (
    SELECT course_id FROM enrollments
);

-- 5️⃣ Students who scored more than 80 in any subject
SELECT DISTINCT name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM results
    WHERE marks > 80
);

