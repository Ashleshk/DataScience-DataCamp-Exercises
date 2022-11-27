--Q1# Return the name, country_code and urbanarea_pop for all capital cities (not aliased).
-- Select relevant fields from cities table
Select name, country_code, urbanarea_pop
From cities 
-- Filter using a subquery on the countries table
Where country_code in (Select code from countries where cities.name = capital)
ORDER BY urbanarea_pop DESC;

--Q2# In Step 1, you'll begin with a LEFT JOIN combined with a GROUP BY to obtain summarized information from two tables in order to select the nine countries with the most cities appearing in the cities table. 
--In Step 2, you'll write a query that returns the same result as the join, but leveraging a nested query instead.
Select countries.name as country,
    count(*) as cities_num
from countries
left join  cities
on countries.code = cities.country_code
-- Order by count of cities as cities_num
group by country
order by cities_num desc
limit 9;

--Step2
SELECT countries.name AS country,
  (SELECT COUNT(name)
  FROM cities 
  WHERE country_code = code) AS cities_num
FROM countries
ORDER BY cities_num DESC, country
LIMIT 9;