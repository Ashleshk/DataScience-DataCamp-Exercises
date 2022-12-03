/* Insert Rows into table practice questions. */

select * from countries;
select * from regions;

/*Write a SQL statement to insert a record with your own value into the table countries against each columns.*/
insert into countries values ('GR', 'Greece','1');

/* Write a SQL statement to insert one row into the table countries against the column country_id and country_name.*/
insert into countries (COUNTRY_ID, COUNTRY_NAME) values ('PK', 'Pakistan');

/* Write a SQL statement to create duplicate of countries table named country_new with all structure and data*/

select * into from country_new countries;
select * from country_new;
delete from country_new;
drop table country_new;

/*Write a SQL statement to insert NULL values against region_id column for a row of countries table.*/
insert into countries (COUNTRY_ID, COUNTRY_NAME, REGION_ID) values ('BH', 'Bhutan', NULL);

/* Write a SQL statement to insert 3 rows by a single insert statement.*/

insert into countries values ('SL', 'Sri Lanka', '3'), ('TH','Thailand', '3'), ('PL','Poland','1');


/*Write a SQL statement insert rows from country_new table to countries table.*/

select * into country_new from countries;

/* Write a SQL statement to insert one row in jobs table to ensure that no duplicate value will be entered in the job_id column.*/
select * from jobs;
insert into jobs values ('Tech_RC','Tech Recruiter','6000', '9000' );

/*Write a SQL statement to insert rows into the table countries in which the value of country_id column will be unique and auto incremented.*/

create table country_new1 (
country_id int identity(1,1),
country_name varchar(255) default 'N/A',
region_id varchar(255)
);

select * from country_new1;
drop table country_new1;

insert into country_new1 values ('India','1');
insert into country_new1 values ('Germany','2');
insert into country_new1 values ('USA','3');
insert into country_new1 values ('Canada','3');

/* Write a SQL statement to insert records into the table countries to ensure that the country_id column will not contain any duplicate data and this will be automatically incremented and the column country_name will be filled up by 'N/A' if no value assigned for that column.*/

insert into country_new1 (region_id) values ('4');




