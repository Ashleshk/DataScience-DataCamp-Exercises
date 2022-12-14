
set time zone 'UTC';

drop table if exists evanston311;

create table evanston311 (
  id int primary key,
  priority varchar(6),
  source varchar(20),
  category varchar(64),
  date_created timestamp with time zone,
  date_completed timestamp with time zone,
  street varchar(48),
  house_num varchar(12),
  zip char(5),
  description text
);

COPY evanston311
	FROM PROGRAM 'curl "https://assets.datacamp.com/production/repositories/3567/datasets/48ea25f9557bdad445f18055f13903455189359c/ev311.csv"' (DELIMITER ',', FORMAT CSV, HEADER, NULL 'NA');


drop table if exists stackoverflow;
drop table if exists tag_type;
drop table if exists tag_company;
drop table if exists company;
drop table if exists fortune500;

create table company (
  id int primary key,
  exchange varchar(10),
  ticker char(5) unique,
  name varchar not null,
  parent_id int references company(id)
);

create table tag_company (
  tag varchar(30) primary key,
  company_id int references company(id)
);

create table stackoverflow (
   id serial,
   tag varchar(30) references tag_company(tag),
   date date,
   question_count integer default 0,  
   question_pct double precision, 
   unanswered_count integer,
   unanswered_pct double precision
);

create table tag_type (
  id serial,
  tag varchar(30) references tag_company(tag),
  type varchar(30)
);

create table fortune500 (
  rank int not null,
  title varchar primary key,
  name varchar not null unique,
  ticker char(5),
  url varchar,
  hq varchar,
  sector varchar,
  industry varchar,
  employees int check (employees > 0),
  revenues int,
  revenues_change real,
  profits numeric,
  profits_change real,
  assets numeric check (assets > 0),
  equity numeric
);

insert into company values 
(1, 'nasdaq', 'PYPL', 'PayPal Holdings Incorporated', NULL),
(2, 'nasdaq', 'AMZN', 'Amazon.com Inc', NULL),
(3, 'nasdaq', 'MSFT', 'Microsoft Corp.', NULL),
(4, 'nasdaq', 'MDB', 'MongoDB', NULL),
(5, 'nasdaq', 'DBX', 'Dropbox', NULL),
(6, 'nasdaq', 'AAPL', 'Apple Incorporated', NULL),
(7, 'nasdaq', 'CTXS', 'Citrix Systems', NULL),
(8, 'nasdaq', 'GOOGL', 'Alphabet', NULL),
(9, 'nyse', 'IBM', 'International Business Machines Corporation', NULL),
(10, 'nasdaq', 'ADBE', 'Adobe Systems Incorporated', NULL),
(11, NULL, NULL, 'Stripe', NULL),
(12, NULL, NULL, 'Amazon Web Services', 2),
(13, NULL, NULL, 'Google LLC', 8),
(14, 'nasdaq', 'EBAY', 'eBay, Inc.', NULL);


insert into tag_company (tag, company_id) values 
('actionscript', 10),
('actionscript-3', 10),
('amazon', 2),
('amazon-api', 2),
('amazon-appstore', 2),
('amazon-cloudformation', 12),
('amazon-cloudfront', 12),
('amazon-cloudsearch', 12),
('amazon-cloudwatch', 12),
('amazon-cognito', 12),
('amazon-data-pipeline', 12),
('amazon-dynamodb', 12),
('amazon-ebs', 12),
('amazon-ec2', 12),
('amazon-ecs', 12),
('amazon-elastic-beanstalk', 12),
('amazon-elasticache', 12),
('amazon-elb', 12),
('amazon-emr', 12),
('amazon-fire-tv', 2),
('amazon-glacier', 12),
('amazon-kinesis', 12),
('amazon-lambda', 12),
('amazon-mws', 12),
('amazon-rds', 12),
('amazon-rds-aurora', 12),
('amazon-redshift', 12),
('amazon-route53', 12),
('amazon-s3', 12),
('amazon-ses', 12),
('amazon-simpledb', 12),
('amazon-sns', 12),
('amazon-sqs', 12),
('amazon-swf', 12),
('amazon-vpc', 12),
('amazon-web-services', 12),
('android', 13),
('android-pay', 13),
('applepay', 6),
('applepayjs', 6),
('azure', 3),
('citrix', 7),
('cognos', 9),
('dropbox', 5),
('dropbox-api', 5),
('excel', 3),
('google-spreadsheet', 13),
('ios', 6),
('ios8', 6),
('ios9', 6),
('mongodb', 4),
('osx', 6),
('paypal', 1),
('sql-server', 3),
('stripe-payments', 11),
('windows', 3);

insert into tag_type (tag, type) values 
('amazon-cloudformation', 'cloud'),
('amazon-cloudfront', 'cloud'),
('amazon-cloudsearch', 'cloud'),
('amazon-cloudwatch', 'cloud'),
('amazon-cognito', 'cloud'),
('amazon-cognito', 'identity'),
('amazon-data-pipeline', 'cloud'),
('amazon-dynamodb', 'cloud'),
('amazon-dynamodb', 'database'),
('amazon-ebs', 'cloud'),
('amazon-ec2', 'cloud'),
('amazon-ecs', 'cloud'),
('amazon-elastic-beanstalk', 'cloud'),
('amazon-elasticache', 'cloud'),
('amazon-elb', 'cloud'),
('amazon-emr', 'cloud'),
('amazon-glacier', 'cloud'),
('amazon-glacier', 'storage'),
('amazon-kinesis', 'cloud'),
('amazon-lambda', 'cloud'),
('amazon-mws', 'api'),
('amazon-rds-aurora', 'cloud'),
('amazon-rds', 'cloud'),
('amazon-rds-aurora', 'database'),
('amazon-rds', 'database'),
('amazon-redshift', 'cloud'),
('amazon-route53', 'cloud'),
('amazon-s3', 'cloud'),
('amazon-ses', 'cloud'),
('amazon-simpledb', 'cloud'),
('amazon-simpledb', 'database'),
('amazon-sns', 'cloud'),
('amazon-sqs', 'cloud'),
('amazon-swf', 'cloud'),
('amazon-vpc', 'cloud'),
('amazon-web-services', 'cloud'),
('amazon', 'company'),
('android-pay', 'payment'),
('android', 'mobile-os'),
('applepay', 'payment'),
('applepayjs', 'payment'),
('azure', 'cloud'),
('citrix', 'company'),
('dropbox-api', 'api'),
('dropbox-api', 'api'),
('dropbox-api', 'api'),
('dropbox', 'storage'),
('dropbox', 'cloud'),
('dropbox', 'company'),
('excel', 'spreadsheet'),
('google-spreadsheet', 'spreadsheet'),
('ios', 'mobile-os'),
('ios8', 'mobile-os'),
('ios9', 'mobile-os'),
('mongodb', 'database'),
('osx', 'os'),
('paypal', 'payment'),
('paypal', 'company'),
('sql-server', 'database'),
('stripe-payments', 'payment'),
('windows', 'os');


COPY stackoverflow (tag, date, question_count, question_pct, unanswered_count, unanswered_pct) 
	FROM PROGRAM 'curl "https://assets.datacamp.com/production/repositories/3567/datasets/1e9257c9d86e03a979124c6d99a0ff154da953fd/stackexchange.csv"' (DELIMITER ',', FORMAT CSV, HEADER, NULL 'NA');
	
COPY fortune500
	FROM PROGRAM 'curl "https://assets.datacamp.com/production/repositories/3567/datasets/19cf8e7841e26d71feb3516c7a4b135aff8a8b4f/fortune.csv"' (DELIMITER ',', FORMAT CSV, HEADER, NULL 'NA');


