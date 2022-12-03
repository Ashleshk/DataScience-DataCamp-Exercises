/*Aggregate functions practice*/

 select * from employees;

 /*Write a query to list the number of jobs available in the employees table.*/
 select count(distinct JOB_ID) from employees;
  
/*Write a query to get the total salaries payable to employees.*/
select sum(salary) as 'Total Salary' from employees;

/*Write a query to get the minimum salary from employees table.*/
select min(salary) as 'Minimum Salary' from employees;

/* Write a query to get the maximum salary of an employee working as a Programmer.*/
select max(salary) from employees 
where JOB_ID='IT_PROG';

/*Write a query to get the average salary and number of employees working the department 90. */
select avg(salary) as 'average salary', count(job_id) as 'count of employees' from employees
where department_id= 90;

/*Write a query to get the highest, lowest, sum, and average salary of all employees.*/
select max(salary) as 'maximum salary',
min(salary) as 'minimum salary',
sum(salary) as 'total salary',
avg(salary) as 'average salary' from employees;

/*Write a query to get the number of employees with the same job.*/
select JOB_ID, count(*) as 'count' from employees
group by JOB_ID;

/* Write a query to get the difference between the highest and lowest salaries.*/
select max(salary)- min(salary) from employees;

/*Write a query to find the manager ID and the salary of the lowest-paid employee for that manager*/ 
 select manager_id, min(salary) from employees
 group by manager_id 
 order by min(salary); 

 /* Write a query to get the department ID and the total salary payable in each department.*/
 select department_id, sum(salary) from employees
 group by department_id;

 /*Write a query to get the average salary for each job ID excluding programmer*/
 select job_id, avg(salary) from employees
 where job_id <> 'IT_PROG'
 group by job_id;

 /*Write a query to get the total salary, maximum, minimum, average salary of employees (job ID wise), for department ID 90 only.*/

select job_id,max(salary) as 'maximum salary',
min(salary) as 'minimum salary',
sum(salary) as 'total salary',
avg(salary) as 'average salary' from employees
where department_id ='90'
group by job_id;

/*Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000*/

select job_id, max(salary) from employees 
group by job_id
having max(salary)>= 4000;

/*Write a query to get the average salary for all departments employing more than 10 employees.*/

select department_id, avg(salary), count(*) from employees
group by department_id
having count(*)>10;

	