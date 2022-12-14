/*
Count the number of Evanston 311 requests created on January 31, 2017 by casting date_created to a date.
*/
SELECT count(*) 
  FROM evanston311
 WHERE date_created::date = '2017-01-31';



/*
Count the number of Evanston 311 requests created on February 29, 2016 by using >= and < operators.
*/
-- Count requests created on February 29, 2016
SELECT count(*)
  FROM evanston311 
 WHERE date_created >= '2016-02-29' 
   AND date_created < '2016-03-01';


-- Count requests created on March 13, 2017
SELECT count(*)
  FROM evanston311
 WHERE date_created >= '2017-03-13'
   AND date_created < '2017-03-13'::date + 1;

-- Subtract the min date_created from the max
SELECT MAX(date_created) - MIN(date_created)
  FROM evanston311;

-- How old is the most recent request?
SELECT NOW() - MAX(date_created)
  FROM evanston311;

-- Add 100 days to the current timestamp
SELECT NOW() + '100 days'::interval;

-- Select the current timestamp, 
-- and the current timestamp + 5 minutes
SELECT NOW() + '5 minutes'::interval;


---------------------------------------------------------------------------------------------------
--   Completion time by Category
--------------------------------------------------------------------------------------------------
```Compute the average difference between the completion timestamp and the creation timestamp by 
category.
Order the results with the largest average time to complete the request first.```
-- Select the category and the average completion time by category
SELECT category, 
       AVG(date_completed- date_created) AS completion_time
  FROM evanston311
 GROUP BY category
-- Order the results
 ORDER by completion_time desc;


-------------------------------------------------------------------------------------------------------
--              DATE PARTS
-----------------------------------------------------------------------------------------------
```
The date_part() function is useful when you want to aggregate data by a unit of time across
 multiple larger units of time. For example, aggregating data by month across different years, 
 or aggregating by hour across different days.

Recall that you use date_part() as:

SELECT date_part('field', timestamp);
In this exercise, you'll use date_part() to gain insights about when Evanston 311 requests are 
submitted and completed.
```.

/*
How many requests are created in each of the 12 months during 2016-2017?
*/
SELECT date_part('month' , date_created) AS month, 
       COUNT(*)
  FROM evanston311
 WHERE date_created >= '2016-01-01'
   AND date_created <'2018-01-01'
 GROUP BY month;

/*
What is the most common hour of the day for requests to be created?
*/
-- Get the hour and count requests
SELECT date_part('hour', date_created) AS hour,
       count(*)
  FROM evanston311
 GROUP BY hour
 -- Order results to select most common
 ORDER BY count desc
 LIMIT 1;

/*
During what hours are requests usually completed? Count requests completed by hour.
Order the results by hour.
*/
SELECT date_part('hour',date_completed) AS hour,
       Count(*)
  FROM evanston311
 Group by hour
 order by count;


```                         Variation by day of week
Does the time required to complete a request vary by the day of the week on which the request was created?

We can get the name of the day of the week by converting a timestamp to character data:

to_char(date_created, 'day') 
But character names for the days of the week sort in alphabetical, not chronological, order. To get the chronological order of days of the week with an integer value for each day, we can use:

EXTRACT(DOW FROM date_created)
DOW stands for "day of week."
```

-- Select name of the day of the week the request was created 
SELECT to_char(date_created, 'day') AS day, 
       -- Select avg time between request creation and completion
       avg(date_completed - date_created) AS duration
  FROM evanston311 
 -- Group by the name of the day of the week and 
 -- integer value of day of week the request was created
 GROUP BY day, EXTRACT(DOW FROM date_created)
 -- Order by integer value of the day of the week 
 -- the request was created
 ORDER BY EXTRACT(DOW FROM date_created);



-- Aggregate daily counts by month
SELECT date_trunc('month',day) AS month,
       avg(count)
  -- Subquery to compute daily counts
  FROM (SELECT date_trunc('day',date_created) AS day,
               count(*) AS count
          FROM evanston311
         GROUP BY day) AS daily_count
 GROUP BY month
 ORDER BY month;


```
Write a subquery using generate_series() to get all dates between the min() and max() date_created 
in evanston311.
Write another subquery to select all values of date_created as dates from evanston311.
Both subqueries should produce values of type date (look for the ::).
Select dates (day) from the first subquery that are NOT IN the results of the second subquery.
 This gives you days that are not in date_created.
```
SELECT day
-- 1) Subquery to generate all dates
-- from min to max date_created
  FROM (SELECT generate_series(MIN(date_created),
                               MAX(date_created),
                               '1 day'::interval)::date AS day
          -- What table is date_created in?
          FROM evanston311) AS all_dates
-- 4) Select dates (day from above) that are NOT IN the subquery
 WHERE day NOT IN 
       -- 2) Subquery to select all date_created values as dates
       (SELECT date_created::date
          FROM evanston311);


-----------------------------------------------------------------------------------
--        Custom aggregation periods
-----------------------------------------------------------------------------------
```Find the median number of Evanston 311 requests per day in each six month period from 2016-01-01 to 2018-06-30.
 Build the query following the three steps below.

Recall that to aggregate data by non-standard date/time intervals, such as six months, you can 
use generate_series() to create bins with lower and upper bounds of time, and then summarize
 observations that fall in each bin.```

-- Generate 6 month bins covering 2016-01-01 to 2018-06-30

-- Create lower bounds of bins
SELECT generate_series('2016-01-01',  -- First bin lower value
                       '2018-01-01',  -- Last bin lower value
                       '6 month'::interval) AS lower,
-- Create upper bounds of bins
       generate_series('2016-07-01',  -- First bin upper value
                       '2018-07-01',  -- Last bin upper value
                       '6 month'::interval) AS upper;

```
Assign each daily count to a single 6 month bin by joining bins to daily_counts.
Compute the median value per bin using percentile_disc().```

-- Bins from Step 1
WITH bins AS (
	 SELECT generate_series('2016-01-01',
                            '2018-01-01',
                            '6 months'::interval) AS lower,
            generate_series('2016-07-01',
                            '2018-07-01',
                            '6 months'::interval) AS upper),
-- Daily counts from Step 2
     daily_counts AS (
     SELECT day, count(date_created) AS count
       FROM (SELECT generate_series('2016-01-01',
                                    '2018-06-30',
                                    '1 day'::interval)::date AS day) AS daily_series
            LEFT JOIN evanston311
            ON day = date_created::date
      GROUP BY day)
-- Select bin bounds 
SELECT lower, 
       upper, 
       -- Compute median of count for each bin
       percentile_disc(0.5) WITHIN GROUP (ORDER BY lower) AS median
  -- Join bins and daily_counts
  FROM bins
       LEFT JOIN daily_counts
       -- Where the day is between the bin bounds
       ON day >= lower
          AND day < upper
 -- Group by bin bounds
 GROUP BY lower, upper
 ORDER BY lower;
    lower	                        upper	                    median
2016-01-01 00:00:00+01:00	2016-07-01 00:00:00+02:00	2016-01-01 00:00:00+01:00
2016-07-01 00:00:00+02:00	2017-01-01 00:00:00+01:00	2016-07-01 00:00:00+02:00
2017-01-01 00:00:00+01:00	2017-07-01 00:00:00+02:00	2017-01-01 00:00:00+01:00
2017-07-01 00:00:00+02:00	2018-01-01 00:00:00+01:00	2017-07-01 00:00:00+02:00

```                         Monthly average with missing dates
Find the average number of Evanston 311 requests created per day for each month of the data.

This time, do not ignore dates with no requests.```

/*
Generate a series of dates from 2016-01-01 to 2018-06-30.
Join the series to a subquery to count the number of requests created per day.
Use date_trunc() to get months from date, which has all dates, NOT day.
Use coalesce() to replace NULL count values with 0. Compute the average of this value.
*/



-- generate series with all days from 2016-01-01 to 2018-06-30
WITH all_days AS 
     (SELECT generate_series('2016-01-01',
                             '2018-06-30',
                             '1 day'::INTERVAL) AS date),
     -- Subquery to compute daily counts
     daily_count AS 
     (SELECT date_trunc('day', date_created) AS day,
             count(*) AS count
        FROM evanston311
       GROUP BY day)
-- Aggregate daily counts by month using date_trunc
SELECT date_trunc('month', date) AS month,
       -- Use coalesce to replace NULL count values with 0
       avg(coalesce(count, 0)) AS average
  FROM all_days
       LEFT JOIN daily_count
       -- Joining condition
       ON all_days.date=daily_count.day
 GROUP BY month
 ORDER BY month; 

-------------------------------------------------------------------------------
--                          Longest gap
------------------------------------------------------------------------------
```
What is the longest time between Evanston 311 requests being submitted?

Recall the syntax for lead() and lag():

lag(column_to_adjust) OVER (ORDER BY ordering_column)
lead(column_to_adjust) OVER (ORDER BY ordering_column)
```
/*
Instructions
    Select date_created and the date_created of the previous request using lead() or lag() as appropriate.
    Compute the gap between each request and the previous request.
    Select the row with the maximum gap.
*/
-- Compute the gaps
WITH request_gaps AS (
        SELECT date_created,
               -- lead or lag
               lag(date_created) OVER (order by date_created) AS previous,
               -- compute gap as date_created minus lead or lag
               date_created - lag(date_created) OVER (order by date_created) AS gap
          FROM evanston311)
-- Select the row with the maximum gap
SELECT *
  FROM request_gaps
-- Subquery to select maximum gap from request_gaps
 WHERE gap = (SELECT MAX(gap)
                FROM request_gaps);

date_created	                previous                    	gap
2018-01-07 19:41:34+01:00	2018-01-05 19:04:09+01:00	2 days, 0:37:25













