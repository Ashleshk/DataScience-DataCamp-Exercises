-------------------------------------------------------------------------------------------
--                Subqueries in WHERE
--------------------------------------------------------------------------------------------

--#1 -Select the date, home goals, and away goals in the main query.
--      Filter the main query for matches where the total goals scored exceed the value in the subquery.

SELECT 
	-- Select the date, home goals, and away goals scored
    Date,
	home_goal,
	away_goal
FROM  matches_2013_2014
-- Filter for matches where total goals exceeds 3x the average
WHERE (home_goal + away_goal) > 
       (SELECT 3 * AVG(home_goal + away_goal)
        FROM matches_2013_2014); 

--#2 Create a subquery in the WHERE clause that retrieves all unique hometeam_ID values from the match table.
--   Select the team_long_name and team_short_name from the team table. Exclude all values from the subquery in the main query.
SELECT 
	-- Select the team long and short names
	team_long_name,
	team_short_name
FROM TEAM 
-- Exclude all values from the subquery
WHERE team_api_id NOT in
     (SELECT DISTINCT hometeam_id  FROM MATCH);

--#3 Create a subquery in WHERE clause that retrieves all hometeam_ID values from match with a home_goal score greater than or equal to 8.
--   Select the team_long_name and team_short_name from the team table. Include all values from the subquery in the main query.

SELECT
	-- Select the team long and short names
	team_long_name,
	team_short_name
FROM team
-- Filter for teams with 8 or more home goals
WHERE team_api_id in
	  (SELECT hometeam_ID 
       FROM MATCH
       WHERE home_goal >= 8);
-------------------------------------------------------------------------------------------
--                Subqueries in FROM
--------------------------------------------------------------------------------------------
--#1 Construct a subquery that selects only matches with 10 or more total goals.
--  Inner join the subquery onto country in the main query.
--  Select name from country and count the id column from match

SELECT
	-- Select country name and the count match IDs
    c.name AS country_name,
    COUNT(sub.id) AS matches
FROM country AS c
-- Inner join the subquery onto country
-- Select the country id and match id columns
INNER JOIN (SELECT country_id, id 
           FROM match
           -- Filter the subquery by matches with 10+ goals
           WHERE (home_goal + away_goal) >=10) AS sub
ON c.Id = sub.country_id
GROUP BY country_name;


--#2 Complete the subquery inside the FROM clause. Select the country name from the country table, along with the date, the home goal, the away goal, and the total goals columns from the match table.
--      Create a column in the subquery that adds home and away goals, called total_goals. This will be used to filter the main query.
--      Select the country, date, home goals, and away goals in the main query.
--      Filter the main query for games with 10 or more total goals.

SELECT
	-- Select country, date, home, and away goals from the subquery
    country,
    date,
    home_goal,
    away_goal
FROM 
	-- Select country name, date, home_goal, away_goal, and total goals in the subquery
	(SELECT c.name AS country, 
     	    m.date, 
     		m.home_goal, 
     		m.away_goal,
           (m.home_goal + m.away_goal) AS total_goals
    FROM match AS m
    LEFT JOIN country AS c
    ON m.country_id = c.id) AS subq
-- Filter by total goals scored in the main query
WHERE total_goals >= 10;

-------------------------------------------------------------------------------------------
--                Subqueries in SELECT
--------------------------------------------------------------------------------------------
--#1 In the subquery, select the average total goals by adding home_goal and away_goal.
--      Filter the results so that only the average of goals in the 2013/2014 season is calculated.
--      In the main query, select the average total goals by adding home_goal and away_goal. This calculates the average goals for each league.
--      Filter the results in the main query the same way you filtered the subquery. Group the query by the league name.

SELECT 
	l.name AS league,
    -- Select and round the league's total goals
    ROUND(AVG(m.home_goal + m.away_goal), 2) AS avg_goals,
    -- Select & round the average total goals for the season
    (SELECT ROUND(AVG(home_goal + away_goal), 2) 
     FROM match
     WHERE SEASON = '2013/2014') AS overall_avg
FROM league AS l
LEFT JOIN match AS m
ON l.country_id = m.country_id
-- Filter for the 2013/2014 season
WHERE SEASON = '2013/2014'
GROUP BY league;

--#2 Select the average goals scored in a match for each league in the main query.
--      Select the average goals scored in a match overall for the 2013/2014 season in the subquery.
--      Subtract the subquery from the average number of goals calculated for each league.
--      Filter the main query so that only games from the 2013/2014 season are included.

SELECT
	-- Select the league name and average goals scored
	l.name AS league,
	ROUND(AVG(m.home_goal + m.away_goal),2) AS avg_goals,
    -- Subtract the overall average from the league average
	ROUND(AVG(m.home_goal + m.away_goal) - 
		(SELECT AVG(home_goal + away_goal)
		 FROM match 
         WHERE season = '2013/2014'),2) AS diff
FROM league AS l
LEFT JOIN match AS m
ON l.country_id = m.country_id
-- Only include 2013/2014 results
WHERE season = '2013/2014'
GROUP BY l.name;


-----------------------------------------------------------------------------------------------------
-----------            COMPLEX SUBQUERIES
-----------------------------------------------------------------------------------------------------
-- #1 Extract the average number of home and away team goals in two SELECT subqueries.
--      Calculate the average home and away goals for the specific stage in the main query.
--      Filter both subqueries and the main query so that only data from the 2012/2013 season is included.
--      Group the query by the m.stage column.

SELECT 
	-- Select the stage and average goals for each stage
	m.stage,
    ROUND(AVG(m.home_goal + m.away_goal),2) AS avg_goals,
    -- Select the average overall goals for the 2012/2013 season
    ROUND((SELECT AVG(home_goal + away_goal) 
           FROM match 
           WHERE season = '2012/2013'),2) AS overall
FROM match AS m
-- Filter for the 2012/2013 season
WHERE season = '2012/2013'
-- Group by stage
GROUP BY stage;

--#2 Calculate the average home goals and average away goals from the match table for each stage in the FROM clause subquery.
--      Add a subquery to the WHERE clause that calculates the overall average home goals.
--      Filter the main query for stages where the average home goals is higher than the overall average.
--      Select the stage and avg_goals columns from the s subquery into the main query.

SELECT 
	-- Select the stage and average goals from the subquery
	stage,
	ROUND(avg_goals,2) AS avg_goals
FROM 
	-- Select the stage and average goals in 2012/2013
	(SELECT
		 stage,
         AVG(home_goal + away_goal) AS avg_goals
	 FROM match
	 WHERE season = '2012/2013'
	 GROUP BY stage) AS s
WHERE 
	-- Filter the main query using the subquery
	s.avg_goals > (SELECT AVG(home_goal + away_goal) 
                    FROM match WHERE season = '2012/2013');

-- #3 Create a subquery in SELECT that yields the average goals scored in the 2012/2013 season. Name the new column overall_avg.
--      Create a subquery in FROM that calculates the average goals scored in each stage during the 2012/2013 season.
--      Filter the main query for stages where the average goals exceeds the overall average in 2012/2013. 

SELECT 
	-- Select the stage and average goals from s
	s.stage,
    ROUND(s.avg_goals,2) AS avg_goal,
    -- Select the overall average for 2012/2013
    (SELECT AVG(home_goal + away_goal)  FROM match WHERE season = '2012/2013') as overall_avg
FROM 
	-- Select the stage and average goals in 2012/2013 from match
	(SELECT
		 stage,
         AVG(home_goal + away_goal) AS avg_goals
	 FROM match
	 WHERE season = '2012/2013'
	 GROUP BY stage) AS s
WHERE 
	-- Filter the main query using the subquery
	s.avg_goals > (SELECT AVG(home_goal + away_goal) 
                    FROM match WHERE season = '2012/2013');

