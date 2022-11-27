SELECT title, release_year
FROM films
WHERE language = 'German'
        AND release_year < 2000;