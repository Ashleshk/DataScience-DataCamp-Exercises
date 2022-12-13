```Accessing data in an ARRAY
In our DVD Rentals database, the film table contains an ARRAY for special_features which has a type of TEXT[]. Much like any ARRAY data type in PostgreSQL, a TEXT[] array can store an array of TEXT values. This comes in handy when you want to store things like phone numbers or email addresses as we saw in the lesson.

Let's take a look at the special_features column and also practice accessing data in the ARRAY.
```
-- Select the title and special features column 
SELECT 
  title, 
  special_features 
FROM film
-- Use the array index of the special_features column
WHERE special_features[2] = 'Deleted Scenes';


```Searching an ARRAY with ANY
As we saw in the video, PostgreSQL also provides the ability to filter results by searching for values in an ARRAY. The ANY function allows you to search for a value in any index position of an ARRAY. Here's an example.

WHERE 'search text' = ANY(array_name)
When using the ANY function, the value you are filtering on appears on the left side of the equation with the name of the ARRAY column as the parameter in the ANY function.
```
SELECT
  title, 
  special_features 
FROM film 
-- Modify the query to use the ANY function 
WHERE 'Trailers' = any (special_features);


/*
Searching an ARRAY with @>
The contains operator @> operator is alternative syntax to the ANY function and matches data in an ARRAY using the following syntax.

WHERE array_name @> ARRAY['search text'] :: type[]
So let's practice using this operator in the exercise.
*/

--Use the contains operator to match the text Deleted Scenes in the special_features column.
SELECT 
  title, 
  special_features 
FROM film 
-- Filter where special_features contains 'Deleted Scenes'
WHERE special_features @> ARRAY['Deleted Scenes'];














