
--DDL-Data Difination Language
--Creating a new database

CREATE DATABASE ANALYTICS_WITH_ANAND_DB;

--CREATE A NEW SCHEMA
CREATE SCHEMA sales;

--CREATE TABLE

USE ANALYTICS_WITH_ANAND_DB;

CREATE TABLE sales.employee
(
id int,
Name varchar(40)
)

---ALTER 
ALTER TABLE sales.employee
ADD salary int

ALTER TABLE sales.employee
ALTER COLUMN Name VARCHAR(30)


ALTER TABLE sales.employee
DROP COLUMN salary


ALTER TABLE sales.employee  ----Snowflake or oracle
Rename Column Name to emp_Name

---DROP
DROP TABLE sales.employee

SELECT * FROM sales.employee

insert into sales.employee values(1,'Kevin',70000),(2,'Ashish',80000),(3,'Supriya',56878989)

TRUNCATE table sales.employee


--DQL- Data Query Language

Select * from sales.employee  --* - select all

select Name from sales.employee
select Name,salary from sales.employee

---Insert into

insert into sales.employee values(1,'Kevin',70000),(2,'Ashish',80000),(3,'Supriya',56878989)


insert into sales.employee(id,Name) values(4,'Shikha')

insert into sales.employee values(5,'Sakshi',80098)

--Update
UPDATE sales.employee
set salary = 678899
where id= 4 

UPDATE sales.employee
set salary = 678899



---delete
DELETE FROM sales.employee where id = 2

DELETE FROM sales.employee


-- tcl - tRANSACTION CONTROL LANGUAGE

begin transaction;

UPDATE sales.employee
set salary = 678899

ROLLBACK

begin transaction;

UPDATE sales.employee
set salary = 678899

COMMIT

ROLLBACK

begin transaction;

DELETE FROM sales.employee 

commit

select 10.0/3


Create table payments(
amount DECIMAL(14,4)
)

insert into payments values(100.25)

select * from payments

insert into payments values(9999999999.899989899999)

ALTER TABLE payments 
ALTER COLUMN amount DECIMAL(15,7);


drop table payments


Create table payments1(
amount float
)

insert into payments1 values(9999999999.899989899999)

insert into payments1 values(100.25)
select * from payments1


Create table orders(
order_date Date,
order_time Time,
Created_at Datetime2
)

Insert into orders values('2026-08-04','14:30:56','2026-08-04 14:30:56')

select * from orders

---Insert into orders values(2026-08-04,'14:30:56','2026-08-04 14:30:56')

---Datetimeoffset

SELECT DATEPART(TZOFFSET,SYSDATETIMEOFFSET()) as timezoneoffset

create table users(
country_code char(2),
name varchar(50)
)

insert into users values('IN','India'),('US','USA')
select * from users

insert into users values('th',N'नमस्ते')

dROP TABLE users

create table users(
country_code char(2),
name varchar(max)
)



CREATE TABLE CUSTOMERS(
name Nvarchar(100))

INSERT INTO CUSTOMERS VALUES (N'😊');

select * from CUSTOMERS


CREATE TABLE documents (
    file_data VARBINARY(MAX)
);

INSERT INTO documents VALUES (0x48656C6C6F);

select * from documents

INSERT INTO documents
VALUES (CAST('Hello World' AS VARBINARY(MAX)));

select 10 +'20'

select 'abc'+30

select 10+20.0