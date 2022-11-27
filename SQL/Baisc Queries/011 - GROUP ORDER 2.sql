SELECT 
    release_year,
    COUNT(DISTINCT language) AS num_languages
FROM films
GROUP BY release_year
ORDER BY num_languages DESC;

-- Select the country and distinct count of certification as certification_count
SELECT country, COUNT(distinct certification) as certification_count from 
films 
-- Group by country
group by country
-- Filter results to countries with more than 10 different certifications
having COUNT(distinct certification) >10;