SELECT 
	countries.name AS country, 
	languages.name AS language, 
	percent
FROM languages
RIGHT JOIN countries
USING(code)
ORDER BY language;