--Q1# Filter for only those populations where life_expectancy is 1.15 times higher than average.
SELECT *
FROM populations
WHERE life_expectancy > 1.15 *
  (SELECT AVG(life_expectancy)
   FROM populations
   WHERE year = 2015) 
	 AND year = 2015;