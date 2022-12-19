--------------------------------------------------------------------------
--              Business Case
-------------------------------------------------------------------------

```MovieNow considers to invest money in new movies.

    It is more expensive for MovieNow to make movies available which were recently produced than older ones.

    First step of data analysis:
    -- Do customers give better ratings to movies which were recently produced than to older ones?
    -- Is there a difference across countries ```




SELECT c.country,
m.year_of_release,
COUNT(*) AS n_rentals,
COUNT(DISTINCT r.movie_id) AS n_movies,
AVG(rating) AS avg_rating
FROM renting AS r
LEFT JOIN customers AS c
ON c.customer_id = r.customer_id
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE r.movie_id IN (
SELECT movie_id
FROM renting
GROUP BY movie_id
HAVING COUNT(rating) >= 4)
AND r.date_renting >= '2018-04-01'
GROUP BY ROLLUP (m.year_of_release, c.country)
ORDER BY c.country, m.year_of_release;



Resulting table
| year_of_release | country | n_rentals | n_movies | avg_rating |
|-----------------|---------|-----------|----------|--------------------|
| 2009 | null | 10 | 1 | 8.7500000000000000 |
| 2010 | null | 41 | 5 | 7.9629629629629630 |
| 2011 | null | 14 | 2 | 8.2222222222222222 |
| 2012 | null | 28 | 5 | 8.1111111111111111 |
| 2013 | null | 10 | 2 | 7.6000000000000000 |
| 2014 | null | 5 | 1 | 8.0000000000000000 |
| null | null | 333 | 50 | 7.9024390243902439 |


-------------------------------------------------------------------------
--                  Customer preference for genres
-------------------------------------------------------------------------

```You just saw that customers have no clear preference for more recent movies over older ones.
 Now the management considers investing money in movies of the best rated genres.```


SELECT genre,
	   AVG(rating) AS avg_rating,
	   COUNT(rating) AS n_rating,
       COUNT(*) AS n_rentals,     
	   COUNT(DISTINCT m.movie_id) AS n_movies 
FROM renting AS r
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE r.movie_id IN ( 
	SELECT movie_id
	FROM renting
	GROUP BY movie_id
	HAVING COUNT(rating) >= 3 )
AND r.date_renting >= '2018-01-01'
GROUP BY genre
ORDER BY avg_rating desc; -- Order the table by decreasing average rating

-------------------------------------------------------------------------
--                  Customer preference for actors
-------------------------------------------------------------------------

```The last aspect you have to analyze are customer preferences for certain actors.
```


SELECT a.nationality,
       a.gender,
	   AVG(r.rating) AS avg_rating,
	   COUNT(r.rating) AS n_rating,
	   COUNT(*) AS n_rentals,
	   COUNT(DISTINCT a.actor_id) AS n_actors
FROM renting AS r
LEFT JOIN actsin AS ai
ON ai.movie_id = r.movie_id
LEFT JOIN actors AS a
ON ai.actor_id = a.actor_id
WHERE r.movie_id IN ( 
	SELECT movie_id
	FROM renting
	GROUP BY movie_id
	HAVING COUNT(rating) >= 4)
AND r.date_renting >= '2018-04-01'
GROUP BY GROUPING SETS ((nationality,gender),(nationality),(gender),());  
