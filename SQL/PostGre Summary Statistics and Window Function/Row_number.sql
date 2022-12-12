/*
#1 Number each row in the dataset.
*/

SELECT
  *,
  -- Assign numbers to each row
  ROW_NUMBER() OVER() AS Row_N
FROM Summer_Medals
ORDER BY Row_N ASC;


/*
#2 Assign a number to each year in which Summer Olympic games were held.
*/
SELECT
  Year,

  -- Assign numbers to each year
  ROW_NUMBER() OVER() AS Row_N
FROM (
  SELECT DISTINCT year
  FROM Summer_Medals
  ORDER BY Year ASC
) AS Years
ORDER BY Year ASC;


------------------------------------------------------------------------------
----                    REGIHNING CHAMPION 
------------------------------------------------------------------------------
/*
#1 Assign a number to each year in which Summer Olympic games were held so that rows with the most recent years have lower row numbers.

*/

SELECT
  Year,
  -- Assign the lowest numbers to the most recent years
  ROW_NUMBER() OVER (ORDER BY year DESC) AS Row_N
FROM (
  SELECT DISTINCT Year
  FROM Summer_Medals
) AS Years
ORDER BY Year;

/*
#2 For each athlete, count the number of medals he or she has earned.
*/
SELECT
  -- Count the number of medals each athlete has earned
  athlete,
  COUNT( *) AS Medals
FROM Summer_Medals
GROUP BY Athlete
ORDER BY Medals DESC;

/*
#3 Having wrapped the previous query in the Athlete_Medals CTE, rank each athlete by the number of medals they've earned.
*/
WITH Athlete_Medals AS (
  SELECT
    -- Count the number of medals each athlete has earned
    Athlete,
    COUNT(*) AS Medals
  FROM Summer_Medals
  GROUP BY Athlete)

SELECT
  -- Number each athlete by how many medals they've earned
  athlete,
  ROW_NUMBER() OVER (ORDER BY Medals DESC) AS Row_N
FROM Athlete_Medals
ORDER BY Medals DESC;

----------------------------------------------------------------
/* Example 2 Reigning weightlifting champions
A reigning champion is a champion who's won both the previous and current years' competitions. 
To determine if a champion is reigning, the previous and current years' results need to be in the same row, in two different columns.
*/
--------------------------------------------------------------
/*
Return each year's gold medalists in the Men's 69KG weightlifting competition.
*/

SELECT
  -- Return each year's champions' countries
  year,
  Country AS champion
FROM Summer_Medals
WHERE
  Discipline = 'Weightlifting' AND
  Event = '69KG' AND
  Gender = 'Men' AND
  Medal = 'Gold';

/*
Having wrapped the previous query in the Weightlifting_Gold CTE, get the previous year's champion for each year.
*/
WITH Weightlifting_Gold AS (
  SELECT
    -- Return each year's champions' countries
    Year,
    Country AS champion
  FROM Summer_Medals
  WHERE
    Discipline = 'Weightlifting' AND
    Event = '69KG' AND
    Gender = 'Men' AND
    Medal = 'Gold')

SELECT
  Year, Champion,
  -- Fetch the previous year's champion
  LAG(Champion) OVER
    (ORDER BY year ASC) AS Last_Champion
FROM Weightlifting_Gold
ORDER BY Year ASC;


----------------------------------------------------------------
--             PARTITION BY

/* Example 3 Reigning champions by gender
You've already fetched the previous year's champion for one event. However, if you have multiple events, genders, or other metrics as columns, you'll need to split your table into partitions to avoid having 
a champion from one event or gender appear as the previous champion of another event or gender.*/
--------------------------------------------------------------

/*
Return the previous champions of each year's event by gender.
*/
WITH Tennis_Gold AS (
  SELECT DISTINCT
    Gender, Year, Country
  FROM Summer_Medals
  WHERE
    Year >= 2000 AND
    Event = 'Javelin Throw' AND
    Medal = 'Gold')

SELECT
  Gender, Year,
  Country AS Champion,
  -- Fetch the previous year's champion by gender
  LAG(Country) OVER (PARTition by gender
            ORDER BY year ASC) AS Last_Champion
FROM Tennis_Gold
ORDER BY Gender ASC, Year ASC;

/*
Return the previous champions of each year's events by gender and event.
*/
WITH Athletics_Gold AS (
  SELECT DISTINCT
    Gender, Year, Event, Country
  FROM Summer_Medals
  WHERE
    Year >= 2000 AND
    Discipline = 'Athletics' AND
    Event IN ('100M', '10000M') AND
    Medal = 'Gold')

SELECT
  Gender, Year, Event,
  Country AS Champion,
  -- Fetch the previous year's champion by gender and event
  LAG(Country) OVER (PARTITION BY gender, event
            ORDER BY Year ASC) AS Last_Champion
FROM Athletics_Gold
ORDER BY Event ASC, Gender ASC, Year ASC;








