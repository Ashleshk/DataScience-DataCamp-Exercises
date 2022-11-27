SELECT 
    release_year, 
    country, 
    MAX(budget) AS max_budget
FROM films
GROUP BY release_year, country
ORDER BY release_year, country;