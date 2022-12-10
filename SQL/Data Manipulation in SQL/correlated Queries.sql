---#1 Select the country_id, date, home_goal, and away_goal columns in the main query.
--  Complete the AVG value in the subquery.
--  Complete the subquery column references, so that country_id is matched in the main and subquery.


SELECT 
	-- Select country ID, date, home, and away goals from match
	main.country_id,
    main.date,
    main.home_goal, 
    main.away_goal
FROM match AS main
WHERE 
	-- Filter the main query by the subquery
	(home_goal + away_goal) > 
        (SELECT AVG((sub.home_goal + sub.away_goal) * 3)
         FROM match AS sub
         -- Join the main query to the subquery in WHERE
         WHERE main.country_id = sub.country_id);

--- #2 Select the country_id, date, home_goal, and away_goal columns in the main query.
-- Complete the subquery: Select the matches with the highest number of total goals.
-- Match the subquery to the main query using country_id and season.
-- Fill in the correct logical operator so that total goals equals the max goals recorded in the subquery.


SELECT 
	-- Select country ID, date, home, and away goals from match
	main.country_id,
    main.date,
    main.home_goal,
    main.away_goal
FROM match AS main
WHERE 
	-- Filter for matches with the highest number of goals scored
	(home_goal + away_goal) = 
        (SELECT MAX(sub.home_goal + sub.away_goal)
         FROM match AS sub
         WHERE main.country_id = sub.country_id
               AND main.season = sub.season);