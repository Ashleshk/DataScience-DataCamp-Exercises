
```
Select all movie rentals of the movie with movie_id 25 from the table renting.
For those records, calculate the minimum, maximum and average rating and count the number of ratings for this movie.
```

SELECT MIN(rating)  as min_rating, -- Calculate the minimum rating and use alias min_rating
	   MAX(rating)  as max_rating, -- Calculate the maximum rating and use alias max_rating
	   AVG(rating)  as avg_rating, -- Calculate the average rating and use alias avg_rating
	   COUNT(rating)  as number_ratings -- Count the number of ratings and use alias number_ratings
FROM renting
WHERE movie_id = 25; -- Select all records of the movie with ID 25


```
Finally, count how many ratings exist since 2019-01-01.```

SELECT 
	COUNT(*) AS number_renting,
	AVG(rating) AS average_rating, 
    COUNT(rating) AS number_ratings -- Add the total number of ratings here.
FROM renting
WHERE date_renting >= '2019-01-01';

```
Add two columns for the number of ratings and the number of movie rentals to the results table.
Use alias names avg_rating, number_rating and number_renting for the corresponding columns.
Order the rows of the table by the average rating such that it is in decreasing order.
Observe what happens to NULL values.```

SELECT movie_id, 
       AVG(rating) AS avg_rating,
       COUNT(rating) AS number_ratings,
       COUNT(*) AS number_renting
FROM renting
GROUP BY movie_id
ORDER BY avg_rating desc ; -- Order by average rating in decreasing order


```
Group the data in the table renting by customer_id and report the customer_id, the average rating, the number of ratings and the number of movie rentals.
Select only customers with more than 7 movie rentals.
Order the resulting table by the average rating in ascending order.```


SELECT customer_id, -- Report the customer_id
      AVG(rating),  -- Report the average rating per customer
      COUNT(rating),  -- Report the number of ratings per customer
      COUNT(*)  -- Report the number of movie rentals per customer
FROM renting
GROUP BY customer_id
HAVING COUNT(*) > 7 -- Select only customers with more than 7 movie rentals
ORDER BY AVG(rating) ; -- Order by the average rating in ascending order


```Join renting and customers
For many analyses it is necessary to add customer information to the data in the table renting.```

/*
    Select only records from customers coming from Belgium.
    Average ratings of customers from Belgium
*/
SELECT AVG(rating) -- Average ratings of customers from Belgium
FROM renting AS r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
WHERE c.country='Belgium';


```
Calculate the revenue coming from movie rentals, 
the number of movie rentals and the number of customers who rented a movie.

Now, you can report these values for the year 2018. Calculate the revenue in 2018, 
the number of movie rentals and the number of active customers in 2018. An active customer
 is a customer who rented at least one movie in 2018.
```
SELECT 
	SUM(m.renting_price), 
	COUNT(*), 
	COUNT(DISTINCT r.customer_id)
FROM renting AS r
LEFT JOIN movies AS m
ON r.movie_id = m.movie_id
-- Only look at movie rentals in 2018
WHERE date_renting BETWEEN '2018-01-01' AND '2018-12-31' ;



------------------------------------------------------------------------------------
--                          Movies and actors
--      You are asked to give an overview of which actors play in which movie.
------------------------------------------------------------------------------------

```Create a list of actor names and movie titles in which they act. Make sure that each combination 
of actor and movie appears only once.
Use as an alias for the table actsin the two letters ai.```

SELECT m.title, -- Create a list of movie titles and actor names
       a.name
FROM actsin as am
LEFT JOIN movies AS m
ON m.movie_id = am.movie_id
LEFT JOIN actors AS a
ON a.actor_id = am.actor_id;


----------------------------------------------------------------------------
--          Money spent per customer with sub-queries
-----------------------------------------------------------------------------
```How much money did each customer spend?```

SELECT rm.customer_id,
SUM(rm.renting_price)
FROM
(SELECT r.customer_id,
m.renting_price
FROM renting AS r
LEFT JOIN movies AS m
ON r.movie_id=m.movie_id) AS rm
GROUP BY rm.customer_id;

| customer_id | sum |
|-------------|-------|
| 116 | 7.47 |
| 87 | 17.53 |
| 71 | 6.87 |
| 68 | 1.59 |
| 51 | 4.87 |

```Income from movies
How much income did each movie generate? ```

SELECT rm.title, -- Report the income from movie rentals for each movie 
       SUM(rm.renting_price) AS income_movie
FROM
       (SELECT m.title,  
               m.renting_price
       FROM renting AS r
       LEFT JOIN movies AS m
       ON r.movie_id=m.movie_id) AS rm
GROUP BY rm.title
ORDER BY income_movie desc; -- Order the result by decreasing income


```Age of actors from the USA
Now you will explore the age of American actors and actresses. 
Report the date of birth of the oldest and youngest US actor and actress.```

SELECT a.gender, -- Report for male and female actors from the USA 
       min(a.year_of_birth), -- The year of birth of the oldest actor
       max(a.year_of_birth) -- The year of birth of the youngest actor
FROM
   (SELECT* FROM ACTORS WHERE nationality ='USA') -- Use a subsequen SELECT to get all information about actors from the USA
   as
   a -- Give the table the name a
GROUP BY a.gender;


-----------------------------------------------------------------------------------------
--                  Identify favorite actors of customer groups
----------------------------------------------------------------------------------------
SELECT a.name,
COUNT(*)
FROM renting as r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
LEFT JOIN actsin as ai
ON r.movie_id = ai.movie_id
LEFT JOIN actors as a
ON ai.actor_id = a.actor_id
WHERE c.gender = 'male'
GROUP BY a.name;

```Who is the favorite actor?
Actor being watched most o/en.
Best average rating when being watched.```

SELECT a.name,
COUNT(*) AS number_views,
AVG(r.rating) AS avg_rating
FROM renting as r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
LEFT JOIN actsin as ai
ON r.movie_id = ai.movie_id
LEFT JOIN actors as a
ON ai.actor_id = a.actor_id
WHERE c.gender = 'male'

---------------------------------------------------------
-- Notice the differnce in above and below
-------------------------------------------------------
SELECT a.name,
COUNT(*) AS number_views,
AVG(r.rating) AS avg_rating
FROM renting as r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
LEFT JOIN actsin as ai
ON r.movie_id = ai.movie_id
LEFT JOIN actors as a
ON ai.actor_id = a.actor_id
WHERE c.gender = 'male'
GROUP BY a.name
HAVING AVG(r.rating) IS NOT NULL
ORDER BY avg_rating DESC, number_views DESC;


----------------------------------------------------------------------
--       Identify favorite movies for a group of customers
------------------------------------------------------------------------
```Which is the favorite movie on MovieNow? Answer this question for a specific group of
 customers: for all customers born in the 70s.
```


SELECT m.title, 
COUNT(*),
AVG(r.rating)
FROM renting AS r
LEFT JOIN customers AS c
ON c.customer_id = r.customer_id
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE c.date_of_birth BETWEEN '1970-01-01' AND '1979-12-31'
GROUP BY m.title
HAVING count(*) > 1 -- Remove movies with only one rental
ORDER BY avg desc; -- Order with highest rating first



```Identify favorite actors for Spain
You're now going to explore actor popularity in Spain. Use as alias
 the first letter of the table, except for the table actsin use ai instead.```

SELECT a.name,  c.gender,
       COUNT(*) AS number_views, 
       AVG(r.rating) AS avg_rating
FROM renting as r
LEFT JOIN customers AS c
ON r.customer_id = c.customer_id
LEFT JOIN actsin as ai
ON r.movie_id = ai.movie_id
LEFT JOIN actors as a
ON ai.actor_id = a.actor_id
WHERE c.country = 'Spain' -- Select only customers from Spain
GROUP BY a.name, c.gender
HAVING AVG(r.rating) IS NOT NULL 
  AND COUNT(*) > 5 
ORDER BY avg_rating DESC, number_views DESC;



--------------------------------------------------------------------
--              KPIs per country
----------------------------------------------------------------------------

```In chapter 1 you were asked to provide a report about the development of the company. 
This time you have to prepare a similar report with KPIs for each country separately.
 Your manager is interested in the total number of movie rentals, the average rating of 
 all movies and the total revenue for each country since the beginning of 2019.```



SELECT 
	c.country ,                   -- For each country report
	COUNT(*) AS number_renting, -- The number of movie rentals
	AVG(r.rating) AS average_rating, -- The average rating
	SUM(m.renting_price) AS revenue         -- The revenue from movie rentals
FROM renting AS r
LEFT JOIN customers AS c
ON c.customer_id = r.customer_id
LEFT JOIN movies AS m
ON m.movie_id = r.movie_id
WHERE date_renting >= '2019-01-01'
GROUP BY c.country;



SELECT name
FROM customers
WHERE customer_id IN
(SELECT DISTINCT customer_id
FROM renting
WHERE rating <= 3);

| name |
|-----------------|
| Sidney Généreux |
| Zara Mitchell |



SELECT country, MIN(date_account_start)
FROM customers
GROUP BY country
HAVING MIN(date_account_start) <
(SELECT MIN(date_account_start)
FROM customers
WHERE country = 'Austria');
| country | min |
|---------------|------------|
| Spain | 2017-02-14 |
| Great Britain | 2017-03-31 |


```    Who are the actors in the movie Ray?```
SELECT name
FROM actors
WHERE actor_id IN
(SELECT actor_id
FROM actsin
WHERE movie_id =
(SELECT movie_id
FROM movies
WHERE title='Ray'));
| name |
|------------------|
| Jamie Foxx |
| Kerry Washington |
| Regina King |

-------------------------------------------------------------------------------------
---               Often rented movies
---------------------------------------------------------------------------------------------

```Your manager wants you to make a list of movies excluding those which are hardly ever watched.
This list of movies will be used for advertising. List all movies with more than 5 views using 
a nested query which is a powerful tool to implement selection conditions.```


SELECT *
FROM movies
WHERE movie_id in  -- Select movie IDs from the inner query
	(SELECT movie_id
	FROM renting
	GROUP BY movie_id
	HAVING COUNT(*) > 5)


/*
                OR
*/
SELECT *
FROM movies as m
WHERE 5 <
    (SELECT COUNT(*)
    FROM renting as r
    WHERE r.movie_id=m.movie_id);

---------------------------------------------------------------------------------
--              Frequent customers
-------------------------------------------------------------------------------
```Report a list of customers who frequently rent movies on MovieNow.```

SELECT *
FROM customers
WHERE customer_id in             -- Select all customers with more than 10 movie rentals
	(SELECT customer_id
	FROM renting
	GROUP BY customer_id
	HAVING count(*)>10);

-----------------------------------------------------------------------
--              Movies with rating above average
---------------------------------------------------------------------
```For the advertising campaign your manager also needs a list of popular movies with high ratings. 
Report a list of movies with rating above average.```

SELECT title -- Report the movie titles of all movies with average rating higher than the total average
FROM movies
WHERE movie_id in 
	(SELECT movie_id
	 FROM renting
     GROUP BY movie_id
     HAVING AVG(rating) > 
		(SELECT AVG(rating)
		 FROM renting));

---------------------------------------------------------------------
--      Analyzing customer behavior
---------------------------------------------------------------------
```
A new advertising campaign is going to focus on customers who rented fewer than 5 movies. 
Use a correlated query to extract all customer information for the customers of interest.
```


-- Select customers with less than 5 movie rentals
SELECT *
FROM Customers as c
WHERE 5>  
	(SELECT count(*)
	FROM renting as r
	WHERE r.customer_id = c.customer_id);

---------------------------------------------------------------------
--          Customers who gave low ratings
---------------------------------------------------------------------
```
Identify customers who were not satisfied with movies they watched on MovieNow. 
Report a list of customers with minimum rating smaller than 4.
```
SELECT *
FROM Customers as c
WHERE 4 > -- Select all customers with a minimum rating smaller than 4 
	(SELECT MIN(rating)
	FROM renting AS r
	WHERE r.customer_id = c.customer_id);

---------------------------------------------------------------------
--          Movies and ratings with correlated queries
---------------------------------------------------------------------
```
Report a list of movies that received the most attention on the movie platform, 
(i.e. report all movies with more than 5 ratings and all movies with an average 
rating higher than 8).
```
SELECT *
FROM movies as m
WHERE 5 < -- Select all movies with more than 5 ratings
	(SELECT count(rating)
	FROM renting as r
	WHERE r.movie_id = m.movie_id);

SELECT *
FROM movies AS m
WHERE 8 < -- Select all movies with an average rating higher than 8
	(SELECT AVG(rating)
	FROM renting AS r
	WHERE r.movie_id = m.movie_id);

--------------------------------------------------------------------------------
--                  ``Movies with at least one rating``
-------------------------------------------------------------------------------
SELECT *
FROM movies AS m
WHERE EXISTS
(SELECT *
FROM renting AS r
WHERE rating IS NOT NULL
AND r.movie_id = m.movie_id);

-------------------------------------------------------------------------------
--          Customers with at least one rating
-------------------------------------------------------------------------------

```Having active customers is a key performance indicator for MovieNow. 
Make a list of customers who gave at least one rating.```

SELECT *
FROM customers as c -- Select all customers with at least one rating
WHERE EXISTS
	(SELECT *
	FROM renting AS r
	WHERE rating IS NOT NULL 
	AND r.customer_id = c.customer_id);

-------------------------------------------------------------------------------
--                  Actors in comedies
-------------------------------------------------------------------------------
```
In order to analyze the diversity of actors in comedies, first, report a list of actors who play
 in comedies and then, the number of actors for each nationality playing in comedies.
```

--- Step -1  this is easy now... 
-- stage level - 0 
SELECT *
FROM actors as a
WHERE a.actor_id in 
	(SELECT ai.actor_id
	 FROM actsin AS ai
	 LEFT JOIN movies AS m
	 ON m.movie_id = ai.movie_id
	 WHERE m.genre = 'Comedy'
	 AND ai.actor_id = a.actor_id);

-- stage level - 3

SELECT *
FROM actors as a
WHERE EXISTS
	(SELECT *
	 FROM actsin AS ai
	 LEFT JOIN movies AS m
	 ON m.movie_id = ai.movie_id
	 WHERE m.genre = 'Comedy'
	 AND ai.actor_id = a.actor_id);

-- finally

SELECT a.nationality,
	count(*) -- Report the nationality and the number of actors for each nationality
FROM actors AS a
WHERE EXISTS
	(SELECT ai.actor_id
	 FROM actsin AS ai
	 LEFT JOIN movies AS m
	 ON m.movie_id = ai.movie_id
	 WHERE m.genre = 'Comedy'
	 AND ai.actor_id = a.actor_id)
GROUP by a.nationality;


---------------------------------------------------------------------------------------------
--                          UNION & INTERSECT                 
---------------------------------------------------------------------------------------------
```
Select all actors who are not from the USA and all actors who are born after 1990.```


SELECT name, 
       nationality, 
       year_of_birth
FROM actors
WHERE nationality <> 'USA'
UNION -- Select all actors who are not from the USA and all actors who are born after 1990
SELECT name, 
       nationality, 
       year_of_birth
FROM actors
WHERE year_of_birth > 1990;

SELECT name, 
       nationality, 
       year_of_birth
FROM actors
WHERE nationality <> 'USA'
INTERSECT -- Select all actors who are not from the USA and who are also born after 1990
SELECT name, 
       nationality, 
       year_of_birth
FROM actors
WHERE year_of_birth > 1990;

---------------------------------------------------------------------------------------------
--                          Dramas with high ratings
---------------------------------------------------------------------------------------------
```
The advertising team has a new focus. They want to draw the attention of the customers to dramas. 
Make a list of all movies that are in the drama genre and have an average rating higher than 9.
```
SELECT *
FROM movies
WHERE movie_id in -- Select all movies of genre drama with average rating higher than 9
   (SELECT movie_id
    FROM movies
    WHERE genre = 'Drama'
    INTERSECT
    SELECT movie_id
    FROM renting
    GROUP BY movie_id
    HAVING AVG(rating)>9);







