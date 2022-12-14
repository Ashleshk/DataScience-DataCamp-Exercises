```Generate series
Summarize the distribution of the number of questions with the tag "dropbox" on Stack Overflow per day by binning the data.

Recall:

generate_series(from, to, step)
You can reference the slides using the PDF icon in the upper right corner of the screen.```

-- Bins created in Step 2
WITH bins AS (
      SELECT generate_series(2200, 3050, 50) AS lower,
             generate_series(2250, 3100, 50) AS upper),
     -- Subset stackoverflow to just tag dropbox (Step 1)
     dropbox AS (
      SELECT question_count 
        FROM stackoverflow
       WHERE tag='dropbox') 
-- Select columns for result
-- What column are you counting to summarize?
SELECT lower, upper, count(question_count) 
  FROM bins  -- Created above
       -- Join to dropbox (created above), 
       -- keeping all rows from the bins table in the join
       LEFT JOIN dropbox
       -- Compare question_count to lower and upper
         ON question_count >= lower 
        AND question_count < upper
 -- Group by lower and upper to count values in each bin
 GROUP BY lower, upper
 -- Order by lower to put bins in order
 ORDER BY lower;



/*
Select the mean and median of assets.
Group by sector.
Order the results by the mean.
*/
-- What groups are you computing statistics by?
SELECT sector,
       -- Select the mean of assets with the avg function
       AVG(assets) AS mean,
       -- Select the median
       percentile_disc(0.5) WITHIN  GROUP  (ORDER BY assets) AS median
  FROM fortune500
 -- Computing statistics for each what?
 GROUP BY sector
 -- Order results by a value of interest
 ORDER BY sector;


```Create a temporary table called profit80 containing the sector and 80th percentile of profits for each sector.
Alias the percentile column as pct80.
```
-- To clear table if it already exists;
-- fill in name of temp table
DROP TABLE IF EXISTS profit80;

-- Create the temporary table
CREATE TEMP TABLE profit80 AS 
  -- Select the two columns you need; alias as needed
  SELECT sector, 
         percentile_disc(0.8) WITHIN GROUP (Order by profits) AS pct80
    -- What table are you getting the data from?
    FROM Fortune500
   -- What do you need to group by?
   Group by sector;
   
-- See what you created: select all columns and rows 
-- from the table you created
SELECT * 
  FROM profit80;
```
Using the profit80 table you created in step 1, select companies that have profits greater than pct80.
Select the title, sector, profits from fortune500, as well as the ratio of the company's profits to the 80th percentile profit.```

-- Code from previous step
DROP TABLE IF EXISTS profit80;

CREATE TEMP TABLE profit80 AS
  SELECT sector, 
         percentile_disc(0.8) WITHIN GROUP (ORDER BY profits) AS pct80
    FROM fortune500 
   GROUP BY sector;

-- Select columns, aliasing as needed
SELECT title, profit80.sector, 
       profits, profits/profit80.pct80 AS ratio
-- What tables do you need to join?  
  FROM fortune500 
       LEFT JOIN profit80
-- How are the tables joined?
       ON profit80.sector=fortune500.sector
-- What rows do you want to select?
 WHERE profits > profit80.pct80;


```First, create a temporary table called startdates with each tag and the min() date for the tag in stackoverflow.
```
-- To clear table if it already exists
DROP TABLE IF EXISTS startdates;

-- Create temp table syntax
CREATE TEMP TABLE startdates AS
-- Compute the minimum date for each what?
SELECT tag,
       MIN(date) AS mindate
  FROM stackoverflow
 -- What do you need to compute the min date for each tag?
 GRoup BY tag;
 
 -- Look at the table you created
 SELECT * 
   FROM startdates;

```
Join startdates to stackoverflow twice using different table aliases.
For each tag, select mindate, question_count on the mindate, and question_count on 2018-09-25 (the max date).
Compute the change in question_count over time.```

-- To clear table if it already exists
DROP TABLE IF EXISTS startdates;

CREATE TEMP TABLE startdates AS
SELECT tag, min(date) AS mindate
  FROM stackoverflow
 GROUP BY tag;
 
-- Select tag (Remember the table name!) and mindate
SELECT startdates.tag, 
       startdates.mindate, 
       -- Select question count on the min and max days
	   so_min.question_count AS min_date_question_count,
       so_max.question_count AS max_date_question_count,
       -- Compute the change in question_count (max- min)
       so_max.question_count - so_min.question_count AS change
  FROM startdates
       -- Join startdates to stackoverflow with alias so_min
       INNER JOIN stackoverflow AS so_min
          -- What needs to match between tables?
          ON startdates.tag = so_min.tag
         AND startdates.mindate = so_min.date
       -- Join to stackoverflow again with alias so_max
       INNER JOIN stackoverflow AS so_max
       	  -- Again, what needs to match between tables?
          ON startdates.tag = so_max.tag
         AND so_max.date = '2018-09-25';



```                     Insert into a temp table
While you can join the results of multiple similar queries together with UNION, sometimes it's easier to break a query down into steps. You can do this by creating a temporary table and inserting rows into it.

Compute the correlations between each pair of profits, profits_change, and revenues_change from the Fortune 500 data.

The resulting temporary table should have the following structure:

measure	profits	profits_change	revenues_change
profits	1.00	#	#
profits_change	#	1.00	#
revenues_change	#	#	1.00
Recall the round() function to make the results more readable:

round(column_name::numeric, decimal_places)```

/*
Create a temp table correlations.

Compute the correlation between profits and each of the three variables (i.e. correlate profits with profits, profits with profits_change, etc).
Alias columns by the name of the variable for which the correlation with profits is being computed.
*/
DROP TABLE IF EXISTS correlations;

-- Create temp table 
Create temp table correlations AS
-- Select each correlation
SELECT 'profits'::varchar AS measure,
       -- Compute correlations
       CORR(profits, profits) AS profits,
       CORR(profits, profits_change) AS profits_change,
       CORR(profits, revenues_change) AS revenues_change
  FROM FORTUNE500;


/*
Insert rows into the correlations table for profits_change and revenues_change.  
*/

DROP TABLE IF EXISTS correlations;

CREATE TEMP TABLE correlations AS
SELECT 'profits'::varchar AS measure,
       corr(profits, profits) AS profits,
       corr(profits, profits_change) AS profits_change,
       corr(profits, revenues_change) AS revenues_change
  FROM fortune500;

INSERT INTO correlations
SELECT 'profits_change'::varchar AS measure,
       corr(profits_change, profits) AS profits,
       corr(profits_change, profits_change) AS profits_change,
       corr(profits_change, revenues_change) AS revenues_change
  FROM fortune500;

-- Repeat the above, but for revenues_change
INSERT INTO correlations
SELECT 'revenues_change'::varchar AS measure,
       corr(revenues_change, profits) AS profits,
       corr(revenues_change, profits_change) AS profits_change,
       corr(revenues_change, revenues_change) AS revenues_change
  FROM fortune500;

/*
Select all rows and columns from the correlations table to view the correlation matrix.

    First, you will need to round each correlation to 2 decimal places.
    The output of corr() is of type double precision, so you will need to also cast columns to numeric.
*/
DROP TABLE IF EXISTS correlations;

CREATE TEMP TABLE correlations AS
SELECT 'profits'::varchar AS measure,
       corr(profits, profits) AS profits,
       corr(profits, profits_change) AS profits_change,
       corr(profits, revenues_change) AS revenues_change
  FROM fortune500;

INSERT INTO correlations
SELECT 'profits_change'::varchar AS measure,
       corr(profits_change, profits) AS profits,
       corr(profits_change, profits_change) AS profits_change,
       corr(profits_change, revenues_change) AS revenues_change
  FROM fortune500;

INSERT INTO correlations
SELECT 'revenues_change'::varchar AS measure,
       corr(revenues_change, profits) AS profits,
       corr(revenues_change, profits_change) AS profits_change,
       corr(revenues_change, revenues_change) AS revenues_change
  FROM fortune500;

-- Select each column, rounding the correlations
SELECT measure, 
       ROUND(profits::numeric ,2) AS profits,
       ROUND(profits_change::numeric,2) AS profits_change,
       ROUND(revenues_change::numeric,2) AS revenues_change
  FROM correlations;





