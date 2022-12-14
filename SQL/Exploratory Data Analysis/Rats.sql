----------------------------------------------------------------------------------
--                  Rats!
----------------------------------------------------------------------------------
```
Requests in category "Rodents- Rats" average over 64 days to resolve. Why?

Investigate in 4 steps:
    Why is the average so high? Check the distribution of completion times. Hint: date_trunc() can be used on intervals.
    See how excluding outliers influences average completion times.
    Do requests made in busy months take longer to complete? Check the correlation between the average completion time and requests per month.
    Compare the number of requests created per month to the number completed.

Remember: the time to resolve, or completion time, is date_completed - date_created.
```


-- #1 Use date_trunc() to examine the distribution of rat request completion times by number of days.

SELECT date_trunc('day',date_completed-date_created) AS completion_time,
       COUNT(*)
  FROM evanston311
 WHERE category = 'Rodents- Rats'
 GROUP BY completion_time
 ORDER BY completion_time;
completion_time	count
0:00:00	73
1 day, 0:00:00	17
2 days, 0:00:00	23
3 days, 0:00:00	11
4 days, 0:00:00	6
5 days, 0:00:00	6
6 days, 0:00:00	5
7 days, 0:00:00	7
8 days, 0:00:00	6
...

-- #2 Compute average completion time per category excluding the longest 5% of requests (outliers).
SELECT category, 
       AVG(date_completed - date_created) AS avg_completion_time
  FROM evanston311
 WHERE date_completed - date_created < 
-- Compute the 95th percentile of completion time in a subquery
         (SELECT percentile_disc(0.95) WITHIN GROUP (ORDER BY date_completed-date_created)
            FROM evanston311)
 GROUP BY category
 ORDER BY avg_completion_time DESC;
category	                                      avg_completion_time
Trash Cart - Downsize, Upsize or Remove	        12 days, 17:47:50.586912
Sanitation Billing Questions                	12 days, 11:13:25.888889
...

-- #3 Get corr() between avg. completion time and monthly requests. EXTRACT(epoch FROM interval) returns seconds in interval.
SELECT CORR(avg_completion, count)
  -- Convert date_created to its month with date_trunc
  FROM (SELECT date_trunc('month', date_created) AS month, 
               -- Compute average completion time in number of seconds           
               AVG(EXTRACT(epoch FROM date_completed - date_created)) AS avg_completion, 
               -- Count requests per month
               count(*) AS count
          FROM evanston311
         -- Limit to rodents
         WHERE category='Rodents- Rats' 
         -- Group by month, created above
         GROUP BY month) 
         -- Required alias for subquery 
         AS monthly_avgs;
corr
0.23199855213424334

-- #4 Select the number of requests created and number of requests completed per month.

-- Compute monthly counts of requests created
WITH created AS (
       SELECT date_trunc('month', date_created) AS month,
              count(*) AS created_count
         FROM evanston311
        WHERE category='Rodents- Rats'
        GROUP BY month),
-- Compute monthly counts of requests completed
      completed AS (
       SELECT date_trunc('month', date_completed) AS month,
              count(*) AS completed_count
         FROM evanston311
        WHERE category='Rodents- Rats'
        GROUP BY month)
-- Join monthly created and completed counts
SELECT created.month, 
       created_count, 
       completed_count
  FROM created
       INNER JOIN completed
       ON created.month=completed.month
 ORDER BY created.month;


 month	            created_count	completed_count
2016-01-01 00:00:00+01:00	10	        1
2016-02-01 00:00:00+01:00	22	        11
2016-03-01 00:00:00+01:00	31	        14
