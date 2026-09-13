/*
Exercise 03 - SQL CASE Statements
Environment: Databricks SQL
*/


/* =========================================================
   TABLE 1: products
   ========================================================= */

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id INT,
    product_name STRING,
    price DECIMAL(10,2)
);

INSERT INTO products VALUES
(1, 'Laptop', 1200.00),
(2, 'Phone', 800.00),
(3, 'Keyboard', 45.00),
(4, 'Monitor', 300.00),
(5, 'Mouse', 25.00);


/* Q1 */

SELECT
    product_name,
    price,
    CASE
        WHEN price > 1000 THEN 'Expensive'
        WHEN price BETWEEN 100 AND 1000 THEN 'Mid-range'
        WHEN price < 100 THEN 'Budget'
    END AS price_category
FROM products;


/* =========================================================
   TABLE 2: orders
   ========================================================= */

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id INT,
    customer_name STRING,
    amount DECIMAL(10,2)
);

INSERT INTO orders VALUES
(1, 'Alice', 150.00),
(2, 'Bob', 560.00),
(3, 'Charlie', 999.99),
(4, 'Diana', 45.50),
(5, 'Ethan', 1200.00);


/* Q2 */

SELECT
    customer_name,
    amount,
    CASE
        WHEN amount >= 1000 THEN 'High Value'
        WHEN amount BETWEEN 500 AND 999.99 THEN 'Medium Value'
        WHEN amount < 500 THEN 'Low Value'
    END AS order_value_category
FROM orders;


/* =========================================================
   TABLE 3: employees
   ========================================================= */

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    emp_id INT,
    emp_name STRING,
    department STRING,
    salary INT
);

INSERT INTO employees VALUES
(1, 'John', 'IT', 85000),
(2, 'Sara', 'HR', 60000),
(3, 'Mark', 'IT', 75000),
(4, 'Lucy', 'Finance', 95000),
(5, 'Tom', 'HR', 55000);


/* Q3 */

SELECT
    emp_name,
    department,
    salary,
    CASE
        WHEN department = 'IT'
             AND salary > 80000 THEN 'Senior IT'
        WHEN department = 'HR'
             AND salary > 55000 THEN 'Experienced HR'
        ELSE 'Staff'
    END AS position_level
FROM employees;


/* =========================================================
   TABLE 4: students
   ========================================================= */

DROP TABLE IF EXISTS students;

CREATE TABLE students (
    student_id INT,
    student_name STRING,
    score INT
);

INSERT INTO students VALUES
(1, 'Anna', 92),
(2, 'Ben', 76),
(3, 'Cara', 59),
(4, 'David', 83),
(5, 'Ella', 68);


/* Q4 */

SELECT
    student_name,
    score,
    CASE
        WHEN score >= 90 THEN 'A'
        WHEN score BETWEEN 80 AND 89 THEN 'B'
        WHEN score BETWEEN 70 AND 79 THEN 'C'
        WHEN score BETWEEN 60 AND 69 THEN 'D'
        ELSE 'F'
    END AS grade
FROM students;


/* =========================================================
   TABLE 5: deliveries
   ========================================================= */

DROP TABLE IF EXISTS deliveries;

CREATE TABLE deliveries (
    delivery_id INT,
    delivery_time_minutes INT
);

INSERT INTO deliveries VALUES
(1, 45),
(2, 80),
(3, 30),
(4, 65),
(5, 100);


/* Q5 */

SELECT
    delivery_id,
    delivery_time_minutes,
    CASE
        WHEN delivery_time_minutes <= 30 THEN 'Fast'
        WHEN delivery_time_minutes BETWEEN 31 AND 60 THEN 'On Time'
        ELSE 'Late'
    END AS performance
FROM deliveries;


/* =========================================================
   TABLE 6: tickets
   ========================================================= */

DROP TABLE IF EXISTS tickets;

CREATE TABLE tickets (
    ticket_id INT,
    issue_type STRING,
    priority INT
);

INSERT INTO tickets VALUES
(1, 'Login issue', 1),
(2, 'Server down', 3),
(3, 'Slow system', 2),
(4, 'Email error', 2),
(5, 'Password reset', 1);


/* Q6 */

SELECT
    issue_type,
    priority,
    CASE
        WHEN priority = 3 THEN 'High'
        WHEN priority = 2 THEN 'Medium'
        WHEN priority = 1 THEN 'Low'
    END AS priority_label
FROM tickets;


/* =========================================================
   TABLE 7: attendance
   ========================================================= */

DROP TABLE IF EXISTS attendance;

CREATE TABLE attendance (
    student_id INT,
    days_present INT,
    total_days INT
);

INSERT INTO attendance VALUES
(1, 45, 50),
(2, 30, 50),
(3, 48, 50),
(4, 25, 50),
(5, 50, 50);


/* Q7 */

SELECT
    student_id,
    (days_present * 100.0 / total_days) AS attendance_percentage,
    CASE
        WHEN (days_present * 100.0 / total_days) >= 90
            THEN 'Excellent'
        WHEN (days_present * 100.0 / total_days) >= 75
            THEN 'Good'
        ELSE 'Needs Improvement'
    END AS attendance_status
FROM attendance;


/* =========================================================
   TABLE 8: products_inventory
   ========================================================= */

DROP TABLE IF EXISTS products_inventory;

CREATE TABLE products_inventory (
    product_id INT,
    stock_qty INT
);

INSERT INTO products_inventory VALUES
(1, 5),
(2, 0),
(3, 25),
(4, 10),
(5, 3);


/* Q8 */

SELECT
    product_id,
    stock_qty,
    CASE
        WHEN stock_qty = 0 THEN 'Out of Stock'
        WHEN stock_qty BETWEEN 1 AND 5 THEN 'Low Stock'
        ELSE 'In Stock'
    END AS stock_status
FROM products_inventory;


/* =========================================================
   TABLE 9: classes
   ========================================================= */

DROP TABLE IF EXISTS classes;

CREATE TABLE classes (
    class_id INT,
    subject STRING,
    enrolled_students INT
);

INSERT INTO classes VALUES
(1, 'Math', 30),
(2, 'English', 25),
(3, 'Science', 15),
(4, 'Art', 5),
(5, 'History', 20);


/* Q9 */

SELECT
    subject,
    enrolled_students,
    CASE
        WHEN enrolled_students >= 25 THEN 'Large'
        WHEN enrolled_students BETWEEN 10 AND 24 THEN 'Medium'
        ELSE 'Small'
    END AS class_size_category
FROM classes;


/* =========================================================
   TABLE 10: payments
   ========================================================= */

DROP TABLE IF EXISTS payments;

CREATE TABLE payments (
    payment_id INT,
    amount DECIMAL(10,2),
    payment_method STRING
);

INSERT INTO payments VALUES
(1, 50.00, 'Card'),
(2, 200.00, 'Cash'),
(3, 150.00, 'Card'),
(4, 75.00, 'PayPal'),
(5, 300.00, 'Cash');


/* Q10 */

SELECT
    payment_id,
    payment_method,
    amount,
    CASE
        WHEN payment_method = 'Cash'
             AND amount >= 200
            THEN 'Eligible for Discount'
        ELSE 'Not Eligible'
    END AS discount_eligibility
FROM payments;
