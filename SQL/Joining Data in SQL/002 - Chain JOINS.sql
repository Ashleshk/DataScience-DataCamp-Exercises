SELECT 
	name, 
	e.year, 
	fertility_rate, 
	unemployment_rate
FROM countries AS c
INNER JOIN populations AS p
ON c.code = p.country_code
INNER JOIN economies AS e
ON c.code = e.code
AND p.year = e.year;