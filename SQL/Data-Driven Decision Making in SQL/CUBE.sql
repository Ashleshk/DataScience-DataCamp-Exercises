---------------------------------------------------------------------------------------------
--              Groups of customers
---------------------------------------------------------------------------------------------
```
Use the CUBE operator to extract the content of a pivot table from the database. Create a table 
with the total number of male and female customers from each country.```

SELECT gender, -- Extract information of a pivot table of gender and country for the number of customers
	   country,
	   COUNT(*)
FROM customers
GROUP BY CUBE (gender, country)
ORDER BY country;

---------------------------------------------------------------------------------------------
--      Categories of movies
---------------------------------------------------------------------------------------------
```
Give an overview on the movies available on MovieNow. List the number of movies for different 
genres and release years.
```

SELECT genre,
       year_of_release,
       count(*)
FROM movies
GROUP BY CUBE (genre, year_of_release)
ORDER BY year_of_release;


---------------------------------------------------------------------------------------------
--          Analyzing average ratings
---------------------------------------------------------------------------------------------
```
Prepare a table for a report about the national preferences of the customers from MovieNow comparing 
the average rating of movies across countries and genres.
```

SELECT 
	country, 
	genre, 
	AVG(r.rating) AS avg_rating -- Calculate the average rating 
FROM renting AS r
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
group by cube(country,genre); -- For all aggregation levels of country and genre


---------------------------------------------------------------------------------------------
--          Analyzing preferences of genres across countries
---------------------------------------------------------------------------------------------

```You are asked to study the preferences of genres across countries. Are there particular genres which 
are more popular in specific countries? Evaluate the preferences of customers by averaging their 
ratings and counting the number of movies rented from each genre.```



-- Group by each county and genre with OLAP extension
SELECT 
	c.country, 
	m.genre, 
	AVG(r.rating) AS avg_rating, 
	COUNT(*) AS num_rating
FROM renting AS r
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
GROUP BY ROLLUP(c.country, m.genre)
ORDER BY c.country, m.genre;

































