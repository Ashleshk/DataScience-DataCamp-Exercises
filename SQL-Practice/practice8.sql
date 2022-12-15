/*Joins practice*/

/*Write a query to find the addresses (location_id, street_address, city, state_province, country_name) of all the departments. */
select * from locations;
select * from countries;

select location_id, street_address, city, state_province, country_name from locations 
inner join countries On locations.COUNTRY_ID= countries.COUNTRY_ID;

/*Write a query to find the name (first_name, last name), department name and name of all the employees*/
select * from employees;
select * from departments;

select first_name, last_name,department_name from employees inner join departments On employees.DEPARTMENT_ID= departments.DEPARTMENT_ID;

/*Write a query to find the name (first_name, last_name), job, department ID and name of the employees who works in London.*/

select * from employees;
select * from departments;
select * from locations;

select e.first_name, e.last_name,e.job_id, d.department_id, d.department_name
from employees e
inner join departments d
on e.department_id= d.department_id
inner join locations as l
on d.location_id= l.location_id 
where l.city='london';

/* Write a query to find the employee id, name (last_name) along with their manager_id and name (last_name)*/

select a.employee_id as 'Emp_Id', a.last_name as 'Emp_name', b.manager_id as 'ManagerID', b.last_name as 'Manager_Name'
from employees a join employees b
ON a.manager_id= b.employee_id; 

/*Write a query to find the name (first_name, last_name) and hire date of the employees who was hired after 'Jones'*/

select e1.first_name, e1.last_name, e1.hire_date
from employees as e1 join employees as e2
on e2.last_name='jones'
and e1.hire_date > e2.hire_date ;

/*Write a query to get the department name and number of employees in the department*/

select * from employees;
select * from departments;

select department_name as 'Department Name', count(*) as 'Number of Employees' from departments 
inner join employees on employees.DEPARTMENT_ID= departments.DEPARTMENT_ID
group by departments.department_id, department_name
order by department_name;

/*Write a query to find the employee ID, job title, number of days between ending date and starting date for all jobs in department 90.*/

select jh.employee_id, j.job_title,  DATEDIFF(DAY, jh.START_DATE,jh.END_DATE) as 'difference'
from jobs as j inner join job_history as jh
on j.JOB_ID=jh.JOB_ID
where jh.DEPARTMENT_ID= '90';

/*Write a query to display the department ID and first name of manager.*/

select d.department_id, d.department_name, d.manager_id, e.first_name as 'first name of manager'
from departments as d  inner join employees as e
on d.manager_id= e.employee_id;

/*Write a query to display the department name, manager name, and city*/

select department_name, manager_id, city from
departments inner join locations 
on departments.LOCATION_ID= locations.LOCATION_ID;

/*Write a query to display the job title and average salary of employees.*/

select j.JOB_TITLE, avg(e.salary) as 'average salary'
from employees as e 
inner join jobs as j 
on e.JOB_ID= j.JOB_ID
group by j.JOB_TITLE;

/* Write a query to display job title, employee name, and the difference between salary of the employee and minimum salary for the job*/

select j.job_title, e.first_name, (e.salary-j.MIN_SALARY) as 'difference'
from employees e
inner join jobs j
on e.JOB_ID= j.JOB_ID;

/*Write a query to display the job history that were done by any employee who is currently drawing more than 10000 of salary.*/

select jh.*, e.salary
from employees e
inner join job_history jh
on e.EMPLOYEE_ID= jh.EMPLOYEE_ID
where SALARY> 10000;

/*Write a query to display department name, name (first_name, last_name), hire date, salary of the manager for all managers whose experience is more than 15 years*/

select d.department_name, e.first_name, e.last_name, e.hire_date, e.SALARY, DATEDIFF(year,HIRE_DATE,getdate()) as experience
from employees e 
inner join departments d
on e.EMPLOYEE_ID=d.manager_id
where DATEDIFF(year,HIRE_DATE,getdate())>15

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

 /*Write a query in SQL to display the first name, last name, department number, and department name for each employee*/

select e.first_name, e.last_name, d.department_id, d.department_name
from employees as e inner join departments d
on e.department_id= d.department_id;

/* Write a query in SQL to display the first and last name, department, city, and state province for each employee*/

select e.first_name, e.last_name, d.department_name, l.city, l.state_province
from employees as e inner join departments d
on e.department_id= d.department_id
inner join locations as l
on l.location_id= d.location_id;

/*Write a query in SQL to display the first name, last name, salary, and job grade for all employees.*/

select e.first_name, e.last_name,e.salary, jg.grade_level 
from employees as e inner join job_grades jg
on e.salary between jg.lowest_sal and jg.highest_sal;

/*Write a query in SQL to display the first name, last name, department number and department name, for all employees for departments 80 or 40. */

select e.first_name, e.last_name, d.department_id, d.department_name
from employees as e inner join departments d
on e.department_id= d.department_id
where e.department_id= '80' or e.department_id= '40'

/*Write a query in SQL to display those employees who contain a letter z to their first name and also display their last name, department, city, and state province.*/

select e.first_name, e.last_name, d.department_name, l.city, l.state_province
from employees as e inner join departments d
on e.department_id= d.department_id
inner join locations as l
on l.location_id= d.location_id
where e.first_name like '%z%';

/* Write a query in SQL to display all departments including those where does not have any employee.*/

select d.department_id,d.department_name, e.first_name, e.last_name
from departments as d right outer join employees as e
on d.department_id= e.department_id;

/*Write a query in SQL to display the first and last name and salary for those employees who earn less than the employee earn whose number is 182.*/

select e1.first_name, e1.last_name, e1.salary 
from employees as e1 join employees e2
on e1.salary<e2.salary
and e2.EMPLOYEE_ID= 182;

/* Write a query in SQL to display the first name of all employees including the first name of their manager.*/

select e1.first_name as 'employee name', e2.first_name as 'manager name'
from employees as e1 join employees as e2
on e1.EMPLOYEE_ID = e2.MANAGER_ID;

/* Write a query in SQL to display the department name, city, and state province for each department. */

select d.department_name, l.city,l.state_province
from departments as d inner join locations as l
on d.location_id= l.location_id;

/*Write a query in SQL to display the first name, last name, department number and name, for all employees who have or have not any department.*/

select e.first_name, e.last_name, d.department_id
from employees as e left outer join departments as d on d.department_id = e.department_id;

/*Write a query in SQL to display the first name of all employees and the first name of their manager including those who does not working under any manager. */

select e1.first_name as 'employee name', e2.first_name as 'manager name'
from employees as e1 left outer join employees as e2
on e1.manager_id = e2.employee_id;

/*Write a query in SQL to display the first name, last name, and department number for those employees who works in the same department as the employee who holds the last name as Taylor*/

select e1.first_name, e1.last_name, e1.department_id
from employees as e1 join employees as e2
on e1.department_id= e2.department_id
and e2.last_name = 'taylor';

/*Write a query in SQL to display the job title, department name, full name (first and last name ) of employee, and starting date for all the jobs which started on or after 1st January, 1993 and ending with on or before 31 August, 1997*/

select j.job_title, d.department_name, e.first_name, e.last_name, jh.start_date, jh.end_date
from employees as e inner join jobs as j
on e.JOB_ID= j.JOB_ID
inner join job_history as jh
on j.JOB_ID=jh.JOB_ID
inner join departments as d
on d.DEPARTMENT_ID= jh.DEPARTMENT_ID
where START_DATE <= '1993-01-01' and END_DATE <= '1997-08-31'

/*Write a query in SQL to display job title, full name (first and last name ) of employee, and the difference between maximum salary for the job and salary of the employee. */

select  concat(e.first_name ,' ' , e.last_name) as 'employee name', j.job_title, 
(j.max_salary- j.min_salary) as ' salary difference'
from employees as e inner join jobs as j 
on e.job_id= j.job_id;

/* Write a query in SQL to display the name of the department, average salary and number of employees working in that department who got commission.*/

select d.department_name, avg (e.salary) as 'average salary', count(e.COMMISSION_PCT) as 'count'
from employees as e inner join departments as d
on e.department_id = d.department_id
group by d.department_name;

/*Write a query in SQL to display the full name (first and last name ) of employees, job title and the salary differences to their own job for those employees who is working in the department ID 80*/

select concat(e.first_name ,' ' , e.last_name) as 'employee name', j.job_title, 
(j.max_salary - e.salary) as ' salary difference'
from employees as e inner join jobs as j 
on e.job_id= j.job_id
where e.department_id = 80;

/*Write a query in SQL to display the name of the country, city, and the departments which are running there*/

select c.country_name, l.city, d.department_name 
from countries as c inner join locations as l 
on c.country_id = l.country_id
inner join departments as d 
on l.LOCATION_ID= d.LOCATION_ID;

/* Write a query in SQL to display department name and the full name (first and last name) of the manager*/

select concat(e.first_name ,' ' , e.last_name) as 'Manager name', d.department_name
from employees as e join departments as d
on d.manager_id = e.employee_id;

/*Write a query in SQL to display job title and average salary of employees.*/

select j.job_title, avg (e.salary) as 'Average Salary'
from employees as e inner join jobs as j 
on e.job_id= j.job_id
group by j.job_title;

/*Write a query in SQL to display the details of jobs which was done by any of the employees who is presently earning a salary on and above 12000. */

select jh.* 
from job_history as jh inner join employees as e on jh.employee_id = e.employee_id
where e.salary >= 12000;

/*Write a query in SQL to display the country name, city, and number of those departments where at leaste 2 employees are working.*/





/*Write a query in SQL to display the department name, full name (first and last name) of manager, and their city*/

select d.department_name, concat(e.first_name ,' ' , e.last_name) as 'Manager name', l.city
from employees as e  join departments as d 
on e.employee_id= d.manager_id
 join locations as l 
 on l.location_id=d.location_id;

 /* Write a query in SQL to display the employee ID, job name, number of days worked in for all those jobs in department 80.*/

 select jh.employee_id, j.job_title, DATEDIFF(DAY, jh.start_date,jh.end_date) as 'Number of days worked'
 from job_history as jh inner join jobs as j
 on jh.job_id=j.job_id
 where jh.department_id = 80;

 /*Write a query in SQL to display the full name (first and last name), and salary of those employees who working in any department located in London. */

 select concat(e.first_name, ' ', e.last_name) as 'Name', e.salary
 from locations as l inner join departments as d
 on l.location_id = d.location_id
 inner join employees as e 
 on d.department_id= e.department_id
 where l.city= 'london';

 /*Write a query in SQL to display full name(first and last name), job title, starting and ending date of last jobs for those employees with worked without a commission percentage.*/

select concat(e.first_name, ' ', e.last_name) as 'Name', j.job_title, jh.start_date, jh.end_date
from employees as e inner join job_history as jh
on e.employee_id= jh.employee_id
inner join jobs as j 
on j.job_id= jh.job_id`
where commission_pct= '0'  

/*Write a query in SQL to display the department name and number of employees in each of the department. */

select d.department_name, count(e.employee_id) as 'Number of employees'
from employees as e inner join departments as d
on e.department_id= d.department_id
group by d.department_name;

/*Write a query in SQL to display the full name (firt and last name ) of employee with ID and name of the country presently where (s)he is working*/

select CONCAT (e.first_name,' ', e.last_name) as 'Full Name', e.employee_id, c.country_name 
from  employees as e inner join departments as d 
on e.department_id= d.department_id 
inner join locations as l 
on d.location_id = l.location_id 
inner join countries as c 
on l.country_id= c.country_id; 


