--  CREATE DATABASE
CREATE DATABASE CollegeDB;
USE CollegeDB;

--  CREATE TABLES

-- 👨‍🎓 Students table
CREATE TABLE Students (
    roll_no VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    course VARCHAR(50)
);

-- 👩‍🏫 Faculty table
CREATE TABLE Faculty (
    faculty_id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50)
);

-- 📚 Subjects table
CREATE TABLE Subjects (
    subject_id VARCHAR(10) PRIMARY KEY,
    subject_name VARCHAR(50),
    faculty_id VARCHAR(10),
    FOREIGN KEY (faculty_id) REFERENCES Faculty(faculty_id)
);

-- 📝 Marks table
CREATE TABLE Marks (
    roll_no VARCHAR(10),
    subject_id VARCHAR(10),
    marks INT,
    FOREIGN KEY (roll_no) REFERENCES Students(roll_no),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

--  INSERT SAMPLE DATA

INSERT INTO Students VALUES 
('S001', 'Anuj', 17, 'Science'),
('S002', 'Priya', 16, 'Commerce'),
('S003', 'Amit', 17, 'Science'),
('S004', 'Simran', 16, 'Arts');

INSERT INTO Faculty VALUES 
('F01', 'Dr. Verma', 'Science'),
('F02', 'Ms. Kaur', 'Commerce'),
('F03', 'Mr. Sharma', 'Arts');

INSERT INTO Subjects VALUES 
('Sub01', 'Physics', 'F01'),
('Sub02', 'Accounts', 'F02'),
('Sub03', 'History', 'F03');

INSERT INTO Marks VALUES 
('S001', 'Sub01', 95),
('S002', 'Sub02', 88),
('S003', 'Sub01', 92),
('S004', 'Sub03', 85);

--  SELECT / BASIC QUERIES

SELECT * FROM Students;
SELECT * FROM Faculty;
SELECT * FROM Subjects;
SELECT * FROM Marks;

--  JOIN EXAMPLES

--  INNER JOIN: Get student name and their subject marks
SELECT s.name, sub.subject_name, m.marks
FROM Students s
JOIN Marks m ON s.roll_no = m.roll_no
JOIN Subjects sub ON m.subject_id = sub.subject_id;

--  SUBQUERY EXAMPLES

-- Get names of students who scored more than average marks
SELECT name FROM Students
WHERE roll_no IN (
    SELECT roll_no FROM Marks
    WHERE marks > (SELECT AVG(marks) FROM Marks)
);

-- 🎯  FUNCTIONS

--  Find max, min, avg marks
SELECT MAX(marks), MIN(marks), AVG(marks) FROM Marks;

--  GROUP BY

--  Average marks by subject
SELECT subject_id, AVG(marks) FROM Marks GROUP BY subject_id;

--  CTE (Common Table Expression)

WITH HighScorers AS (
    SELECT roll_no, marks FROM Marks WHERE marks > 90
)
SELECT s.name, h.marks FROM Students s
JOIN HighScorers h ON s.roll_no = h.roll_no;

--  VIEW

CREATE VIEW ScienceStudents AS
SELECT * FROM Students WHERE course = 'Science';

SELECT * FROM ScienceStudents;


CREATE VIEW view1 AS
SELECT name , age FROM Students;

SELECT * FROM view1;


--  TRANSACTIONS

START TRANSACTION;
UPDATE Marks SET marks = marks - 5 WHERE roll_no = 'S002';
-- If mistake
ROLLBACK;
-- If correct
-- COMMIT;

--  WINDOW FUNCTIONS

SELECT name, marks,
    RANK() OVER (ORDER BY marks DESC) AS rank_position
FROM Students
JOIN Marks ON Students.roll_no = Marks.roll_no;
