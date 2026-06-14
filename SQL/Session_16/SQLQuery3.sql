CREATE TABLE StudentRaw
(
StudentID VARCHAR(10),
StudentName VARCHAR(100),
Email VARCHAR(100),
PhoneNumbers VARCHAR(MAX),
CourseID VARCHAR(10),
CourseName VARCHAR(100),
ProfessorID VARCHAR(10),
ProfessorName VARCHAR(100),
ProfessorRoom VARCHAR(20),
Hobbies VARCHAR(MAX),
Languages VARCHAR(MAX),
ZipCode VARCHAR(10),
City VARCHAR(100),
State VARCHAR(100),
Grade CHAR(1)
);

BULK INSERT StudentRaw
FROM 'C:\Users\prach\Downloads\student_raw_data.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
);

select * from StudentRaw

---how many duplicate students are there?
SELECT STUDENTID,COUNT(*) FROM StudentRaw GROUP BY STUDENTID

---how many duplicate PROFESSORS are there?

SELECT ProfessorID,COUNT(*) FROM StudentRaw GROUP BY ProfessorID

---how many duplicate COURSES are there?
SELECT CourseID,COUNT(*) FROM StudentRaw GROUP BY CourseID

CREATE TABLE StudentPhone
(
StudentID VARCHAR(10),
PhoneNumber VARCHAR(20)
);

INSERT INTO StudentPhone
SELECT
STUDENTID,
LTRIM(RTRIM(value))
FROM StudentRaw
CROSS APPLY STRING_SPLIT(PhoneNumbers,'|') as PhoneNumbers


SELECT * FROM StudentPhone
UPDATE StudentPhone
SET PhoneNumber=REPLACE(PHONENUMBER,'"','')

CREATE TABLE StudentHOBBIES
(
StudentID VARCHAR(10),
HOBBY VARCHAR(20)
);

INSERT INTO StudentHOBBIES
SELECT
STUDENTID,
LTRIM(RTRIM(value))
FROM StudentRaw
CROSS APPLY STRING_SPLIT(HOBBIES,'|') as HOBBY

SELECT * FROM StudentHOBBIES

SELECT * FROM StudentHOBBIES
UPDATE StudentHOBBIES
SET HOBBY=REPLACE(HOBBY,'"','')


CREATE TABLE StudentLANGUAGES
(
StudentID VARCHAR(10),
LANGUAGE VARCHAR(20)
);

INSERT INTO StudentLANGUAGES
SELECT
STUDENTID,
LTRIM(RTRIM(value))
FROM StudentRaw
CROSS APPLY STRING_SPLIT(Languages,'|') as Language

SELECT * FROM StudentLANGUAGES

UPDATE StudentLANGUAGES
SET Language=REPLACE(Language,'"','')

SELECT DISTINCT
StudentID,
StudentName,
Email,
ZipCode
INTO Student
FROM StudentRaw;

select * from StudentRaw
SELECT * FROM Student
SELECT * FROM Professor
SELECT *  FROM Course
SELECT * FROM Enrollment
SELECT * FROM Location
SELECT * FROM Student

SELECT * FROM StudentPhone
SELECT
    StudentID,
    PhoneNumber,
    COUNT(*) AS cnt
FROM StudentPhone
GROUP BY StudentID, PhoneNumber
HAVING COUNT(*) > 1;

WITH DuplicatePhones AS (
SELECT*, ROW_NUMBER() OVER (
    PARTITION BY StudentID, PhoneNumber ORDER BY STUDENTID
)AS RNK FROM StudentPhone
)
DELETE FROM DuplicatePhones WHERE RNK > 1


SELECT DISTINCT
ProfessorID,
ProfessorName,
ProfessorRoom
INTO Professor
FROM StudentRaw;

SELECT DISTINCT
CourseID,
CourseName,
ProfessorID
INTO Course
FROM StudentRaw;


SELECT
StudentID,
CourseID,
Grade
INTO Enrollment
FROM StudentRaw;


----3nf
SELECT DISTINCT
ZipCode,
City,
State
INTO Location
FROM StudentRaw;


SELECT S.StudentName,C.CourseName,P.ProfessorName,E.Grade FROM Enrollment E INNER JOIN Student S ON E.StudentID=S.StudentID
INNER JOIN Course C ON E.CourseID=C.CourseID
INNER JOIN Professor P ON C.ProfessorID=P.ProfessorID

---TOTAL STUDENTS
SELECT COUNT(*) AS TotalStudents FROM Student

-- STUDENTS BY CITY
SELECT
l.City,
COUNT(*) AS StudentCount
FROM Student s
JOIN Location l
ON s.ZipCode=l.ZipCode
GROUP BY l.City
ORDER BY StudentCount DESC;

--STUDENT BY STATE

SELECT
l.STATE,
COUNT(*) AS StudentCount
FROM Student s
JOIN Location l
ON s.ZipCode=l.ZipCode
GROUP BY l.STATE
ORDER BY StudentCount DESC;

----Students with Multiple Phone Numbers
SELECT STUDENTID,
COUNT(*) AS PhoneCount
FROM StudentPhone
GROUP BY STUDENTID
HAVING COUNT(*) > 1

SELECT S.STUDENTID, S.StudentName, COUNT(P.PhoneNumber) AS PhoneCount FROM Student S INNER JOIN StudentPhone P ON S.StudentID=P.StudentID GROUP BY S.STUDENTID, S.StudentName HAVING COUNT(P.PhoneNumber) > 1

---TOTAL COURSES
Select count(*) AS TOTALCOURSES from course 


---Enrollment per Course
SELECT C.CourseName,COUNT(*) AS TOTAL_ENROLLMENTS FROM Enrollment E
INNER JOIN COURSE C ON E.CourseID=C.CourseID GROUP BY C.CourseName ORDER BY TOTAL_ENROLLMENTS DESC






