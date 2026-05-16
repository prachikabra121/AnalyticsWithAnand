CREATE TABLE departments (
    department_id INT,
    department_name varchar(50)
);

CREATE  TABLE employees (
    employee_id INT,
    employee_name varchar(40),
    department_id INT,
    salary INT
);

drop table departments

INSERT INTO departments VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing');

INSERT INTO employees VALUES
(101, 'Anand', 1, 50000),
(102, 'Rahul', 2, 70000),
(103, 'Priya', 2, 65000),
(104, 'Sneha', 5, 45000),
(105, 'Amit', NULL, 40000);

select * from departments
select * from employees


--- Show only employees whose department exists in the company

SELECT E.employee_id,E.employee_name,D.department_id,D.department_name  FROM employees E 
INNER JOIN departments D
ON E.department_id = D.department_id


---SHOW ALL EMPLOYEES EVEN IF DEPARTMENT INFO IS MISSING
select * from departments
select * from employees
SELECT * FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.department_id = D.department_id 
SELECT * FROM DEPARTMENTS E LEFT JOIN  EMPLOYEES D ON E.department_id = D.department_id



CREATE TABLE customers (
    customer_id INT,
    customer_name VARCHAR(60)
);

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_amount INT
);

CREATE TABLE payments (
    payment_id INT,
    order_id INT,
    payment_status VARCHAR(50)
);

INSERT INTO customers VALUES
(1, 'Anand'),
(2, 'Rahul'),
(3, 'Priya'),
(4, 'Sneha');

INSERT INTO orders VALUES
(101, 1, 5000),
(102, 1, 7000),
(103, 2, 3000),
(104, 5, 9000);


INSERT INTO payments VALUES
(1001, 101, 'Completed'),
(1002, 102, 'Pending');


SELECT * FROM customers
SELECT * FROM orders
SELECT * FROM payments


SELECT * FROM CUSTOMERS C LEFT JOIN ORDERS O ON C.customer_id=O.customer_id LEFT JOIN payments P ON P.order_id = O.order_id


SELECT * FROM EMPLOYEES E FULL JOIN DEPARTMENTS D ON E.department_id = D.department_id 

SELECT E.employee_name,D.department_name FROM EMPLOYEES E CROSS JOIN DEPARTMENTS D

DROP TABLE sizes
CREATE TABLE colors (
    color VARCHAR(30)
);

CREATE TABLE sizes (
    size VARCHAR(4))

INSERT INTO colors VALUES
('Red'),
('Blue'),
('Black');

INSERT INTO sizes VALUES
('S'),
('M'),
('L');

SELECT * FROM COLORS C CROSS JOIN SIZES S

SELECT *
FROM employees e, departments d;


SELECT E.employee_name AS EMPLOYEE,M.employee_name AS MANAGER  FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.department_id = D.department_id 


DROP TABLE EMPLOYEES

CREATE TABLE employee_manager (
    employee_id INT,
    employee_name VARCHAR(50),
    manager_id INT
);
INSERT INTO employee_manager VALUES
(1, 'Anand', NULL),
(2, 'Rahul', 1),
(3, 'Priya', 1),
(4, 'Sneha', 2),
(5, 'Amit', 2),
(6, 'Neha', 3);

SELECT * FROM employee_manager

SELECT E.employee_name AS EMPLOYEE,M.employee_name AS MANAGER FROM EMPLOYEE_MANAGER E  left JOIN EMPLOYEE_MANAGER M ON e.employee_id=m.manager_id

SELECT * FROM employee_manager
SELECT 
    e.employee_id,
    e.manager_id,
    e.employee_name AS employee,
    m.employee_name AS manager
FROM employee_manager e
LEFT JOIN employee_manager m
ON e.manager_id = m.employee_id;