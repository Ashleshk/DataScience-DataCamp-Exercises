/*select statement with string functions practice questions*/

/*Write a query to display the names (first_name, last_name) using alias name “First Name", "Last Name"*/
 
 select * from employees;

select first_name as 'First Name',
last_name as 'Last Name' 
from employees;

/* Write a query to get unique department ID from employee table.Go to the editor */

select distinct(department_id) from employees;

/*Write a query to get all employee details from the employee table order by first name, descending*/

select * from employees 
order by first_name desc;

/*Write a query to get the names (first_name, last_name), salary, PF of all the employees (PF is calculated as 15% of salary)*/

select first_name, last_name, salary,salary * 0.15 as pf
from employees;

/*Write a query to get the employee ID, names (first_name, last_name), salary in ascending order of salary*/
select employee_id, first_name, last_name, salary
from employees
order by salary;

/*Write a query to get the total salaries payable to employees*/
select sum(salary) as 'Total salary' from employees;

/*Write a query to get the maximum and minimum salary from employees table.Go to the editor*/

select min(salary) as 'Minimum salary',
max(salary) as 'Maximum salary' from employees;

/*Write a query to get the average salary and number of employees in the employees table*/

select avg(salary) as 'average salary', count(employee_id) as 'number of employees'
from employees;

/*Write a query to get the number of employees working with the company.*/
select count(employee_id) as 'number of employees' from employees;

/*Write a query to get the number of jobs available in the employees table.*/
select count(distinct job_id) as 'number of jobs' from employees;

/*Write a query get all first name from employees table in upper case*/
select upper(first_name) as 'Upper Case First Name' from employees;

 /*Write a query to get the first 3 characters of first name from employees table.*/
 select left(first_name,3) as 'extracted string' from employees;

 /*Write a query to calculate 171*214+625.*/
 select 171*214+625 as total;

 /*Write a query to get the names (for example Ellen Abel, Sundar Ande etc.) of all the employees from employees table*/

  select CONCAT (first_name,' ', last_name) as 'Employee name ' from employees;

  /*Write a query to get first name from employees table after removing white spaces from both side.*/
  select trim(first_name) as 'trimmed string' from employees;

  /*Write a query to get the length of the employee names (first_name, last_name) from employees table*/
  select first_name, last_name, len(first_name)+len(last_name) as'Length of  Names' 
  from employees;

  /* Write a query to check if the first_name fields of the employees table contains numbers*/


  /*Write a query to select first 10 records from a table.*/
  select top  10 * from employees ;
