CREATE TABLE Sales (
    Id INT,
    Product VARCHAR(50),
    Category VARCHAR(50),
    SalesPerson VARCHAR(50),
    Amount INT
);

drop table Sales

INSERT INTO Sales (Id, Product, Category, Amount) VALUES
(1, 'Laptop', 'Electronics', 1000),
(2, 'Phone', 'Electronics', 800),
(3, 'Shirt', 'Clothing', 50),
(4, 'Jeans', 'Clothing', 70),
(5, 'Tablet', 'Electronics', 600);


select * from Sales

---Total sales per category

SELECT CATEGORY,SUM(Amount) as TOTAL_SALES FROM SALES GROUP BY Category

---IT GROUPS ROWS WITH SAME VALUE ( E.G CATEGORY, DEPARTMENT)
---AGGREGATE FUNCTION 


SELECT CATEGORY,COUNT(*) AS TOTAL_ITEMS 
FROM SALES
GROUP BY CATEGORY

SELECT CATEGORY,avg(Amount) as TOTAL_SALES FROM SALES GROUP BY Category

1)EVERY COLUMN IN SELECT MUST BE:
 I)EITHER INSIDE AN AGGREGATE FUNCTION(SUM,COUNT,AVG...)
 II)OR INCLUDED IN GROUP BY


SELECT PRODUCT,CATEGORY,avg(Amount) as TOTAL_SALES FROM SALES GROUP BY Category

SELECT PRODUCT,CATEGORY,avg(Amount) as TOTAL_SALES FROM SALES GROUP BY Category,PRODUCT

select count(*) from sales where count(*)>5

INSERT INTO Sales (Id, Product, Category, SalesPerson, Amount) VALUES
(1, 'Laptop', 'Electronics', 'Alice', 1000),
(2, 'Phone', 'Electronics', 'Bob', 800),
(3, 'Tablet', 'Electronics', 'Alice', 600),
(4, 'Shirt', 'Clothing', 'Charlie', 50),
(5, 'Jeans', 'Clothing', 'Bob', 70),
(6, 'Jacket', 'Clothing', 'Alice', 120),
(7, 'Headphones', 'Electronics', 'Charlie', 200),
(8, 'Shoes', 'Clothing', 'Bob', 90),
(9, 'Watch', 'Accessories', 'Alice', 300),
(10, 'Belt', 'Accessories', 'Charlie', 40),
(11, 'Camera', 'Electronics', 'Bob', 900),
(12, 'Socks', 'Clothing', 'Alice', 30);


select * from Sales

1)find each persons avg sales amount
2)keep only those whith avg(amt)>500
3)calculate their commission


select 
salesPerson,
AVG(Amount) AS Avg_sales,
AVG(amount) * 0.05 AS Commision
from sales group by salesperson
having avg(amount) > 400


select salesperson,avg(amount) as average_sales,(0.05*avg(amount)) as commision  from sales
group by salesperson having avg(amount) > 400


select 
salesPerson,
AVG(Amount) AS Avg_sales,
CASE 
    WHEN AVG(AMOUNT) >400 THEN AVG(AMOUNT) * 0.2
    WHEN AVG(AMOUNT) >250 THEN AVG(AMOUNT) * 0.1
    ELSE 0
END AS COMMISION

FROM SALES
GROUP BY SALESPERSON

CREATE TABLE Sales_2024 (
    Id INT,
    Product VARCHAR(50),
    Amount INT
);

CREATE TABLE Sales_2025 (
    Id INT,
    Product VARCHAR(50),
    Amount INT
);

INSERT INTO Sales_2024 VALUES
(4, 'Phone', 800),
(5, 'Tablet', 600)

INSERT INTO Sales_2025 VALUES
(4, 'Phone', 800),
(5, 'Tablet', 600),
(6, 'Camera', 900);


SELECT * FROM Sales_2024
SELECT * FROM Sales_2025

SELECT * FROM Sales_2024
UNION
SELECT * FROM Sales_2025


SELECT * FROM Sales_2024
UNION ALL
SELECT * FROM Sales_2025

ORDER BY ID


