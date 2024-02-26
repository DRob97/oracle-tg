-- 1. Write a query to display the employee id, employee name (first name and
--    last name) for all employees who earn more than the average salary.
select employee_id, first_name || ' ' || last_name as "employee name"
from employees
where salary > (select avg(salary)
                from employees);
-- 2. Write a query to display the employee name (first name and last name),
--    employee id, and salary of all employees who report to Payam.
select first_name || ' ' || last_name as "employee name", employee_id, salary
from employees
where manager_id = (select employee_id
                    from employees
                    where first_name = 'Payam');

-- 3. Write a query to display the department number, name (first name and last
--    name), job_id and department name for all employees in the Finance department.
select e.first_name, e.last_name, d.department_id, e.job_id, d.department_name
from employees e
join departments d
on e.department_id = d.department_id
where e.department_id = (select department_id
                         from departments
                         where department_name = 'Finance');

-- 4. Write a query to display all the information of the employees whose salary
--    is within the range of the smallest salary and 2500.
select *
from employees
where salary between (select min(salary) from employees) and 2500;

-- 5. Write a SQL query to find the first name, last name, department, city, and
--    state province for each employee.
select e.first_name, e.last_name, d.department_name, l.city, l.state_province
from employees e
left join departments d
on e.department_id = d.department_id
left join locations l
on d.location_id = l.location_id;

-- 6. Write a SQL query to find all those employees who work in department ID 80
--    or 40. Return first name, last name, department number, and department name.
select e.first_name, e.last_name, e.department_id, d.department_name
from employees e
join departments d
on e.department_id = d.department_id
where e.department_id = 40
or e.department_id = 80;

-- 7. Write a query to display the employee name (first name and last name) and
--    hire date for all employees in the same department as Clara. Exclude Clara.
select first_name, last_name, hire_date
from employees
where department_id = (select department_id
                       from employees
                       where first_name = 'Clara')
and first_name != 'Clara';

-- 8. Write a query to display the employee number, name (first name and last name),
--    and salary for all employees who earn more than the average salary and who
--    work in a department with any employee with a J in their name.
select employee_id, first_name, last_name, salary
from employees
where salary > (select avg(salary)
                from employees)
and department_id in (select department_id
                     from employees
                     where first_name like '%J%'
                     or last_name like '%J%'
                     group by department_id);

-- 9. Write a SQL query to find those employees whose first name contains the letter
--    ‘z’. Return first name, last name, department, city, and state province.
select e.first_name, e.last_name, d.department_name, l.city, l.state_province
from employees e
left join departments d
on e.department_id = d.department_id
left join locations l
on d.location_id = l.location_id
where e.first_name like '%z%';

-- 10. Write a SQL query to find all departments, including those without employees.
--     Return first name, last name, department ID, department name.
select e.first_name, e.last_name, d.department_id, d.department_name
from employees e
right join departments d
on e.department_id = d.department_id;

-- 11. Write a query to display the employee number, name (first name and last name)
--     and job title for all employees whose salary is smaller than any salary of
--     those employees whose job title is MK_MAN.
select e.employee_id, e.first_name, e.last_name, j.job_title
from employees e
join jobs j
on e.job_id = j.job_id
where salary < (select min(salary)
                from employees
                where job_id = 'MK_MAN');

-- 12. Write a query to display the employee number, name (first name and last
--     name) and job title for all employees whose salary is more than any salary
--     of those employees whose job title is PU_MAN. Exclude job title PU_MAN.
select e.employee_id, e.first_name, e.last_name, j.job_title
from employees e
join jobs j
on e.job_id = j.job_id
where salary > (select max(salary)
                from employees
                where job_id = 'PU_MAN');

-- 13. Write a query to display the employee number, name (first name and last
--     name) and job title for all employees whose salary is more than any average
--     salary of any department.
select e.employee_id, e.first_name, e.last_name, j.job_title
from employees e
join jobs j
on e.job_id = j.job_id
where salary > (select min(avg(salary))
                from employees
                group by department_id); 

-- 14. Write a query to display the department id and the total salary for those
--     departments which contains at least one employee.
select department_id, sum(salary)
from employees
group by department_id
having count(employee_id) > 0;

-- 15. Write a SQL query to find the employees who earn less than the employee of
--     ID 182. Return first name, last name and salary.
select first_name, last_name, salary
from employees
where salary < (select salary
                from employees
                where employee_id = 182);

-- 16. Write a SQL query to find the employees and their managers. Return the first
--     name of the employee and manager.
select e.first_name as "Employee", m.first_name as "Manager"
from employees e
join employees m
on e.manager_id = m.employee_id;

-- 17. Write a SQL query to display the department name, city, and state province
--     for each department.
select d.department_name, l.city, l.state_province
from departments d
join locations l
on d.location_id = l.location_id;

-- 18. Write a query to identify all the employees who earn more than the average
--     and who work in any of the IT departments.
select e.employee_id, e.first_name
from employees e
join departments d
on e.department_id = d.department_id
where department_name like '%IT%';

-- 19. Write a SQL query to find out which employees have or do not have a department.
--     Return first name, last name, department ID, department name.
select e.first_name, e.last_name, e.department_id, d.department_name
from employees e
left join departments d
on e.department_id = d.department_id;

-- 20. Write a SQL query to find the employees and their managers. Those managers
--     do not work under any manager also appear in the list. Return the first name
--     of the employee and manager.
select e.first_name as "Employee", m.first_name as "Manager"
from employees e
left join employees m
on e.manager_id = m.employee_id;

-- 21. Write a query to display the name (first name and last name) for those employees
--     who gets more salary than the employee whose ID is 163.
select first_name, last_name
from employees
where salary > (select salary
                from employees
                where employee_id = 163);

-- 22. Write a query to display the name (first name and last name), salary, department
--     id, job id for those employees who works in the same designation as the employee
--     works whose id is 169.
select first_name, last_name, salary, department_id, job_id
from employees
where department_id = (select department_id
                        from employees
                        where employee_id = 169);

-- 23. Write a SQL query to find the employees who work in the same department as
--     the employee with the last name Taylor. Return first name, last name and
--     department ID.
select first_name, last_name, department_id
from employees
where department_id in (select department_id
                        from employees
                        where last_name = 'Taylor'
                        group by department_id);

-- 24. Write a SQL query to find the department name and the full name (first and
--     last name) of the manager.
select d.department_name, m.first_name, m.last_name
from employees e
join employees m
on e.manager_id = m.employee_id
join departments d
on m.department_id = d.department_id;

-- 25. Write a SQL query to find the employees who earn $12000 or more. Return
--     employee ID, starting date, end date, job ID and department ID.
select e.employee_id, h.start_date, h.end_date, e.job_id, e.department_id
from employees e
left join job_history h
on e.employee_id = h.employee_id
where salary > 12000;

-- 26. Write a query to display the name (first name and last name), salary, department
--     id for those employees who earn such amount of salary which is the smallest
--     salary of any of the departments.
select first_name, last_name, salary, department_id
from employees
where salary in (select min(salary)
                from employees
                group by department_id);
-- 27. Write a query to display all the information of an employee whose salary
--     and reporting person id is 3000 and 121, respectively.
select *
from employees
where salary = 3000
and manager_id = 121;

-- 28. Display the employee name (first name and last name), employee id, and job
--     title for all employees whose department location is Toronto.
select e.first_name, e.last_name, e.employee_id, j.job_title
from employees e
join jobs j
on e.job_id = j.job_id
join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
where l.city = 'Toronto';

-- 29. Write a query to display the employee name( first name and last name ) and
--     department for all employees for any existence of those employees whose
--     salary is more than 3700.
select first_name, last_name, department_id
from employees
where salary > 3700;

-- 30. Write a query to determine who earns more than employee with the last name
--     'Russell'.
select *
from employees
where salary > (select salary
                from employees
                where last_name = 'Russell');

-- 31. Write a query to display the names of employees who dont have a manager.
select first_name, last_name
from employees
where manager_id is null;

-- 32. Write a query to display the names of the departments and the number of
--     employees in each department.
select d.department_name, count(e.employee_id)
from departments d
join employees e
on d.department_id = e.department_id
group by d.department_name;

-- 33. Write a query to display the last name of employees and the city where they
--     are located.
select e.last_name, l.city
from employees e
join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

-- 34. Write a query to display the job titles and the average salary of employees
--     for each job title.
select j.job_title, avg(e.salary)
from jobs j
join employees e
on j.job_id = e.job_id
group by j.job_title;

-- 35. Write a query to display the employees name, department name, and the city
--     of the department.
select e.first_name, d.department_name, l.city
from employees e
join departments d
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id;

-- 36. Write a query to display the names of employees who do not have a department
--     assigned to them.
select first_name, last_name
from employees
where department_id is null;

-- 37. Write a query to display the names of all departments and the number of
--     employees in them, even if there are no employees in the department.
select d.department_name, count(e.employee_id)
from departments d
left join employees e
on d.department_id = e.department_id
group by d.department_name;

-- 38. Write a query to display the names of employees and the department names,
--     but only include employees whose salary is above 10,000.
select e.first_name, e.last_name, d.department_name
from employees e
join departments d
on e.department_id = d.department_id
where salary > 10000;

-- 39. Write a query to display department names and the average salary within each
--     department, but only for departments with an average salary above 7000.
select d.department_name, round(avg(e.salary))
from departments d
join employees e
on d.department_id = e.department_id
group by d.department_name
having avg(e.salary) > 7000;

-- 40. Write a query to display the names of employees who work in the 'IT' department.
select e.first_name, e.last_name
from employees e
join departments d
on e.department_id = d.department_id
where d.department_name = 'IT';

-- 41. Write a query which is looking for the names of all employees whose salary
--     is greater than 50% of their department’s total salary bill.
select e.first_name, e.last_name
from employees e
where salary > (select (sum(salary/2))
                from employees f
                where f.department_id = e.department_id
                group by f.department_id);
                
-- 42. Write a query to get the details of employees who are managers.
select *
from employees
where employee_id in (select manager_id
                        from employees
                        group by manager_id);

-- 43. Write a query in SQL to display the department code and name for all
--     departments which located in the city London.
select d.department_id, d.department_name
from departments d
join locations l
on d.location_id = l.location_id
where l.city = 'London';

-- 44. Write a query in SQL to display the first and last name, salary, and department
--     ID for all those employees who earn more than the average salary and arrange
--     the list in descending order on salary.
select first_name, last_name, salary, department_id
from employees
where salary > (select avg(salary)
                from employees)
order by salary desc;

-- 45. Write a query in SQL to display the first and last name, salary, and department
--     ID for those employees who earn more than the maximum salary of a department
--     which ID is 40.
select first_name, last_name, salary, department_id
from employees
where salary > (select max(salary)
                from employees
                where department_id = 40);

-- 46. Write a query in SQL to display the department name and Id for all departments
--     located where department number 30 is located.
select department_name, department_id
from departments
where location_id = (select location_id
                    from departments
                    where department_id = 30);

-- 47. Write a query in SQL to display the details of departments managed by Susan.
select d.*
from departments d
join employees e
on d.manager_id = e.employee_id
where e.first_name = 'Susan';

-- 48. Write a query to display the department names and the location cities.
--     Only include departments that are located in a country with the country_id 'US'.
select d.department_name, l.city
from departments d
join locations l
on d.location_id = l.location_id
where l.country_id = 'US';

-- 49. Write a query to display the first name and last name of employees along
--     with the name of the department they work in. Only include employees whose
--     last name starts with the letter 'S'.
select e.first_name, e.last_name, d.department_name
from employees e
join departments d
on e.department_id = d.department_id
where e.last_name like 'S%';

-- 50. Write a query to display the department names and the number of employees
--     in each department. Only include departments with more than 2 employees,
--     and order the result by the number of employees in descending order.
select d.department_name, count(e.employee_id)
from departments d
join employees e
on d.department_id = e.department_id
group by d.department_name
having count(e.employee_id) > 2
order by count(e.employee_id) desc;