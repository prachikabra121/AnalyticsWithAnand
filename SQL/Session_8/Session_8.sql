---What is DECLARE in SQL Server?
Declare is used to craete a variable in sql server - a temporary container that hold avalue while your code is running

let x = 5

Declare @age int = 25

Declare @age int;
SET @age=25


SELECT *
FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees);


SELECT *,
    salary - (SELECT AVG(salary) FROM Employees) AS diff_from_avg,
    CASE
        WHEN salary > (SELECT AVG(salary) FROM Employees) THEN 'Above Average'
        WHEN salary < (SELECT AVG(salary) FROM Employees) THEN 'Below Average'
        ELSE 'Average'
    END AS category
FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees);

DECLARE @avg_salary DECIMAL(10,2);
SET @avg_salary = (SELECT AVG(salary) FROM Employees);

SELECT *,
    salary - @avg_salary AS diff_from_avg,
    CASE
        WHEN salary > @avg_salary THEN 'Above Average'
        WHEN salary < @avg_salary THEN 'Below Average'
        ELSE 'Average'
    END AS category
FROM Employees
WHERE salary > @avg_salary;


DECLARE @NAME NVARCHAR(30)
SET @NAME = N'Prachi'

--SELECT LEN(@NAME)
--SELECT DATALENGTH(@NAME)

SELECT UPPER(@NAME)
SELECT LOWER(@NAME)


DECLARE @NAME VARCHAR(30)
SET @NAME = '   Prachi  '

SELECT DATALENGTH(@NAME)
SELECT LTRIM(@NAME)
SELECT RTRIM(@NAME)
SELECT TRIM(@NAME)

DECLARE @NAME VARCHAR(30)
SET @NAME = '000Prachi'

SELECT @NAME
SELECT TRIM('0' FROM @NAME)



INSERT INTO Customers (name, email)
VALUES (TRIM(@name), LOWER(TRIM(@email)));

SPACE(N)


DECLARE @NAME VARCHAR(30)
SET @NAME = '000Prachi'
SELECT 'NAME:' + SPACE(3) + TRIM('0' FROM @NAME)

SELECT REPLICATE('*',8)


DECLARE @NAME VARCHAR(30)
SET @NAME = 'PrachiKABRA'

SELECT CHARINDEX('KABRA',@NAME)

SELECT CHARINDEX('RASHI',@NAME)


DECLARE @FILE VARCHAR(MAX) = 'C:\Users\prach\Downloads\data_.csv'

SELECT RIGHT(@FILE,LEN(@FILE) - CHARINDEX('.',@FILE))

SELECT PATINDEX('%[0-9]%', 'INVOICE INV-00123')

-- Find all emails from gmail

SELECT SUBSTRING('PRACHI@GMAIL.COM',1,6)
SELECT SUBSTRING('PRACHI@GMAIL.COM',8,5)

DECLARE @NAME VARCHAR(100) = 'JOHN MICHEL SMITH';
DECLARE @FIRST_SPACE INT =CHARINDEX(' ',@NAME);
DECLARE @SECOND_SPACE INT = CHARINDEX(' ',@NAME,@FIRST_SPACE + 1);


select @FIRST_SPACE

SELECT @SECOND_SPACE
SELECT SUBSTRING(@NAME,@FIRST_SPACE + 1, @SECOND_SPACE - @FIRST_SPACE-1);

SELECT LEFT(@NAME,4)
SELECT RIGHT(@NAME,5)

DECLARE @NAME VARCHAR(50) = 'TODAY IS A BEAUTIFUL DAY BECAUSE IT IS SUNDAY'

SELECT REPLACE(@NAME,'DAY','BAY')


SELECT STUFF(@NAME,1,2,'YESTER')

SELECT REVERSE(@NAME)


DECLARE @W VARCHAR(50) ='MADAM'
SELECT 
     CASE 
         WHEN @W = REVERSE(@W) THEN 'YES'
         ELSE 'NO'
     END
             

SELECT 'HELLO' + 'WORLD'
SELECT 'HELLO' + NULL + 'WORLD'

SELECT CONCAT('HELLO',NULL,'WORLD')

SELECT CONCAT_WS(', ','MUMBAI','BANGLORE','PUNE',NULL,'AHEMDABAD')

SELECT STR(3.14159,7,2)
 SELECT FORMAT(1234567.37,'N3')

 SELECT CAST(42 AS VARCHAR(10))

 SELECT CAST(3.99 AS INT)

 SELECT CONVERT(VARCHAR,GETDATE(),120)

 SELECT CAST('ABC' AS INT)

 SELECT TRY_CAST('ABC' AS INT)


DECLARE @tags VARCHAR(200) = 'SQL,Python,Excel,Power BI';
SELECT value AS tag FROM STRING_SPLIT(@tags, ',');
SELECT value AS tag FROM STRING_AGG(@tags, ',');