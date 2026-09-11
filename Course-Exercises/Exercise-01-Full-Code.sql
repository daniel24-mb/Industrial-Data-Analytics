/*
Exercise 01 - SQL Foundations
Topics:
SELECT, DISTINCT, ORDER BY, LIMIT,
WHERE, AND, OR, NOT, IN
Environment: Databricks SQL
*/


/*
Q1: Retrieve all columns from the employees table
*/

SELECT *
FROM employees;


/*
Q2: Find all unique departments
*/

SELECT DISTINCT department
FROM employees;


/*
Q3: Retrieve first and last names ordered by salary descending
*/

SELECT first_name, last_name
FROM employees
ORDER BY salary DESC;


/*
Q4: Retrieve the top 3 highest-paid employees
*/

SELECT id, first_name, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 3;


/*
Q5: Find employees in the IT department
*/

SELECT id, first_name, last_name, department
FROM employees
WHERE department = 'IT';


/*
Q6: Find employees in Finance with salary > 60000
*/

SELECT id, first_name, last_name, department, salary
FROM employees
WHERE department = 'Finance'
AND salary > 60000;


/*
Q7: Find employees in HR or Marketing
*/

SELECT id, first_name, last_name, department
FROM employees
WHERE department = 'HR'
OR department = 'Marketing';


/*
Q8: Find employees not in IT
*/

SELECT id, first_name, last_name, department
FROM employees
WHERE NOT department = 'IT';


/*
Q9: Find employees in IT, HR, or Finance using IN
*/

SELECT id, first_name, last_name, department
FROM employees
WHERE department IN ('IT', 'HR', 'Finance');


/*
Q10: Find employees in IT with salary > 65000
and city Johannesburg
*/

SELECT id, first_name, last_name, department, salary, city
FROM employees
WHERE department = 'IT'
AND salary > 65000
AND city = 'Johannesburg';
