SELECT COUNT(DISTINCT title) AS nineties_english_films_for_teens
FROM films
WHERE (release_year BETWEEN 1990 AND 1999)
	AND language = 'English'
	AND certification IN ('G' , 'PG' , 'PG-13');