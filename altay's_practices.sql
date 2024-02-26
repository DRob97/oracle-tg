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
--------------------------------------------------------------------------------
-- 1. Find the total number of locations where the postal code is 5 digits and
--    starts with a 9.
select postal_code from locations
where postal_code like '9____';

-- 2. Find the average last name length per department, and display only two
--    digits after the decimal point.
select department_id, round(avg(length(last_name)), 2) from employees
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

-- 5. Find the maximum commission percentage for each department. Only include
--    departments where the total salary is less than 80,000. Order the result by
--    the average salary in descending order.
select max(commission_pct), department_id from employees
group by department_id
having sum(salary) < 80000
order by avg(salary) desc;
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 1. Write the query to the print country name, country id, and region name for
--    each country.
select c.country_name, c.country_id, r.region_name
from countries c
join regions r
on c.region_id = r.region_id;
-- 2. Write the query to print the last name, email, and job title for each employee.
select e.last_name, e.email, j.job_title
from employees e
join jobs j
on e.job_id = j.job_id;
--------------------------------------------------------------------------------
-- 1. Generate a query to display the first name, last name, and job title of employees
--    who earn a salary greater than the average salary of employees in the 'Finance' department.
select e.first_name, e.last_name, j.job_title
from employees e
join jobs j
on e.job_id = j.job_id
where salary > (select avg(salary)
                from employees a
                join departments b
                on a.department_id = b.department_id
                where department_name = 'Finance');

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
select e.first_name || ' ' || e.last_name as "Employee Name", e.hire_date as "Start Date", h.end_date as "End Date", j.job_title as "Job Title"
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
--------------------------------------------------------------------------------
-- Generate a query to list all departments along with the total number of employees
-- and the average salary of employees in each department. Only include departments
-- where the average salary is greater than the average salary of the sales department.
select count(e.first_name), round(avg(e.salary), 2), d.department_name
from employees e
join departments d
on e.department_id = d.department_id
group by department_name
having avg(e.salary) > (select avg(e.salary)
                        from employees e
                        join departments d
                        on e.department_id = d.department_id
                        where department_name = 'Sales');

-- Write a query to find the first name and job title of employees who have held
-- more than one job position within the company. Additionally, calculate the difference
-- in years between the start date of their first and last job positions.
select e.first_name, j.job_title
from employees e
join jobs j
on e.job_id = j.job_id
join job_history h
on e.employee_id = h.employee_id
;