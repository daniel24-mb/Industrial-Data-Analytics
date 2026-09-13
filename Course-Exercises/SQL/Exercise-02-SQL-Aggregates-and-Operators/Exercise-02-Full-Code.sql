/* Exercise 2 - SQL Aggregates and Operators */

/* Q1 */
SELECT DISTINCT department
FROM students;

/* Q2 */
SELECT department, AVG(age) AS avg_age
FROM students
GROUP BY department;

/* Q3 */
SELECT department, COUNT(*) AS student_count
FROM students
GROUP BY department
HAVING COUNT(*) > 1;

/* Q4 */
SELECT student_id, name, age, department
FROM students
WHERE age BETWEEN 21 AND 23;

/* Q5 */
SELECT student_id, name, age, department
FROM students
WHERE department IN ('IT', 'HR')
  AND age > 21;

/* Q6 */
SELECT department, SUM(credits) AS total_credits
FROM courses
GROUP BY department
HAVING SUM(credits) > 5;

/* Q7 */
SELECT course_id, course_name, department, credits
FROM courses
WHERE credits != 4;

/* Q8 */
SELECT course_id, course_name, credits
FROM courses
ORDER BY credits DESC
LIMIT 3;

/* Q9 */
SELECT
    MAX(grade) AS max_grade,
    MIN(grade) AS min_grade,
    AVG(grade) AS avg_grade
FROM enrollments;

/* Q10 */
SELECT course_id, COUNT(*) AS enrollment_count
FROM enrollments
GROUP BY course_id;

/* Q11 */
SELECT
    department,
    SUM(salary) AS total_salary,
    SUM(bonus) AS total_bonus
FROM salaries
GROUP BY department;

/* Q12 */
SELECT
    department,
    AVG(salary) AS avg_salary
FROM salaries
GROUP BY department
HAVING AVG(salary) > 55000;

/* Q13 */
SELECT
    employee_id,
    name,
    salary,
    bonus,
    salary + bonus AS total_compensation
FROM salaries
WHERE salary + bonus > 60000;

/* Q14 */
SELECT
    department,
    SUM(budget) AS total_budget,
    AVG(budget) AS avg_budget
FROM projects
GROUP BY department
HAVING AVG(budget) > 70000;

/* Q15 */
SELECT
    project_id,
    project_name,
    department,
    budget
FROM projects
WHERE budget BETWEEN 50000 AND 120000
  AND department != 'Marketing';
