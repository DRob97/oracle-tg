-- Day 1 --

-- Retrieve everything from employees
SELECT * FROM employees;

-- Retrieve first and last name of every employee
SELECT FIRST_NAME, LAST_NAME FROM employees;

-- Retrieve all department names from departments table
Select department_name from departments;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Day 2 --

-- Write the query to get the first_name, job_id from the employee table.
select first_name, job_id from employees;

-- Where clause
select * from employees
where employee_id = 100;

-- Get every employee with manager_id 100
select * from employees
where manager_id = 100;

-- Get first_name and email of every employee with salary of 15000 or higher
select first_name, email from employees
where salary >= 15000;

-- and or not
SELECT * FROM employees
where department_id = 80
and employee_id > 170;

select * from employees
where department_id = 80
or employee_id > 170;

-- Get first_name of employees, where salary is 10000, or 11000, or 12000
select first_name from employees
where salary in (10000, 11000, 12000);

-- Class Task
-- Write the query to get all columns from the employees table if the department
-- id is 50...
-- or the job_id is "ST_MAN"
select * from employees
where department_id = 50
or job_id = 'ST_MAN';
-- and the job_id is "ST_MAN"
select * from employees
where department_id = 50
and job_id = 'ST_MAN';

-- Write the query to get all columns from the employees table if the department
-- id is 70...
-- or the salary is greater than 5000
select * from employees
where department_id = 70
or salary > 5000;

-- and the salary is greater than 5000
select * from employees
where department_id = 70
and salary > 5000;

-- Write the query to find the employees who are not displayed in step 4
-- 1st way
select * from employees
where not employee_id = 204;
/* below is better, arguably
select * from employees
where employee_id != 204;
*/
-- 2nd way less accurate/does not work
select * from employees
where department_id != 70
and salary <= 5000;

-- null
select * from employees
where commission_pct is not null;

-- between & and
-- 1st way, use same format as table
select * from employees
where hire_date between '24-JUN-98' and '24-JUN-99';

-- 2nd way, use to_date to specify format
select * from employees
where hire_date between TO_DATE('1996-07-01', 'YYYY-MM-DD') and TO_DATE('1996-07-31', 'YYYY-MM-DD');

-- Class task 2
-- Write the query to get all columns from employees table if salary is between
-- 6000 and 100000 and hire date is after June 7, 1997
select * from employees
where salary between 6000 and 100000
and hire_date > '7-JUN-97';

-- Concatenation
-- Concatenate first and last name and display it as "FULL NAME"
select first_name || ' ' ||last_name as "FULL NAME" from employees;

-- Write a query to get last name and concatenate '@gmail.com' to the end and
-- display it as 'Gmail Account' from the employees table
select last_name || '@gmail.com' as "Gmail Account" from employees;

-- Sorting
select first_name, salary from employees
order by salary asc; -- Use desc for descending

select first_name, salary from employees
where salary is not null
order by salary; -- Ascending is default

-- Write the query to get all columns from the employee's table for salaries
-- more than 5000 and order the result for hire date in descending order.
select * from employees
where salary > 5000
order by hire_date desc;

-- Multiple sorting
---- Sorted by first, then second, and so on
select first_name, salary from employees
where salary in (2500, 9000)
order by salary desc, first_name desc;

-- Like operator
select first_name from employees
where first_name like 'N%a';
-- %a% means includes, %a means ends with, a% means starts with
select first_name from employees
where first_name not like '%a%';

select first_name from employees
where first_name like '%t_';

select first_name from employees
where first_name like '__t%';

select first_name from employees
where first_name like '_____';

-- Get first and last name as "Full Name" where hire date is before Jun 15, 1998
-- last name contains letter 't', first name is at least 4 letters long and 
-- order by salary desc
select first_name || ' ' || last_name as "Full Name" from employees
where hire_date < '15-JUN-98'
and last_name like '%t%'
and first_name like '____%'
order by salary desc;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Day 3 --
-- Single Row Functions

-- UPPER function converts a string to uppercase
select upper(first_name)as "Uppercase Firstname" from employees;

-- LOWER function converts a string to lowercase
-- Create an email address as [first_name]-[last_name]@yahoo.com, in all lowercase
select lower(first_name || '-' || last_name || '@yahoo.com') as "Email Address" from employees;

-- INITCAP function changes all characters to lowercase, except first letter
select initcap(job_id) from employees;

-- Class Task
-- 1: Write the query to get all employees last names in upper case.
select upper(last_name) from employees;

-- 2: Write the query to get all employees emails in lower case.
select lower(email) from employees;

-- 3: Write the query to get all employees first name in upper case, last names
--    in lower case and emails in only first letter upper case.
select upper(first_name), lower(last_name), initcap(email) from employees;

-- 4: Write a query to retrieve the first names and last names of all employees
--    in uppercase, and their job titles in lowercase. Additionally, alias the
--    columns as "First Name", "Last Name", and "Job Title" respectively.
select upper(first_name) as "First Name",
upper(last_name) as "Last Name",
lower(job_id) as "Job Title" from employees;

-- 5: Write a query and return each row in this format "<NAME> IS THE NAME and
--    their job is: <JOB_ID> "
select upper(first_name || ' ' || last_name || ' is the name ') ||
lower('and their job is: ' || job_id) from employees;

-- LENGTH function returns the length of the input values. It will return length
-- for numbers as well
select last_name || ' is last name, and its length is: ' || length(last_name) from employees;

-- Concat function concatenates two values
-- 1st way:
select first_name || last_name from employees;

-- 2nd way: only allows us to concatenate 2 things together; can nest
select concat(first_name, last_name) from employees;

-- SUBSTR: (target, starting point(not index), how many characters you want to go)
select first_name, substr(first_name, 4, 3) from employees;
select substr('TechGlobal', 5, 6) from employees;
select substr('TechGlobal', 5, 6) from dual;

-- INSTR function returns numeric position of a string i na given string

-- Class Task
-- Write a query to find the city that includes the character 'a' in locations
-- 1st way: like operator
select city from locations
where city like '%a%';

-- 2nd way: using instr
select city, instr(city, 'a') from locations
where instr(city, 'a') != 0;
-- Write a query to return teh first name and last name combined as lowercase
-- with the space and find the index number of 'k' from the combined name
-- in a single query
select lower(first_name || ' ' || last_name) as "Full Name",
instr(lower(first_name || ' ' || last_name), 'k') as "Index of 'k'" from employees;

-- ROUND: rounds decimal point
select round(150.546) from dual;        -- 151
select round(150.546, 0) from dual;     -- 151
select round(150.546, 1) from dual;     -- 150.5
select round(150.546, 2) from dual;     -- 150.55
select round(150.546, 3) from dual;     -- 150.546
select round(150.546, 4) from dual;     -- 150.546
select round(-150.546, 2) from dual;    -- -150.55

-- TRUNC
select trunc(150.546) from dual;        -- 150
select trunc(150.546, 1) from dual;     -- 150.5
select trunc(150.546, 2) from dual;     -- 150.54
select trunc(150.546, 3) from dual;     -- 150.546
select trunc(150.546, 4) from dual;     -- 150.546
select trunc(-150.546, 2) from dual;    -- -150.54

-- MOD (modulus): works like % in js
select mod(15, 4) from dual;    -- 3
select mod(20, -4) from dual;   -- 0

-- LPAD: Left-pads the string with the specified pad_string to reach the desired length
select lpad('hello', 10, '*') from dual;
select lpad(employee_id, 5, 0) from employees;

-- RPAD: like LPAD, but on the right
select rpad('hello', 10, '*') from dual;
select rpad(employee_id, 5, 0) from employees;

-- LTRIM: removes leading spaces from the string
select ltrim('     hello') from dual;

-- RTRIM: removes following spaces from the string
select rtrim('hello     ') from dual;

-- Our very own function: FUll TRIM: '     hello     '
select ltrim(rtrim('     hello     ')) as "Trim All" from dual;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Day 4 --
-- Practices Review
-- 1. Write a query to display the city names in uppercase along with the first
--    5 characters of the street address for all locations, order by country.
select upper(city), substr(street_address, 1, 5)
from locations
order by country_id;

-- 2. Create a query to extract the phone number after the first dot(.) for each
--    employee. Display the employee's email address(<last_name>@techglobal.com)
--    as "Email" and the extracted phone number as "New Phone Number".
select substr(phone_number, instr(phone_number, '.') + 1) as "New Phone Number",
last_name || '@techglobal.com' as "Email" from employees
where phone_number is not null;

-- 3. Develop a query to calculate the average length of city and street address
--    for each location. Round the average length to the nearest whole number.
select round((length(city) + length(street_address)) / 2) from locations;

-- 4. Write a query to display the first name of all employees with an even employee
--    ID, convert their first name to uppercase, and make sure the first name length
--    is at least 10, if it's less, add dashes(---) to the beginning of their first name.
--    Do not display if the employee doesn't have a first name.
select lpad(upper(first_name),10, '-') from employees
where mod(employee_id, 2) = 0
and first_name is not null;

-- 5. Write a query to retrieve the email addresses of employees whose last names
--    start with 'S', 'T', or 'U', and who were hired between January 1st, 1995,
--    and December 31st, 1999. Additionally, ensure that employees with greater than
--    10000 salary are not displayed.
select email from employees
where substr(last_name, 1, 1) in ('S', 'T', 'U')
and hire_date between TO_DATE('1995-01-01', 'YYYY-MM-DD') and TO_DATE('1999-12-31', 'YYYY-MM-DD')
and salary < 10000;
--------------------------------------------------------------------------------

-- Now Classwork
-- MAX: works like Math.max() in js
select max(salary) from employees;
-- but also works with ASCII table automatically
select max(first_name) from employees;
-- and also dates
select max(hire_date) from employees;

-- MIN: works like Math.min() in js
select min(salary) from employees;
-- but also works with ASCII table automatically
select min(first_name) from employees;
-- and also dates
select min(hire_date) from employees;

-- AVG
-- 1st way: using AVG function
select '$' || round(avg(salary)) from employees;
-- 2nd way: using other functions
select '$' || round(sum(salary) / count(salary)) from employees;

-- SUM
select '$' || sum(salary) from employees;

-- COUNT
select count(*) from employees;
select count(first_name) from employees;
select count(commission_pct) from employees;

-- Class Task
-- 1. Write the query to find the count of employees if the employee first name
--    has more than 4 characters.
select count(first_name) from employees
where first_name like '_____%';
-- 2. Find the total number of employees whose names start with the letter 'A’.
select count(first_name) from employees
where substr(first_name, 1, 1) in ('A');
-- 3. Count how many employees have a salary above 5000.
select count(salary) from employees
where salary > 5000;
-- 4. Count how many employees have a commission percentage.
select count(commission_pct) from employees;
-- 5. As we consider that given salaries are monthly, Write the query to find
--    the total salary yearly.
select '$' || sum(salary * 12) as "Yearly Salary" from employees;
-- 6. Find the total salary of all employees whose salary is between 3000 and 6000.
select '$' || sum(salary) as "Yearly Salary" from employees
where salary between 3000 and 6000;

-- GROUP BY --
select department_id, count(*) as number_of_employees
from employees
where department_id is not null
group by department_id
order by number_of_employees;

select department_id, count(*) as number_of_employees
from employees
where department_id is not null
group by department_id
having count(*) >= 5
order by number_of_employees desc;


-- Class Task
-- 1. Above example
-- 2. Calculate the average salary for each job title, but only include job
--    titles where the average salary is greater than 6000.
select avg(salary), job_id
from employees
group by job_id
having avg(salary) > 6000;
-- 3. Find the highest salary in each department and list only those departments
--    where the highest salary is less than 10000.
select max(salary), department_id
from employees
group by department_id
having max(salary) < 10000;
-- 4. For each department, calculate the total salary paid. Only include departments
--    where the total salary is more than 50000, and order the result by total salary
--    in descending order.
select department_id, sum(salary)
from employees
where department_id is not null
group by department_id
having sum(salary) > 50000
order by sum(salary) desc;
-- 5. Find the total number of employees for each job title and list only those
--    job titles that have more than 3 employees.
select job_id, count(*) as number_of_employees
from employees
group by job_id
having count(*) > 3;
-- 6. Calculate the sum of the salaries for each department and only display those
--    where the sum is between 20000 and 50000.
select department_id, sum(salary)
from employees
group by department_id
having sum(salary) between 20000 and 50000;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Day 5 --
-- Practices Review
-- 1. Find the total number of locations where the postal code is 5 digits and
--    starts with a 9.
select postal_code from locations
where postal_code like '9____';

-- 2. Find the average last name length per department, and display only two
--    digits after the decimal point.
select department_id, to_char(avg(length(last_name)), '9999.00') from employees
group by department_id;

-- 3. Find the lowest salary in each department and list only the departments
--    where the average salary is more than 10,000.
select min(salary), department_id from employees
group by department_id
having avg(salary) > 10000;

-- 4. Find the difference between maximum and minimum salary per job title. Do not
--    display if the difference is less than 5000. Display only the first 5 characters
--    of the job title.
select (max(salary) - min(salary)) as "Salary Difference", substr(job_id, 1, 5) from employees
group by job_id
having (max(salary) - min(salary)) > 5000;

select substr(job_title, 1, 5), max_salary - min_salary
from jobs
where (max_salary - min_salary) > 5000;

-- 5. Find the maximum commission percentage for each department. Only include
--    departments where the total salary is less than 80,000. Order the result by
--    the average salary in descending order.
select max(commission_pct), department_id from employees
group by department_id
having sum(salary) < 80000
order by avg(salary) desc;
--------------------------------------------------------------------------------
-- DISTINCT
-- Write a query to count all unique region ids under the countries table
select distinct(region_id)
from countries;

select distinct(country_name)
from countries;
-- SUBQUERY
-- Step 1. Get highest salary from employees
select max(salary) from employees;

-- Step 2. Get the first name of all employees
select first_name from employees;

-- Step 3. Get the first name of the employee with the highest salary
select first_name from employees
where salary = (select max(salary) from employees);

-- Retrieve the first and last name of employees who makes $3000.
select first_name, last_name from employees
where salary = 3000;

-- Retrieve the job_id of the employee who makes least amount of money
select job_id
from employees
where salary = (select min(salary) from employees);

-- Class Tasks
-- 1. Write a query to get the first_name and salary of employees who make more
--    than the employee who has employee_id 121 and then order by salary ascending.
select first_name, salary
from employees
where salary > (select salary
                from employees
                where employee_id = 121)
order by salary;

-- 2. Write a query to get employees first_name, department_id who works in the
--    same department with the employee who employee_id 150.
select first_name, department_id
from employees
where department_id = (select department_id
                       from employees
                       where employee_id = 150);

-- 3. Write a query to find the second biggest salary.
select max(salary)
from employees
where salary != (select max(salary) -- could use 'not in' or '<' instead of '!='
                 from employees);

-- 4. Write a query to get the names of employees who are making the second largest salary.
select first_name
from employees
where salary = (select max(salary)
                from employees
                where salary != (select max(salary)
                                 from employees));

-- 5. Write a query to get the number of postal codes under the same countries
--    from the locations table if their count is more than 1.
select count(postal_code), country_id
from locations
group by country_id
having count(postal_code) > 1;

-- 6. Write a query to get all employees who are making more than the average
--    salary and order by salary.
select *
from employees
where salary > (select avg(salary)
                from employees)
order by salary;

-- 7. Write a query to get all cities that have the same state as Toronto from the locations table.
select city
from locations
where state_province = (select state_province
                        from locations
                        where city = 'Toronto');

-- 8. Write a query to find the employee who is making second lowest salary.
select *
from employees
where salary = (select min(salary)
                from employees
                where salary != (select min(salary)
                                 from employees));

-- ROWNUM
select first_name, salary
from employees
where rownum <= 10
order by salary desc;

-- Write a query to get all employee details who has the 5th highest salary
select *
from employees
where salary = (select min(salary)
                from (select distinct(salary)
                             from employees
                             order by salary desc)
where rownum <= 5);

-- Write a query to get all employee details who has the 6th lowest salary
select *
from employees
where salary = (select max(salary)
                from (select distinct(salary)
                             from employees
                             order by salary)
                where rownum <= 6);

-- JOINS
select *
from regions
join countries
on regions.region_id = countries.region_id;

-- Same query as above but with ALIAS
select *
from regions r
join countries c
on r.region_id = c.region_id;

-- Create a join table with first_name, department_id, department_name
select e.first_name, e.department_id, d.department_name
from employees e
join departments d
on e.department_id = d.department_id;

-- Class task
-- 1. Write the query to print the country name, country id, and region name for each country
select c.country_name, c.country_id, r.region_name
from countries c
join regions r
on c.region_id = r.region_id;

-- 2. Write the query to print the last name, email, and job title for each employee
select e.last_name, e.email, j.job_title
from employees e
join jobs j
on e.job_id = j.job_id;

-- JOIN TYPES --
-- INNER JOIN
select e.first_name, d.department_id
from employees e
inner join departments d
on e.department_id = d.department_id;
-- LEFT JOIN
select e.first_name, d.department_id
from employees e
left join departments d
on e.department_id = d.department_id;
-- RIGHT JOIN
select e.first_name, d.department_id
from employees e
right join departments d
on e.department_id = d.department_id;
-- FULL JOIN
select e.first_name, d.department_id
from employees e
full join departments d
on e.department_id = d.department_id;
-- SELF JOIN
select e.first_name as "Employee", m.first_name as "Manager"
from employees e
join employees m
on e.manager_id = m.employee_id;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Day 6 --
-- Practices Review
-- 1. Generate a query to display the first name, last name, and job title of employees
--    who earn a salary greater than the average salary of employees in the 'Finance' department.
select e.first_name, e.last_name, j.job_title
from employees e
join jobs j
on e.job_id = j.job_id
where salary > (select avg(salary)
                from employees
                where department_id = 100);
                
-- 2. Develop a query to list all employees along with their hire dates, whose hire
--    date is later than the average hire date of employees in the same department.
select to_date(round(avg(to_number(to_char(hire_date, 'J')))), 'J') as "Average Hire Date by Department", department_id as "Department"
from employees
group by department_id;

select first_name, hire_date, department_id
from employees e
where hire_date > (select to_date(round(avg(to_number(to_char(hire_date, 'J')))), 'J')
                    from employees
                    where department_id = e.department_id);

-- 3. Develop a query to find the employee with the highest salary in each department.
select first_name
from employees e
where salary = (select max(salary)
                from employees
                where department_id = e.department_id);

-- 4. Create a query to retrieve the first name, last name, and department name of each
--    employee, but only for employees hired after January 1st, 1995.
select e.first_name, e.last_name, d.department_name
from employees e
join departments d
on e.department_id = d.department_id
where hire_date > to_date('01-01-1995', 'MM-DD-YYYY');

-- 5. Write a query to list all employees and their corresponding job history records,
--    including employees without any job history and job history records without corresponding employees.
select e.first_name, h.*
from employees e
full join job_history h
on e.employee_id = h.employee_id;

-- 6. Write a query to retrieve the first name, last name, and job title of each employee
--    along with their job start date and end date.
select e.first_name || ' ' || e.last_name as "Employee Name", h.start_date as "Start Date", h.end_date as "End Date", j.job_title as "Job Title"
from employees e
full join jobs j
on e.job_id = j.job_id
full join job_history h
on e.employee_id = h.employee_id;

-- 7. Find the employees with a salary more than their managers' salary.
select e.first_name, e.employee_id
from employees e
join employees f
on e.manager_id = f.employee_id
where e.salary > f.salary;

-- 8. Write a query to get the count of employees for each manager and order by count of employees.
select count(*), e.manager_id
from employees e
join employees m
on e.manager_id = m.employee_id
group by e.manager_id
order by count(*);

-- Bonus: Write a query to retrieve the first name, last name, and job title of employees
--    who have a higher salary than the average salary of employees in the same department.
--    Include only employees who work in departments located in countries where the postal
--    code starts with '9'.
select e.first_name, e.last_name, j.job_title, l.country_id
from employees e
join jobs j
on e.job_id = j.job_id
join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
where salary > (select avg(salary)
                from employees
                where department_id = e.department_id)
and l.country_id in(select country_id
                    from locations
                    where postal_code like '9%');
                    
-- SET OPERATORS --
-- UNION
select manager_id from employees
UNION
select manager_id from departments;

select first_name, hire_date, salary
from employees
where salary between 4000 and 7000
UNION
select first_name, hire_date, salary
from employees
where salary between 6000 and 9000
order by salary;

select first_name, hire_date, salary
from employees
where salary between 4000 and 7000
or salary between 6000 and 9000
order by salary;

-- UNION ALL
select manager_id from employees
UNION ALL
select manager_id from departments;

select first_name, hire_date, salary
from employees
where salary between 4000 and 7000
UNION ALL
select first_name, hire_date, salary
from employees
where salary between 6000 and 9000
order by salary;

-- INTERSECT
select first_name, hire_date, salary
from employees
where salary between 4000 and 7000
INTERSECT
select first_name, hire_date, salary
from employees
where salary between 6000 and 9000
order by salary;

-- MINUS
select first_name, hire_date, salary
from employees
where salary between 4000 and 7000
MINUS
select first_name, hire_date, salary
from employees
where salary between 6000 and 9000
order by salary;

-- DDL --
-- Create Table and Insert Data

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Day 7 --
-- Class Tasks
-- 1. Write a query to find the total number of employees in each department, but
--    only include departments with more than 10 employees.
select count(*), department_id
from employees
group by department_id
having count(*) > 10;
-- 2. Develop a query to calculate the average salary of employees in each job title,
--    but only include job titles where the average salary is greater than $5000.
select avg(e.salary), j.job_title
from employees e
join jobs j
on e.job_id = j.job_id
group by j.job_title
having avg(e.salary) > 5000
order by avg(e.salary);
-- 3. Create a query to find the department(s) with the highest total salary expense,
--    considering only departments where the total salary expense exceeds $80,000.
select sum(salary), department_id
from employees
group by department_id
having sum(salary) > 80000;

-- left table: employees
-- right table: departments
select e.first_name, d.manager_id
from employees e
left join departments d
on d.department_id = e.department_id;
 
-- left table: employees
-- right table: departments
select e.first_name, d.manager_id
from employees e
right join departments d
on d.department_id = e.department_id;
 
-- left table: departments
-- right table: employees
select e.first_name, d.manager_id
from departments d
left join employees e
on d.department_id = e.department_id;

/*
Write a query to find the department names where the average salary of employees is greater than
the overall average salary of all employees in the company. Include the department name
and the average salary of employees in that department. Display the salary with only
two 2 decimal points and with a dollar sign($).
*/
select d.department_name, '$' || round(avg(e.salary), 2)
from employees e
join departments d
on e.department_id = d.department_id
group by d.department_name
having avg(e.salary) > (select avg(salary) from employees);


-- 1. Write a query to retrieve the first name, last name, and job title of employees
--    who work in departments located in countries with a region ID of 2. Additionally,
--    calculate the difference between the maximum and minimum salaries in each department.
select e.first_name, e.last_name, j.job_title
from employees e
join jobs j
on e.job_id = j.job_id
where department_id in(select d.department_id
                        from departments d
                        join locations l
                        on d.location_id = l.location_id
                        join countries c
                        on l.country_id = c.country_id
                        where c.region_id = 2);

--select (max(salary) - min(salary)) as "Difference"
--from employees
--group by department_id;

-- 2. Develop a query to display the first name, last name, and hire date of each
--    employee, along with the number of years they have been working in the company.
--    Exclude employees with the job title 'President'.
select e.first_name, e.last_name, e.hire_date, round((current_date - e.hire_date) / 365, 0) || ' Years' as "Length of Employment"
from employees e
join jobs j
on e.job_id = j.job_id
where j.job_title != 'President';


-- 3. Generate a query to list all departments along with the total number of employees
--    and the average salary of employees in each department. Only include departments
--    where the average salary is greater than the average salary of the sales department.

-- 4. Write a query to find the first name and job title of employees who have held more
--    than one job position within the company. Additionally, calculate the difference in
--    years between the start date of their first and last job positions.
