SELECT title, release_year
FROM films
WHERE (release_year = 1990 OR release_year = 1999) 
    AND (language = 'English' OR language = 'Spanish')
    AND (gross > 2000000);