/*SORTING and FILTERING practice */

/*Write a query in SQL to display the full name (first and last name), and salary for those employees who earn below 6000.*/

select concat(FIRST_NAME,' ', LAST_NAME) as 'Employee Name', SALARY
from employees
where SALARY<6000;

/*Write a query in SQL to display the first and last_name, department number and salary for those employees who earn more than 8000.*/

select FIRST_NAME, LAST_NAME, DEPARTMENT_ID, SALARY
from employees
where SALARY>8000;

/*Write a query in SQL to display the first and last name, and department number for all employees whose last name is “McEwen*/

select FIRST_NAME,LAST_NAME,DEPARTMENT_ID
from employees
where LAST_NAME= 'McEwen';

/*Write a query in SQL to display all the information for all employees without any department number.*/

select * from employees
where DEPARTMENT_ID= null;

/*Write a query in SQL to display all the information about the department Marketing.*/

select * from departments
where DEPARTMENT_NAME= 'marketing';

/* Write a query in SQL to display the full name (first and last), hire date, salary, and department number for those employees whose first name does not containing the letter M and make the result set in ascending order by department number*/

select CONCAT(FIRST_NAME, '', LAST_NAME) as 'Employee Name', HIRE_DATE, SALARY, DEPARTMENT_ID
from employees
where LAST_NAME not like '%m%'
order by DEPARTMENT_ID

/*Write a query in SQL to display all the information of employees whose salary is in the range of 8000 and 12000 and commission is not null or department number is except the number 40, 120 and 70 and they have been hired before June 5th, 1987.*/

select * from employees
where SALARY between '8000' and '12000' and COMMISSION_PCT is not null or DEPARTMENT_ID  not in (40,120,70) and HIRE_DATE < '1987-06-05';     

/*Write a query in SQL to display the full name (first and last name), and salary for all employees who does not earn any commission.*/

select CONCAT (FIRST_NAME,' ', LAST_NAME) as 'Employee Name', SALARY
from employees
where COMMISSION_PCT=null;

/*Write a query in SQL to display the full name (first and last), the phone number and email separated by hyphen, and salary, for those employees whose salary is within the range of 9000 and 17000. The column headings assign with Full_Name, Contact_Details and Remuneration respectively.*/

select CONCAT(FIRST_NAME,' ', LAST_NAME) as 'Full Name', CONCAT (PHONE_NUMBER,' ' ,'-',EMAIL) as 'Contact Details', SALARY as 'Remuneration'
from employees
where SALARY between 9000 and 17000;

/* Write a query in SQL to display the first and last name, and salary for those employees whose first name is ending with the letter m. */

select FIRST_NAME, LAST_NAME, SALARY
from employees
where FIRST_NAME like '%m';

/**Write a query in SQL to display the full name (first and last) name, and salary, for all employees whose salary is out of the range 7000 and 15000 and make the result set in ascending order by the full name.*/

select CONCAT(FIRST_NAME,' ', LAST_NAME) as 'Employee Name', SALARY
from employees
where SALARY not between 7000 and 15000 
order by [Employee Name];

/*Write a query in SQL to display the full name (first and last), job id and date of hire for those employees who was hired during November 5th, 2007 and July 5th, 2009.*/

select CONCAT(FIRST_NAME,' ', LAST_NAME) as 'Employee Name', JOB_ID, HIRE_DATE
from employees
where HIRE_DATE between '11-05-2007' and '07-05-2009';

/*Write a query in SQL to display the the full name (first and last name), and department number for those employees who works either in department 70 or 90. */

select CONCAT(FIRST_NAME,' ', LAST_NAME) as 'Employee Name', DEPARTMENT_ID
from employees
where DEPARTMENT_ID = '70' or DEPARTMENT_ID = '90';

/*Write a query in SQL to display the full name (first and last name), salary, and manager number for those employees who is working under a manager */

select CONCAT(FIRST_NAME,' ', LAST_NAME) as 'Employee Name', DEPARTMENT_ID, MANAGER_ID
from employees
where MANAGER_ID is not null;

/* Write a query in SQL to display all the information from Employees table for those employees who was hired before June 21st, 2002.*/

select * from employees 
where HIRE_DATE< '2002-06-21';

/*Write a query in SQL to display the first and last name, email, salary and manager ID, for those employees whose managers are hold the ID 120, 103 or 145. */

select FIRST_NAME,LAST_NAME, EMAIL, SALARY, MANAGER_ID
from employees
where MANAGER_ID in (120,103,145);

/*Write a query in SQL to display all the information for all employees who have the letters D, S, or N in their first name and also arrange the result in descending order by salary. */

select * from employees
where FIRST_NAME like '%d%' or FIRST_NAME like '%s%' or FIRST_NAME like '%n%'
order by SALARY desc;

/*Write a query in SQL to display the full name (first name and last name), hire date, commission percentage, email and telephone separated by '-', and salary for those employees who earn the salary above 11000 or the seventh character in their phone number equals 3 and make the result set in a descending order by the first name. */

select CONCAT(FIRST_NAME,' ', LAST_NAME) as 'Employee Name', HIRE_DATE, COMMISSION_PCT, SALARY,
 CONCAT (PHONE_NUMBER,' ' ,'-',EMAIL) as 'Contact Details'
from employees
where SALARY>11000  or PHONE_NUMBER like '______3%'
order by FIRST_NAME desc;

/* Write a query in SQL to display the first and last name, and department number for those employees who holds a letter s as a 3rd character in their first name.*/

select FIRST_NAME, LAST_NAME, DEPARTMENT_ID
from employees
where FIRST_NAME like '__s%';

/*Write a query in SQL to display the employee ID, first name, job id, and department number for those employees who is working except the 
departments 50,30 and 80.*/

select EMPLOYEE_ID, FIRST_NAME, JOB_ID, DEPARTMENT_ID
from employees
where DEPARTMENT_ID not in (30,50,80);

/*Write a query in SQL to display the employee Id, first name, job id, and department number for those employees whose department number equals 30, 40 or 90*/

select EMPLOYEE_ID, FIRST_NAME, LAST_NAME, DEPARTMENT_ID
from employees
where DEPARTMENT_ID in (30,40,90);

/*Write a query in SQL to display the ID for those employees who did two or more jobs in the past*/

select EMPLOYEE_ID
from job_history
group by EMPLOYEE_ID
having COUNT(*)>=2;

/* Write a query in SQL to display job ID, number of employees, sum of salary, and difference between highest salary and lowest salary for a job. */

select JOB_ID, sum(SALARY) as 'Total Salary', COUNT(*) as 'Number of employees', max(SALARY)-Min(SALARY) as 'Salary Difference'
from employees
group by JOB_ID;

/*Write a query in SQL to display job ID for those jobs that were done by two or more for more than 300 days*/

select JOB_ID, count(EMPLOYEE_ID) as 'count'
from job_history
where DATEDIFF(day, START_DATE, END_DATE) > 300 
group by JOB_ID
having COUNT(*)>=2;

/* Write a query in SQL to display the country ID and number of cities in that country we have.*/

select COUNTRY_ID, count(CITY) as 'Number of cities'
from locations 
group by COUNTRY_ID;

/*Write a query in SQL to display the manager ID and number of employees managed by the manager.*/

select MANAGER_ID, count(*)
from employees
group by MANAGER_ID;

/*Write a query in SQL to display the details of jobs in descending sequence on job title.*/

select * from jobs
order by JOB_TITLE desc;

/*Write a query in SQL to display the first and last name and date of joining of the employees who is either Sales Representative or Sales Man.*/

select CONCAT(FIRST_NAME, ' ', LAST_NAME) as 'Employee Name', HIRE_DATE
from employees
where JOB_ID= 'SA_REP' or JOB_ID= 'SA_MAN';

/*Write a query in SQL to display the average salary of employees for each department who gets a commission percentage.*/

select DEPARTMENT_ID , AVG(SALARY)as 'average salary'
from employees
where COMMISSION_PCT is not null 
group by DEPARTMENT_ID;

/*Write a query in SQL to display those departments where any manager is managing 4 or more employees.*/

select distinct DEPARTMENT_ID
from employees 
group by DEPARTMENT_ID
having COUNT(*)>=4; 

/*Write a query in SQL to display those departments where more than ten employees work who got a commission percentage.*/

select distinct DEPARTMENT_ID
from employees 
where COMMISSION_PCT is not null
group by DEPARTMENT_ID
having COUNT(*)>=10;

/* Write a query in SQL to display the employee ID and the date on which he ended his previous job.*/

select EMPLOYEE_ID, END_DATE
from job_history
having MAX(hire)


/*Write a query in SQL to display the details of the employees who have no commission percentage and salary within the range 7000 to 12000 and works in that department which number is 50.  */

select * from employees
where COMMISSION_PCT is null and SALARY between 7000 and 12000
and DEPARTMENT_ID= '50';

/* Write a query in SQL to display the job ID for those jobs which average salary is above 8000. */

select JOB_ID
from employees
group by JOB_ID
having AVG(SALARY)>8000;

/*Write a query in SQL to display job Title, the difference between minimum and maximum salaries for those jobs which max salary within the range 12000 to 18000*/

select JOB_TITLE, (MAX_SALARY-MIN_SALARY) as 'Salary Difference'
from jobs
where MAX_SALARY between 12000 and 18000;

/*Write a query in SQL to display all those employees whose first name or last name starts with the letter D.*/

select FIRST_NAME,LAST_NAME
from employees
where FIRST_NAME like 'D%' or LAST_NAME like 'D%';

/*Write a query in SQL to display the details of jobs which minimum salary is greater than 9000.*/

select * from jobs
where MIN_SALARY>9000;

/* Write a query in SQL to display those employees who joined after 7th September, 1987.*/

select * from employees
where HIRE_DATE > '1987-09-07';