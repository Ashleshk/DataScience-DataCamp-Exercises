```How many distinct values of zip appear in at least 100 rows?```

-- Find values of zip that appear in at least 100 rows
-- Also get the count of each value
SELECT zip, COUNT(*)
  FROM evanston311
 GROUP BY zip
HAVING COUNT(*) >= 100; 

```How many distinct values of source appear in at least 100 rows?```
SELECT source, COUNT(*)
  FROM evanston311
 GROUP BY source
HAVING COUNT(*) >= 100; 

-- Find the 5 most common values of street and the count of each
SELECT street, COUNT(*)
  FROM evanston311
 GROUP BY Street
 ORDER BY count(*) DESC
 LIMIT 5;

```
                            Trimming
Some of the street values in evanston311 include house numbers with # or / in them. In addition, 
some street values end in a ..

Remove the house numbers, extra punctuation, and any spaces from the beginning and end of the
 street values as a first attempt at cleaning up the values.```

```Trim digits 0-9, #, /, ., and spaces from the beginning and end of street.
Select distinct original street value and the corrected street value.
Order the results by the original street value.```

SELECT distinct street,
       -- Trim off unwanted characters from street
       trim(street, '0123456789 #/.') AS cleaned_street
  FROM evanston311
 ORDER BY street;

```                 Exploring unstructured text
The description column of evanston311 has the details of the inquiry, while the category column groups inquiries into different types. How well does the category capture what's in the description?

LIKE and ILIKE queries will help you find relevant descriptions and categories. Remember that with LIKE queries, you can include a % on each side of a word to find values that contain the word. For example:

SELECT category
  FROM evanston311
 WHERE category LIKE '%Taxi%';
% matches 0 or more characters.```

```
Use ILIKE to count rows in evanston311 where the description contains 'trash' or 'garbage' regardless of case.```

-- Count rows
SELECT Count(*) 
  FROM evanston311
 -- Where description includes trash or garbage
 WHERE description ILIKE '%trash%'
    OR description ILIKE '%garbage%';

/*
category values are in title case. Use LIKE to find category values with 'Trash' or 'Garbage' in them.
*/

-- Select categories containing Trash or Garbage
SELECT category
  FROM evanston311
 -- Use LIKE
 WHERE category LIKE '%Trash%'
    OR category LIKE '%Garbage%';


/*
Count rows where the description includes 'trash' or 'garbage' but the category does not.
*/
-- Count rows
SELECT COUNT(*)
  FROM evanston311 
 -- description contains trash or garbage (any case)
 WHERE (description ILIKE '%trash%'
    OR description ILIKE '%garbage%') 
 -- category does not contain Trash or Garbage
   AND category NOT LIKE '%Trash%'
   AND category NOT LIKE '%Garbage%';

/*
Find the most common categories for rows with a description about trash that don't have a trash-related category.
*/
-- Count rows with each category
SELECT category, COUNT(*)
  FROM evanston311 
 WHERE (description ILIKE '%trash%'
    OR description ILIKE '%garbage%') 
   AND category NOT LIKE '%Trash%'
   AND category NOT LIKE '%Garbage%'
 -- What are you counting?
 GROUP BY category
 --- order by most frequent values
 ORDER BY COUNT(*) desc
 LIMIT 10;


```                     Concatenate strings
House number (house_num) and street are in two separate columns in evanston311. 
Concatenate them together with concat() with a space in between the values.```

/*
Concatenate house_num, a space ' ', and street into a single value using the concat().
Use a trim function to remove any spaces from the start of the concatenated value.
*/
-- Concatenate house_num, a space, and street
-- and trim spaces from the start of the result
SELECT LTRIM(CONCAT(house_num,' ',street)) AS address
  FROM evanston311;


--Use split_part() to select the first word in street; alias the result as street_name.
--Also select the count of each value of street_name.
SELECT split_part(street, ' ',1) AS street_name, 
       count(*)
  FROM evanston311
 GROUP BY street_name
 ORDER BY count DESC
 LIMIT 20;
/*
Select the first 50 characters of description with '...' concatenated on the end where the length() of the description is greater than 50 characters. Otherwise just select the description as is.
Select only descriptions that begin with the word 'I' and not the letter 'I'.
    For example, you would want to select "I like using SQL!", but would not want to select "In this course we use SQL!".*/

SELECT CASE WHEN length(description) > 50
            THEN left(description, 50) || '...'
       -- otherwise just select description
       ELSE description
       END
  FROM evanston311
 -- limit to descriptions that start with the word I
 WHERE description LIKE 'I %'
 ORDER BY description;

















