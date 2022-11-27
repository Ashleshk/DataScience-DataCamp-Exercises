SELECT 
	code AS country_code, 
	year
FROM economies
UNION
SELECT 
	country_code, 
	year
FROM populations
ORDER BY country_code, year;