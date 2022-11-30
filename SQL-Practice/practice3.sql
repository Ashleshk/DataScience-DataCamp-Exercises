/*Update statements practice questions*/

/* Write a SQL statement to change the email column of employees table with 'not available' for all employees.*/

select * from employees;

Use practice
update  employees set email= 'not available';

/*Write a SQL statement to change the email and commission_pct column of employees table with 'no available' and 0.10 for all employees.*/

update  employees set email= 'not available', commission_pct= '0.10';

/* Write a SQL statement to change the email and commission_pct column of employees table with 'not available' and 0.10 for those employees whose department_id is 110.*/

update  employees set email= 'not available', commission_pct= '0.10'
where department_id = 110;

/*Write a SQL statement to change the email column of employees table with 'not available' for those employees whose department_id is 80 and gets a commission is less than .20%*/

update employees set email= 'not available' 
where department_id = 80 and commission_pct= 0.20;

/* Write a SQL statement to change the email column of employees table with 'not available' for those employees who belongs to the 'Accouning' department.*/

update employees set email= 'not available'
where department_id = (select department_ID from departments where department_name = 'accounting' );

/* Write a SQL statement to change salary of employee to 8000 whose ID is 105, if the existing salary is less than 5000.*/

update employees set salary = 8000
where employee_id= 105 and salary<5000;

/*Write a SQL statement to change job ID of employee which ID is 118, to SH_CLERK if the employee belongs to department, which ID is 30 and the existing job ID does not start with SH.*/

update employees set job_id = 'SH_CLERK'
where employee_id = 118 and department_id =30 and not job_id like 'sh%';

