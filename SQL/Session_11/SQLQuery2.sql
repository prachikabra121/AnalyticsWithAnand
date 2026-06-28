SELECT * FROM [dbo].[Customer]

insert into [dbo].[Customer] values(3,'Raj','Khanna','rajk@gmail.com','8978975678','sp ring road','ahemdabad','gujarat',380015)

CREATE VIEW VW_CUSTOMERS as
SELECT CUSTOMERID,FIRSTNAME,LASTNAME,CITY,STATE FROM [dbo].[Customer];

SELECT * FROM VW_CUSTOMERS



CREATE OR ALTER VIEW VW_CUSTOMERS as
SELECT CUSTOMERID,FIRSTNAME,LASTNAME,CITY,STATE,ZipCode,CreatedAt FROM [dbo].[Customer];

EXEC sp_refreshview 'VW_CUSTOMERS'

#Find duplicute Records in Table
select c1,c2, count(*) from table group by c1,c2 having count(*)>1


-- CREATE TABLE

CREATE TABLE EMP
(
    EMP_ID INT,
    NAME VARCHAR(100),
    EMAIL VARCHAR(100)
);

-- INSERT RECORDS

INSERT INTO EMP (EMP_ID, NAME, EMAIL)
VALUES
(1, 'Anand', 'a@gmail.com'),
(2, 'Rahul', 'r@gmail.com'),
(3, 'Anand', 'a@gmail.com'),
(4, 'Amit', 'amit@gmail.com'),
(5, 'Rahul', 'r@gmail.com'),
(6, 'Sneha', 'sneha@gmail.com'),
(7, 'Anand', 'a@gmail.com'),
(8, 'Rahul', 'r@gmail.com'),
(9, 'Sneha', 'sneha@gmail.com'),
(10, 'Anand', 'a@gmail.com');

select * from EMP

--Find duplicute Records in Table
select NAME,EMAIL, count(*) from emp group by NAME,EMAIL having count(*)>1

select * , RANK() over (partition by email order by emp_id) AS RN from emp 


2. Retrieve Second highest salary Foom the exmployee tablen

SELECT * FROM [dbo].[employees]

WITH SEC_HIHEST_SAL as (
SELECT * , DENSE_RANK() OVER (ORDER BY SALARY DESC) as rnk FROM [dbo].[employees]
)
SELECT * FROM SEC_HIHEST_SAL WHERE RNK = 2

SELECT  TOP 1 SALARY FROM (SELECT DISTINCT TOP 2 SALARY FROM [dbo].[employees] ORDER BY SALARY DESC) AS t ORDER BY SALARY

SELECT MAX(SALARY) AS SECOND_HIHEST_SAL FROM [dbo].[employees] WHERE SALARY < (SELECT MAX(SALARY) FROM [dbo].[employees])


Find employee without department (uber)

CREATE TABLE EMPLOYEE
(
    EMP_ID INT,
    EMP_NAME VARCHAR(100),
    DEPT_ID INT
);

CREATE TABLE DEPARTMENT
(
    DEPT_ID INT,
    DEPT_NAME VARCHAR(100)
);

INSERT INTO EMPLOYEE VALUES
(1, 'Anand', 101),
(2, 'Rahul', 102),
(3, 'Sneha', NULL),
(4, 'Amit', 105),
(5, 'Priya', 103);

INSERT INTO DEPARTMENT VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance');

SELECT * FROM EMPLOYEE
SELECT * FROM DEPARTMENT

SELECT * FROM EMPLOYEE E LEFT JOIN DEPARTMENT D ON E.DEPT_ID=D.DEPT_ID WHERE D.DEPT_ID IS NULL

SELECT *  FROM EMPLOYEE E  WHERE NOT EXISTS ( SELECT 1 FROM DEPARTMENT D WHERE E.DEPT_ID = D.DEPT_ID)

SELECT *  FROM EMPLOYEE WHERE DEPT_ID NOT IN (SELECT DEPT_ID FROM DEPARTMENT ) OR DEPT_ID IS NULL



calculate total Revenue pER PRODUCT


select Product_id, Product_name, sum(sales) as total_revenue from products group by Product_id, 


SELECT PRODUCT_ID, (

CREATE TABLE SALES
(
    ORDER_ID INT,
    PRODUCT_NAME VARCHAR(100),
    QUANTITY INT,
    PRICE DECIMAL(10,2)
);

INSERT INTO SALES VALUES
(1, 'Laptop', 2, 50000),
(2, 'Mobile', 3, 20000),
(3, 'Laptop', 1, 50000),
(4, 'Headphone', 5, 2000),
(5, 'Mobile', 2, 20000);
SELECT * FROM SALES

SELECT PRODUCT_NAME,SUM(QUANTITY*PRICE) as TOTAL_REVENUE FROM SALES GROUP BY PRODUCT_NAME

