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
Q3: Display first name, last name, and salary,
ordered from highest salary to lowest
*/

SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC;


/*
Q4: Show the top 3 highest-paid employees
*/

SELECT employee_id, first_name, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 3;


/*
Q5: Find employees who work in the IT department
*/

SELECT *
FROM employees
WHERE department = 'IT';


/*
Q6: Find employees in Finance
with a salary greater than 60000
*/

SELECT *
FROM employees
WHERE department = 'Finance'
  AND salary > 60000;


/*
Q7: Find employees who work in HR or Marketing
*/

SELECT *
FROM employees
WHERE department = 'HR'
   OR department = 'Marketing';


/*
Q8: Find employees who do not work in IT
*/

SELECT *
FROM employees
WHERE NOT department = 'IT';


/*
Q9: Find employees who work in
IT, HR, or Finance
*/

SELECT *
FROM employees
WHERE department IN ('IT', 'HR', 'Finance');


/*
Q10: Find employees who work in IT,
earn more than 65000,
and are based in Johannesburg
*/

SELECT *
FROM employees
WHERE department = 'IT'
  AND salary > 65000
  AND city = 'Johannesburg';
