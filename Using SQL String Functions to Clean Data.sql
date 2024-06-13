USE practice;

-- Retrieve data from the employees table  
SELECT* FROM employees;

-- Find the length of the first name of male employees  
SELECT first_name, LENGTH(first_name) AS character_length
FROM employees
WHERE gender = 'M';

-- Find the length of the first name of male employees where the length of the first name is greater than 5 
SELECT first_name, LENGTH(first_name) AS character_length
FROM employees
WHERE gender = 'M' AND LENGTH(first_name)> 5
ORDER BY LENGTH(first_name);

-- Retrieve a list of the customer group of all customers 
SELECT customer_id, LEFT(Customer_ID, 2) AS cust_group
FROM customers; 

-- Retrieve a list of the customer number of all customers 
SELECT customer_id, RIGHT(Customer_ID, 5) AS cust_num
FROM customers; 

-- Retrieve the length of customer id column
SELECT Customer_ID, LENGTH(Customer_ID) FROM customers;

-- Change Coursera-Guided-Projects to uppercase letters  
SELECT UPPER("Coursera-Guided-Projects");

-- Change Coursera-Guided-Projects to lowercase letters  
SELECT LOWER("Coursera-Guided-Projects");

-- Retrieve the details of the first employee  
SELECT * FROM employees 
WHERE emp_no = 10001;

-- change the first name of the first employee to uppercase letters 
SELECT UPPER(first_name) FROM employees;

-- Change M to Male in the gender column of the employees table  
SELECT REPLACE(gender, 'M','Male') AS emp_gender
 FROM employees;
 
 -- Change F to Female in the gender column of the employees table
 SELECT REPLACE(gender, 'F','Female') AS emp_gender
 FROM employees;
 
 -- Change United States to US in the country column of the customers table  
  SELECT REPLACE(Country, 'United States','US') AS Cus_country
 FROM customers;
 
 -- Trim the word Coursera-Guided-Projects  
 SELECT TRIM("   Coursera-Guided-Projects   ");
 
 -- Right trim the word Coursera-Guided-Projects  
 SELECT RTRIM("Coursera-Guided-Projects    ");

-- Left trim the word Coursera-Guided-Projects  
 SELECT LTRIM("   Coursera-Guided-Projects");
 
 -- Remove the brackets from each customer id in the bracket_cust_id column
SELECT REPLACE (REPLACE(bracket_cust_id, '(', ''), ')', ' ' ) AS cleaned_cust_id
FROM customers;

-- Create a new column called Full_Name from the first_name and last_name of employees  
SELECT CONCAT (first_name, ' ', last_name) AS Full_name FROM employees;

SELECT CONCAT_WS (' ', first_name, last_name) AS Full_name FROM employees;

-- Create a new column called Address from the city, state, and country of customers  
SELECT CONCAT_WS (', ', City, State, Country) AS Address FROM customers;

-- Create a column called desc_age from the customers name and age
SELECT CONCAT(Customer_Name, ' is ', Age, ' years old.') AS desc_age FROM customers;

-- Retrieve the IDs, names, and groups of customers  
SELECT Customer_ID, Customer_Name, SUBSTRING(Customer_ID, 1, 2) AS cust_group
FROM customers;

-- Retrieve the IDs, names of customers in the customer group 'AB'  
SELECT Customer_ID, Customer_Name, SUBSTRING(Customer_ID, 1, 2) AS cust_group
FROM customers
WHERE SUBSTRING(Customer_ID, 1, 2) = 'ÁB' ;

-- Retrieve the IDs, names, and customer number of customers in the customer group 'AB'
SELECT Customer_ID, Customer_Name, SUBSTRING(Customer_ID, 4, 5) AS cust_num
FROM customers
WHERE SUBSTRING(Customer_ID, 1, 2) = 'ÁB' ;

-- Retrieve the year of birth for all employees
SELECT emp_no, birth_date, SUBSTRING(birth_date, 1, 4) AS birth_year
FROM employees;

SELECT emp_no, birth_date, CAST(birth_date AS CHAR(4)) AS birth_year
FROM employees;
 
 SELECT emp_no, birth_date, CAST(YEAR(birth_date) AS UNSIGNED) AS birth_year
FROM employees;

-- Retrieve data from the dept_emp table  
SELECT * FROM dept_emp;

-- Retrieve a list of all department numbers for different employees  
SELECT emp_no, GROUP_CONCAT(dept_no,' ') AS dept_list
FROM dept_emp
GROUP BY emp_no;

-- Retrieve data from the sales table  
SELECT * FROM sales;

-- Retrieve a list of all products that were ordered by a customer from the sales table  
SELECT Order_ID, GROUP_CONCAT(Product_ID,' ') AS product_list
FROM sales
GROUP BY Order_ID;

-- Task 9: COALESCE 
-- Retrieve data from the departments_dup table  
SELECT * FROM departments_dup;

-- Replace all missing department number with their department name  
SELECT dept_no, dept_name, coalesce(dept_no, dept_name) AS dept
FROM departments_dup;

-- Change every missing department number to 'No Department Number' and every missing department name to 'No Department Name' respectively  
SELECT coalesce(dept_no, 'No Department Number') AS new_dept_no, coalesce(dept_name, 'No Department Name') AS new_dept_name
FROM departments_dup;

-- Replace a missing country with the city, state or No Address 
SELECT * FROM customers;

SELECT coalesce(Country, City, State, 'No Address') AS cust_add FROM customers;

SELECT coalesce(Country, City) AS cust_add FROM customers;
