SELECT 
    country,
    ROUND(AVG(budget) , 2) AS average_budget
FROM films
GROUP BY country
HAVING AVG(budget) > 1000000000
ORDER BY average_budget DESC;