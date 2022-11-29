/*Create statements practice questions */


/* Write a SQL statement to create a simple table countries including columns country_id,
country_name and region_id.*/

Create table countries1 (
country_id varchar (255) not null,
country_name varchar (255), 
region_id varchar (255)
);

select * from countries1;
drop table countries1;

/*Write a SQL statement to create a table countries set a constraint NULL.*/

Create table countries1 (
country_id varchar (255) not null,
country_name varchar (255) not null, 
region_id varchar (255) not null
);

select * from countries1;
drop table countries1;

/*Write a SQL statement to create a table named jobs including columns job_id, job_title, min_salary, max_salary and check whether the max_salary amount exceeding the upper limit 25000.*/

Create table jobs1 (
job_id varchar (255) not null primary key,
job_title varchar (255), 
min_salary varchar (255),
max_salary varchar (255),
check (max_salary<=25000)
);

insert into jobs1 values('5','Software eng','2000','24000');
insert into jobs1 values('6','Software eng','2000','26000');

select * from jobs1;
drop table jobs1;

/*Write a SQL statement to create a table named countries including columns country_id, country_name and region_id and make sure that no countries except Italy, India and China will be entered in the table.*/

Create table countries1 (
country_id varchar (255) not null,
country_name varchar (255),
region_id varchar (255),
check (country_name IN ('India', 'Italy', 'China'))
);

select * from countries1;
drop table countries1;

/*Write a SQL statement to create a table named countries including columns country_id,country_name and region_id and make sure that no duplicate data against column country_id will be allowed at the time of insertion.*/

Create table countries1 (
country_id varchar (255) not null primary key,
country_name varchar (255),  
region_id varchar (255)
);

select * from countries1;
drop table countries1;

/*Write a SQL statement to create a table named jobs including columns job_id, job_title, min_salary and max_salary, and make sure that, the default value for job_title is blank and min_salary is 8000 and max_salary is NULL will be entered automatically at the time of insertion if no value assigned for the specified columns.*/

Create table jobs1 (
job_id varchar (255) not null primary key,
job_title varchar (255) default '', 
min_salary varchar (255) default '8000',
max_salary varchar (255) default 'null'
);

select * from jobs1;
drop table jobs1;

/* Write a SQL statement to create a table named countries including columns country_id, country_name and region_id and make sure that the country_id column will be a key field which will not contain any duplicate data at the time of insertion.*/

Create table countries1 (
country_id varchar (255) not null primary key,
country_name varchar (255),  
region_id varchar (255)
);

drop table countries1;

/*Write a SQL statement to create a table countries including columns country_id, country_name and region_id and make sure that the column country_id will be unique and store an auto incremented value.*/

Create table countries1 (
country_id int not null primary key identity (1,1),
country_name varchar (255),  
region_id varchar (255)
);
drop table countries1;

/* Write a SQL statement to create a table countries including columns country_id, country_name and region_id and make sure that the combination of columns country_id and region_id will be unique.*/ 

Create table countries1 (
country_id varchar (255) not null unique,
country_name varchar (255),  
region_id varchar (255) ,
primary key (country_id, region_id)
);
drop table countries1;

/*Write a SQL statement to create a table job_history including columns employee_id, start_date, end_date, job_id and department_id and make sure that, the employee_id column does not contain any duplicate value at the time of insertion and the foreign key column job_id contain only those values which are exists in the jobs table.*/ 

Create table job_history1 (
employee_id varchar (255) not null primary key,
start_date varchar (255),  
end_date varchar (255) ,
department_id varchar (255),
job_id varchar (255) foreign key references jobs1(job_id)
);
