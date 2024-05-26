USE practice;
-- Task 1 Retrieve data from all the tables.

SELECT * FROM employees;
SELECT * FROM departments;
SELECT * FROM dept_emp;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
SELECT * FROM customers;
SELECT * FROM sales;

-- Task2- Subquery in WHERE clause
-- 2.1 Retrieve a list of all employees that are not managers  

SELECT *
FROM employees WHERE emp_no NOT IN(
SELECT emp_no FROM dept_manager);

-- Task 2.2 Retrieve all columns in the sales table for customers above 60 years old  

SELECT * 
FROM sales
WHERE Customer_ID IN (
SELECT Customer_ID 
FROM customers
WHERE Age >60); 

-- Task 2.3 Retrieve a list of all manager's employees number, first and last names  
 
SELECT emp_no, first_name, last_name 
FROM employees 
WHERE emp_no IN (
SELECT emp_no 
FROM dept_manager);

-- Exercise 2.1: Write a JOIN statement to get the result of 2.3  

SELECT employees.emp_no, employees.first_name, employees.last_name 
FROM employees
JOIN dept_manager
ON employees.emp_no= dept_manager.emp_no;

-- Exercise 2.2: Retrieve a list of all managers that were employed between 1st January 1990 and 1st January 1995  

SELECT * FROM dept_manager
WHERE emp_no IN (SELECT emp_no FROM employees
WHERE hire_date BETWEEN '1990-01-01'AND '1995-01-01');

-- Task 3: Subquery in the FROM clause 
-- Retrieve a list of all customers living in the southern region

SELECT * FROM customers
WHERE Region = 'South';

-- Exercise 3.1: Retrieve a list of managers, their first, last, and their department names  

SELECT e.first_name, e.last_name, d.dept_name
FROM employees e
JOIN dept_manager 
ON e.emp_no = dept_manager.emp_no
JOIN departments d
ON dept_manager.dept_no = d.dept_no;

-- Task 4: Subquery in the SELECT clause 
-- Retrieve the first name, last name and average salary of all employees

SELECT e.first_name, e.last_name, AVG(s.salary)
FROM employees e 
JOIN salaries s 
ON e.emp_no = s.emp_no
GROUP BY e.first_name, e.last_name;

SELECT first_name, last_name, (SELECT AVG(salary) FROM salaries)
FROM employees;

-- Exercise 4.1: Retrieve a list of customer_id, product_id, order_line and the name of the customer  

SELECT Customer_ID, Product_ID, Order_line, (SELECT c.Customer_Name FROM customers c
WHERE c.Customer_ID = sales.Customer_ID) AS customer_name
FROM sales;

SELECT s.Customer_ID, s.Product_ID, s.Order_line, c.Customer_Name
FROM sales s
JOIN customers c ON s.Customer_ID= c.Customer_ID;

-- Task 5: Subquery Exercises - Part One 
-- Exercise 5.1: Return a list of all employees who are in the Customer Service department

(SELECT * FROM dept_emp WHERE dept_no IN (SELECT dept_no FROM departments WHERE dept_name = 'Customer Service'));

-- Exercise 5.2: Include the employee number, first and last names  

SELECT e.emp_no, d.dept_no, e.first_name, e.last_name
FROM employees e
JOIN (SELECT * FROM dept_emp WHERE dept_no IN (SELECT dept_no FROM departments WHERE dept_name = 'Customer Service')) d ON e.emp_no = d.emp_no ;

-- Exercise 5.3: Retrieve a list of all managers who became managers after the 1st of January, 1985 and are in the Finance or HR department  

SELECT * FROM dept_manager 
WHERE from_date > '1985-01-01' AND dept_no IN (SELECT dept_no FROM departments WHERE dept_name = 'Finance' OR dept_name = 'Human Resources');

-- Exercise 5.4: Retrieve a list of all employees that earn above 120,000 and are in the Finance or HR departments  

SELECT emp_no, salary 
FROM salaries 
WHERE salary > 120000 
AND emp_no IN (SELECT emp_no FROM dept_emp WHERE dept_no = 'd002'OR dept_no = 'd003');

-- Exercise 5.5: Retrieve the average salary of these employees  

SELECT a.emp_no, AVG(a.salary) FROM (SELECT emp_no, salary 
FROM salaries 
WHERE salary > 120000 
AND emp_no IN (SELECT emp_no FROM dept_emp WHERE dept_no = 'd002'OR dept_no = 'd003')) a
GROUP BY a.emp_no;

-- Task 6: Subquery Exercises - Part Two 
-- Exercise 6.1: Return a list of all employees number, first and last name. Also, return the average salary of each employee  
-- average salary of all employees

SELECT e.emp_no, e.first_name, e.last_name, (SELECT AVG(salary) FROM salaries)
FROM employees e;

-- average salary of each employee
SELECT e.emp_no, e.first_name, e.last_name, AVG(s.salary) AS average_salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY e.emp_no;

-- Exercise 6.2: Find the difference between an employee's average salary and the average salary of all employees  
-- salary difference
SELECT e.emp_no, e.first_name, e.last_name, (AVG(s.salary) - (SELECT AVG(salary) FROM salaries)) AS salary_difference
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY e.emp_no;

-- Exercise 6.3: Find the difference between the maximum salary of employees in the Finance or HR department and the maximum salary of all employees  
-- maximum salary of all employees
SELECT MAX(salary) FROM salaries;

-- Maximum salary of employees in the finance and HR department 
SELECT s.emp_no, MAX(s.salary)
FROM salaries s
JOIN dept_emp d ON d.emp_no = s.emp_no
WHERE d.dept_no = 'd002'OR d.dept_no = 'd003'
 GROUP BY s.emp_no;
 
 -- difference between the maximum salary of employees in the Finance or HR department and the maximum salary of all employees 
 SELECT s.emp_no, (MAX(s.salary) - (SELECT MAX(salary) FROM salaries)) AS salary_difference
FROM salaries s
JOIN dept_emp d ON d.emp_no = s.emp_no
WHERE d.dept_no = 'd002'OR d.dept_no = 'd003'
 GROUP BY s.emp_no
 ORDER by s.emp_no;
 
 -- Maximum salary of employee in the finance and HR department 
 SELECT d.dept_no, MAX(s.salary)
FROM salaries s
JOIN dept_emp d ON d.emp_no = s.emp_no
WHERE d.dept_no = 'd002'OR d.dept_no = 'd003'
 GROUP BY  d.dept_no;

-- Task 7: Subquery Exercises - Part Three 
-- Exercise 7.1: Retrieve the salary that occurred the most  

SELECT  salary, COUNT( salary) AS salary_count
FROM salaries
GROUP BY salary
ORDER BY COUNT( salary) DESC
LIMIT 1;

-- Exercise 7.2: Find the average salary excluding the highest and the lowest salaries 
-- salary ecluding highest and lowest salaries
SELECT salary
FROM salaries
WHERE salary NOT IN (SELECT MAX(salary) FROM salaries)
  AND salary NOT IN (SELECT MIN(salary) FROM salaries);

-- average salary excluding the highest and the lowest salaries
SELECT AVG(salary)
FROM salaries
WHERE salary NOT IN (SELECT MAX(salary) FROM salaries)
  AND salary NOT IN (SELECT MIN(salary) FROM salaries);

-- Exercise 7.3: Retrieve a list of customers id, name that has bought the most from the store
-- list of customers id by number of orders
SELECT Customer_ID, COUNT(Order_ID)
FROM sales
GROUP BY Customer_ID
ORDER BY COUNT(Order_ID) DESC;

-- list of customers id, name that has bought the most from the store
SELECT s.Customer_ID, c.Customer_Name, COUNT(s.Order_ID) AS Order_Count
FROM sales s
JOIN customers c
ON s.Customer_ID = c.Customer_ID
GROUP BY s.Customer_ID
ORDER BY COUNT(s.Order_ID) DESC;

-- Exercise 7.4: Retrieve a list of the customer’s name and segment of those customers that bought the most from the store and had the highest total sales  

SELECT c.Customer_ID, c.Customer_Name, c.segment, COUNT(s.Order_ID) AS Order_Count, SUM(s.sales) AS total_sales
FROM sales s
JOIN customers c
ON s.Customer_ID = c.Customer_ID
GROUP BY s.Customer_ID
ORDER BY SUM(s.sales) DESC;





 

