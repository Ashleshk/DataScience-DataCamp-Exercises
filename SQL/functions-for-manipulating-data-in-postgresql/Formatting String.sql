-- Concatenate the first_name and last_name and email 
```
Concatenate the first_name and last_name columns separated by a single space followed by email surrounded by < and >.```

-- Concatenate the first_name and last_name and email 
SELECT first_name || ' ' || last_name  || ' <' || email || '>' AS full_email 
FROM customer


-- Concatenate the first_name and last_name and email
SELECT CONCAT(first_name, ' ', last_name,' <', email, '>') AS full_email 
FROM customer


-------------------------------------------------------------------------------------------
--                 String Formatting
--------------------------------------------------------------------------------------------
```Convert the film category name to uppercase.
Convert the first letter of each word in the film's title to upper case.
Concatenate the converted category name and film title separated by a colon.
Convert the description column to lowercase.
```

SELECT 
  -- Concatenate the category name to coverted to uppercase
  -- to the film title converted to title case
  UPPER(c.name)  || ': ' || INITCAP(f.title) AS film_category, 
  -- Convert the description column to lowercase
  LOWER(f.description) AS description
FROM 
  film AS f 
  INNER JOIN film_category AS fc 
  	ON f.film_id = fc.film_id 
  INNER JOIN category AS c 
  	ON fc.category_id = c.category_id;


```Replace all whitespace with an underscore.```
SELECT 
  -- Replace whitespace in the film title with an underscore
  Replace(title, ' ', '_') AS title
FROM film; 

```
Select the title and description columns from the film table.
Find the number of characters in the description column with the alias desc_len.
```
SELECT 
  -- Select the title and description columns
  title,
  description,
  -- Determine the length of the description column
  CHAR_LENGTH(description) AS desc_len
FROM film;

```Select the first 50 characters of the description column with the alias short_desc```
SELECT 
  -- Select the first 50 characters of description
  LEFT(description, 50) AS short_desc
FROM 
  film AS f; 


```Extract only the street address without the street number from the address column.
Use functions to determine the starting and ending position parameters.```

SELECT 
  -- Select only the street name from the address table
  SUBSTRING(address FROM POSITION(' ' IN address)+1 FOR CHAR_LENGTH(address))
FROM 
  address;

```
Extract the characters to the left of the @ of the email column in the customer table and alias it as username.
Now use SUBSTRING to extract the characters after the @ of the email column and alias the new derived field as domain.```


SELECT
  -- Extract the characters to the left of the '@'
  LEFT(email, POSITION('@' IN email)-1) AS username,
  -- Extract the characters to the right of the '@'
  SUBSTRING(email FROM POSITION('@' IN email)+1 FOR CHAR_LENGTH(email)) AS domain
FROM customer;



```Add a single space to the end or right of the first_name column using a padding function.
Use the || operator to concatenate the padded first_name to the last_name column.```
-- Concatenate the padded first_name and last_name 
SELECT 
	RPAD(first_name, LENGTH(first_name)+1) || last_name AS full_name
FROM customer;
```
Now add a single space to the left or beginning of the last_name column using a different padding function than the first step.
Use the || operator to concatenate the first_name column to the padded last_name.```

-- Concatenate the first_name and last_name 
SELECT 
	first_name || LPAD(last_name, LENGTH(last_name)+1) AS full_name
FROM customer; 

```Add a single space to the right or end of the first_name column.
Add the characters < to the right or end of last_name column.
Finally, add the characters > to the right or end of the email column.```

-- Concatenate the first_name and last_name 
SELECT 
	RPAD(first_name, LENGTH(first_name)+1) 
    || RPAD(last_name, LENGTH(last_name)+2, ' <') 
    || RPAD(email, LENGTH(email)+1, '>') AS full_email
FROM customer; 

```
Convert the film category name to uppercase and use the CONCAT() concatenate it with the title.
Truncate the description to the first 50 characters and make sure there is no leading or trailing whitespace after truncating.```
-- Concatenate the uppercase category name and film title
SELECT 
  CONCAT(UPPER(name), ': ', title) AS film_category, 
  -- Truncate the description remove trailing whitespace
  TRIM(LEFT(description, 50)) AS film_desc
FROM 
  film AS f 
  INNER JOIN film_category AS fc 
  	ON f.film_id = fc.film_id 
  INNER JOIN category AS c 
  	ON fc.category_id = c.category_id;


```Get the first 50 characters of the description column
Determine the position of the last whitespace character of the truncated description column and subtract it from the number 50 as the second parameter in the first function above.
```

SELECT 
  UPPER(c.name) || ': ' || f.title AS film_category, 
  -- Truncate the description without cutting off a word
  LEFT(description, 50 - 
    -- Subtract the position of the first whitespace character
    position(
      ' ' IN REVERSE(LEFT(description, 50))
    )
  ) 
FROM 
  film AS f 
  INNER JOIN film_category AS fc 
  	ON f.film_id = fc.film_id 
  INNER JOIN category AS c 
  	ON fc.category_id = c.category_id;











