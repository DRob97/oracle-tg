-- Day 1 --

-- Retrieve everything from employees
SELECT * FROM employees;

-- Retrieve first and lastname of every employee
SELECT first_name, last_name from employees;

-- Retrieve all department names from departments table
SELECT department_name from departments;

--------------------------------------------------------------

-- Day 2 --

-- Write the query to get the first_name, job_id from the employee table.
SELECT first_name, job_id from employees;

-- Where clause
SELECT * FROM employees
where employee_id = 100;

-- Get every employee, with manager_id 100
select * from employees
where manager_id = 100;

-- Get firstname and email of every employee with salary of 15000 or higher.
select first_name, email from employees
where salary >= 15000;

-- AND OR NOT
select * from employees
where department_id=80 AND employee_id>170;

select * from employees
where department_id=80 OR employee_id>170;

-- Get first_name of employees, where salary 10000 OR 11000 OR 12000
select first_name from employees
where salary in (10000, 11000, 12000);

-- Get first_name of employees, where salary 10000 OR 11000 OR 12000
select first_name from employees
where salary=10000 OR salary=11000 OR salary=12000;

-- Write the query to get all columns from the employees' table if the department id is 50 and the job id is ?ST_MAN?
select * from employees
where department_id=50 and job_id='ST_MAN';

-- Write the query to get all columns from the employees? table if the department id is 50 or the job id is ?ST_MAN?
select * from employees
where department_id=50 or job_id='ST_MAN';

-- Write the query to get all columns from the employees? table if the department id is 70 or the salary is more than 5000
select * from employees
where department_id=70 or salary>5000;

-- Write the query to get all columns from the employees? table if the department id is 70 and the salary is more than 5000
select * from employees
where department_id=70 and salary>5000;

-- Write the query to find the employees who are not displayed in step 4.
-- 1st way(since we know the employee in step 4)
select * from employees
where employee_id!=204;

-- 2nd way(different interpration)
select * from employees
where department_id!=70 OR salary<=5000;

-- null
select * from employees
where commission_pct is not null;

-- Between, And
-- 1st way, use same format as the table
SELECT * FROM employees
WHERE hire_date BETWEEN '24-JUN-98' AND '24-JUN-99';

-- 2nd way. use TO_DATE function if you're yousing different format
SELECT * FROM employees
WHERE hire_date BETWEEN TO_DATE('1996-07-01','YYYY-MM-DD') AND TO_DATE('1996-07-31','YYYY-MM-DD');

-- Write the query to get all columns from employees table if salary is between 6000 and 100000 and
-- hire date is after June 7, 1997
select * from employees
where salary between 6000 and 100000 and hire_date>'7-JUN-97';

-- Concatination
-- Concatinate first and last name and display it as 'FULL NAME'
select first_name || ' ' || last_name as "FULL NAME" from employees;

-- Write a query to get last name and concatenate ?@gmail.com? to the end and
-- display it as ?Gmail Account? from employees table.
select last_name || '@gmail.com' as "Gmail Account" from employees;

-- Sorting
select first_name, salary from employees
where salary is not null
order by salary asc;

-- Write the query to get all columns from the employee's table for salaries more than 5000 and
-- order the result for hire date in descending order.
select * from employees
where salary > 5000
order by hire_date desc;

-- Multiple sorting
select first_name, salary from employees
where salary in (2500, 9000)
order by salary desc, first_name desc;

-- Like Operator
select first_name from employees
where first_name like 'N%a';

select first_name from employees
where first_name not like '%a%';

select first_name from employees
where first_name like '%t_';

select first_name from employees
where first_name like '__t%';

select first_name from employees
where first_name like '_____';

-- Get first and last name as 'Full Name' where hire date is before June 15, 1998, last name contains letter 't'
-- first name is at least 4 letters and order by salary desc.
select first_name || ' ' || last_name as "Full Name" from employees
where hire_date<'15-JUN-1998'
and last_name like '%t%'
and first_name like '____%'
order by salary desc;

-----------------------------------------------------

-- Day 3 --
-- Single Row Functions

-- UPPER function converts a string to an uppercase.
select upper(first_name) as "Uppercase Firstname" from employees;

-- LOWER function converts a string to lowercase.
-- Create an email address as [first_name]-[last_name]@yahoo.com in all lowercase
select lower(first_name || '-' || last_name || '@yahoo.com') "Yahoo Email" from employees;

-- INITCAP function converts only the initial alphabets of a string to uppercase. 
    -- If everything is already the upper case, it will change everything to the lower case except the first letter.
select initcap(job_id) from employees;

-- Write the query to get all employees last names in upper case.
select upper(last_name) from employees;

-- Write the query to get all employees emails in lower case.
select lower(email) from employees;

-- Write the query to get all employees first name in upper case, last names in lower case and emails in only first letter upper case. 
select upper(first_name), lower(last_name), initcap(email) from employees;

-- Write a query to retrieve the first names and last names of all employees in uppercase, and their job titles in lowercase.
-- Additionally, alias the columns as "First Name", "Last Name", and "Job Title" respectively.
select upper(first_name) as "First Name", upper(last_name) as "Last Name", lower(job_id) as "Job Title" from employees;

-- Write a query and return each row in this format ?<NAME> IS THE NAME and their job is: <JOB_ID> ?
select first_name || ' is the name and their job id is: ' || job_id from employees;


-- LENGTH function returns the length of the input values. It will return length for numbers as well.
select last_name || ' is last name, and its length is: ' || length(last_name) from employees;

-- CONCAT function concatenates two values.
-- 1st way(the one we've been using)
select first_name || last_name from employees;
-- 2nd way
select concat(concat(first_name, last_name), email) from employees;

-- SUBSTR
select first_name, substr(first_name, 4, 2) from employees;
select substr('TechGlobal', 5, 6) from employees;
select substr('TechGlobal', 5, 6) from dual;

-- INSTR function returns numeric position of a character or a string in a given string.
select city, instr(city, 'a') as "Index of 'a'" from locations; 

-- Write a query to find the city that includes the character ?a? in locations.
-- 1st way, using LIKE operator
select city from locations
where city like '%a%';
--2nd way, using INSTR
select city, instr(city, 'a') from locations
where instr(city, 'a') != 0;

-- Write a query to return the first name and last name combined as lowercase with the space and
-- find the index number of ?k? from the combined first name and last name in a single query.
select first_name || ' ' || last_name as "Full Name", 
instr(lower(first_name || ' ' || last_name), 'k') as "Index of 'k'"
from employees;

-- 2nd way, using subquery(we're going to learn it)
select instr("Full Name", 'k') from 
            (select lower(first_name || ' ' || last_name) as "Full Name" from employees);


-- ROUND: rounds decimal point
select round(150.546) from dual; -- 150
select round(150.546, 1) from dual; --150.5
select round(150.556, 1) from dual; --150.6
select round(150.546, 2) from dual; --150.55
select round(150.546, 3) from dual; --150.546

-- TRUNC: truncate decimal point
select trunc(150.546) from dual; -- 150
select trunc(150.546, 1) from dual; --150.5
select trunc(150.556, 1) from dual; --150.5
select trunc(150.546, 2) from dual; --150.54
select trunc(150.546, 3) from dual; --150.546


-- MOD (Modulus): Returns the remainder of the division operation between two numbers.
select mod(15, 4) from dual; --3
select mod(4, 5) from dual; --3


-- LPAD (Left Padding): Left-pads the string with the specified pad_string to reach the desired length.
select lpad('hello', 10, '*') from dual;
select lpad(employee_id, 5, 0) from employees;

-- RPAD (Right Padding): Right-pads the string with the specified pad_string to reach the desired length.
select rpad('hello', 10, '*') from dual;
select rpad(employee_id, 5, 0) from employees;

-- LTRIM (Left Trim): Removes leading spaces from the string.
select LTRIM('    hello') from employees;

-- RTRIM (Right Trim): Removes trailing spaces from the string.
select RTRIM('hello     ') as "Trim" from employees;

-- Our very own function: FULL TRIM: '   hello   '
select ltrim(rtrim('  hello worl!  ')) as "Trim All" from employees;



-- TASKS --

-- Day 4 --
/*
1. Write a query to display the city names in uppercase along with the first 5 characters of the street address
for all locations,order by country.
*/
select upper(city), substr(street_address, 1, 5)
from locations
order by country_id;

/*
2. Create a query to extract the phone number after the first dot(.) for each employee.
Display the employee's email address(<last_name>@techglobal.com) as "Email" and
the extracted phone number as "New Phone Number".
*/
-- 1st way (dynamic)
select substr(phone_number, instr(phone_number, '.') +1) as "New Phone Number",
last_name || '@techglobal.com' as "Email"
from employees
where last_name not like '% %'
and phone_number is not null;

-- 2nd way (not dynamic)
select substr(phone_number, 5) as "New Phone Number",
last_name || '@techglobal.com' as "Email"
from employees
where last_name not like '% %'
and phone_number is not null;

/*
3. Develop a query to calculate the average length of city and street address for each location.
Round the average length to the nearest whole number.
*/
select city, street_address, round((length(city) + length(street_address)) / 2) as "Average length"
from locations;

/*
4. Write a query to display the first name of all employees with an even employee ID, convert their first name to uppercase,
and make sure the first name length is at least 10, if it's less, add dashes(---) to the beginning of their first name.
Do not display if the employee doesn't have a first name.
*/
select lpad(upper(first_name), 10, '-')
from employees
where mod(employee_id, 2) = 0
and first_name is not null;

/*
5. Write a query to retrieve the email addresses of employees whose last names start with 'S', 'T', or 'U',
and who were hired between January 1st, 1995, and December 31st, 1999.
Additionally, ensure that employees with less than 10000 salary are not displayed.
*/
-- 1st way
select email, last_name, salary, hire_date from employees
where last_name like 'S%' or last_name like 'T%' or last_name like 'U%'
and hire_date between TO_DATE('1995-01-01', 'YYYY-MM-DD') and TO_DATE('1999-12-31', 'YYYY-MM-DD')
and salary < 10000;

-- 2nd way
select email, last_name, salary, hire_date from employees
where substr(last_name, 1, 1) in ('S', 'T','U')
and hire_date between TO_DATE('1995-01-01', 'YYYY-MM-DD') and TO_DATE('1999-12-31', 'YYYY-MM-DD')
and salary < 10000;


--------------------------------------------------------------------------------------

-- Multi Row Functions --

-- MAX
-- number
select max(salary) from employees;
-- string
SELECT MAX(first_name) FROM employees;
-- date
SELECT max(hire_date) FROM employees;


-- MIN
-- number
select min(salary) from employees;
-- string
SELECT min(first_name) FROM employees;
-- date
SELECT min(hire_date) FROM employees;


-- AVG
-- 1st way - using AVG function
SELECT '$' || round(AVG(salary), 2) as "Average salary" FROM employees;
-- 2nd way - using other functions
SELECT '$' || round(sum(salary) / count(salary), 2) as "Average salary" FROM employees;

-- SUM
SELECT SUM(salary) FROM employees;

-- COUNT
select count(*) from employees;
select count(first_name) from employees;
select count(commission_pct) from employees;

/*
Class Task
*/
-- Write the query to find the count of employees if the employee first name has more than 4 characters.
select count(first_name) from employees
where length(first_name) > 4;

-- Find the total number of employees whose names start with the letter 'A?.
select count(*) from employees
where first_name like 'A%';

-- Count how many employees have a salary above 5000.
select count(salary) from employees
where salary > 5000;

-- Count how many employees have a commission percentage.
select count(commission_pct) from employees;

-- As we consider that given salaries are monthly, Write the query to find the total salary yearly.
select sum(salary * 12) from employees;
select sum(salary) * 12 from employees;

-- Find the total salary of all employees whose salary is between 3000 and 6000.
select sum(salary) from employees
where salary between 3000 and 6000;


-- GROUP BY --
select department_id, count(*) as number_of_employees
from employees
where department_id is not null
group by department_id
having count(*) > 5
order by number_of_employees desc;

-- CLASS TASKS
-- Calculate the average salary for each job title, but only include job titles where the average salary is greater than 6000.
select avg(salary), job_id
from employees
group by job_id
having avg(salary) > 6000;

-- Find the highest salary in each department and list only those departments where the highest salary is less than 10000.
-- 1st way - using employees
select max(salary), department_id
from employees
group by department_id
having max(salary) < 10000;

-- 2nd way - using jobs (MAX salary per job title)
select max_salary, job_title
from jobs
where max_salary < 10000;


-- For each department, calculate the total salary paid. Only include departments where the total salary is more than 50000,
-- and order the result by total salary in descending order.
select department_id, sum(salary)
from employees
where department_id is not null
group by department_id
having sum(salary) > 50000
order by sum(salary) desc;

-- Find the total number of employees for each job title and list only those job titles that have more than 3 employees.
select  job_id, count(*)
from employees
group by job_id
having count(*) > 3;

-- Calculate the sum of the salaries for each department and only display those where the sum is between 20000 and 50000.
select sum(salary), department_id
from employees
group by department_id
having sum(salary) between 20000 and 50000;


-- TASKS Multi-row functions--
-- 1. Find the total number of locations where the postal code is 5 digits and starts with 9.
-- 1st way
select postal_code, count(*)
from locations
where postal_code like '9%'
group by postal_code
having length(postal_code) = 5;
-- 2nd way
select postal_code, count(*)
from locations
where postal_code like '9____'
group by postal_code;

-- 2. Find the average last name length per department, and display only two digits after the decimal point.
-- 1st way - using round
select department_id, round((avg(length(last_name))), 2)
from employees
group by department_id;
-- 2nd way - using to_char
select department_id, to_char((avg(length(last_name))), '9999.00')
from employees
group by department_id;

-- 3. Find the lowest salary in each department and list only the departments where the average salary is more than 10000.
select min(salary), department_id
from employees
group by department_id
having avg(salary) > 10000;

-- 4. Find the difference between maximum and minimum salary per job title. Do not display if the difference is less than 5000.
-- Display only the first 5 characters of the job title.
-- 1st way - using jobs table - result with company policy data
select substr(job_title, 1, 5), max_salary - min_salary
from jobs
where max_salary - min_salary > 5000;
-- 2nd way - using employees table - result with current employee data
select job_id, max(salary) - min(salary)
from employees
group by job_id
having max(salary) - min(salary) > 5000;

-- 5. Find the maximum commission percentage for each department. Only include departments where the total salary is less than 80000.
-- Order the result by the average salary in descending order.
select max(commission_pct), department_id
from employees
group by department_id
having sum(salary) < 80000
order by avg(salary) desc;

-------------------------------------------------------------------------------------

-- DAY 5 --

-- DISTINCT --
-- Write a query to count all unique region ids under the countries table.
select DISTINCT(region_id)
from countries;

select distinct(country_name)
from countries;

-- SUBQUERY --
-- Step 1. Get the highest salary from employees
select max(salary) from employees;

-- Step 2. Get the first name of all employees
select first_name from employees;

-- Step 3. Get the first name of the employee with the maximum salary
select first_name
from employees
where salary = (select max(salary) from employees);

-- Retrieve the first and last name of employees who makes $3,000.
select first_name, last_name
from employees
where salary = 3000;

-- Retrieve the job_id of the employee who makes least amount of money
select job_id
from employees
where salary = (select min(salary) from employees);


-- Write a query to get the first_name and salary of employees who make more than the employee who has employee_id 121
-- and then order by salary ascending.
select first_name, salary
from employees
where salary > (select salary 
                from employees
                where employee_id = 121)
order by salary;

-- Write a query to get employees first_name, department_id who works in the same department with the employee who employee_id 150.
select first_name, department_id
from employees
where department_id = (select department_id
                       from employees
                       where employee_id = 150);

-- Write a query to find the second highest salary.
select max(salary)
from employees
where salary not in (select max(salary) -- instead of 'not in' you can use '<' or '!='
                     from employees);

-- Write a query to get the names of employees who are making the second largest salary.
select first_name
from employees
where salary = (select max(salary)
                from employees
                where salary != (select max(salary) 
                                 from employees));

-- Write a query to get the number of postal codes under the same countries from the locations table if their count is more than 1.
select country_id, count(postal_code)
from locations
group by country_id
having count(postal_code) > 1;

-- Write a query to get all employees who are making more than the average salary and order by salary.
select *
from employees
where salary > (select avg(salary)
                from employees)
order by salary;

-- Write a query to get all cities that have the same state as Toronto from the locations table.
select city
from locations
where state_province = (select state_province
                        from locations
                        where city = 'Toronto');

-- Write a query to find the employee who is making second lowest salary.
select first_name
from employees
where salary = (select min(salary)
                from employees
                where salary != (select min(salary) 
                                 from employees));
                                 
-- ROWNUM --
select first_name, salary
from employees
where rownum <= 10
order by salary desc;

-- Write a query to get all employee details who has the 5th max salary?
select *
from employees
where salary = (select min(salary)
                from (select distinct(salary)
                      from employees
                      order by salary desc)
                where rownum <= 5);
                
-- Infinite subquery: you can replace 'employees' with '(select * from employees)' for infinite times,
-- because it'll alway return the same table
select * from (select * from (select * from (select * from (select * from (select * from employees)))));


-- Write a query to get all employee details who has the 6th lowest salary?
-- Step 1: Find the unique salaries and put in a order
select distinct(salary)
from employees
order by salary;

-- Step 2: Find the 6 lowest salaries
select max(salary) 
from (select distinct(salary)
      from employees
      order by salary)
where rownum <= 6;

-- Step 3: Get the employee details who makes 6th lowest salary
select *
from employees
where salary = (select max(salary) 
                from (select distinct(salary)
                      from employees
                      order by salary)
                where rownum <= 6);



-- JOINS --
select * from regions
join countries
on regions.region_id = countries.region_id;

-- Same query above, with alias
select * from regions r
join countries c
on r.region_id = c.region_id;

-- Create a join table with first_name, department_id, department_name
select e.first_name, d.department_id, d.department_name
from employees e
join departments d
on e.department_id = d.department_id;

-- Write the query to the print country name, country id, and region name for each country.
select c.country_name, c.country_id, r.region_name
from countries c
join regions r
on c.region_id = r.region_id;

-- Write the query to print the last name, email, and  job title for each employee.
select e.email, e.last_name, j.job_title
from employees e
join jobs j
on e.job_id = j.job_id;

-- JOIN TYPES --
-- Inner join
SELECT e.first_name, d.department_name
FROM employees e
INNER JOIN departments d
on e.department_id = d.department_id;

-- Left join
SELECT e.first_name, d.department_name
FROM employees e
LEFT JOIN departments d
on e.department_id = d.department_id;

-- Right join
SELECT e.first_name, d.department_name
FROM employees e
RIGHT JOIN departments d
on e.department_id = d.department_id;

-- Full join
SELECT e.first_name, d.department_name
FROM employees e
FULL JOIN departments d
on e.department_id = d.department_id;

-- Self join
select e.first_name as "Employee", m.first_name as "Manager"
from employees e
join employees m
on e.manager_id = m.employee_id;


 




