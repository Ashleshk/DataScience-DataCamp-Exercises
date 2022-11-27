/*
Subquery inside FROM
Subqueries inside FROM can help us select columns from multiple tables in a single query.
Say you are interested in determining the number of languages spoken for each country. 
You want to present this information alongside each country's local_name, which is a
 field only present in the countries table and not in the languages table. You'll use a
  subquery inside FROM to bring information from these two tables together!
*/

--Instruction -1 
--Begin with a query that returns country code from languages, and a count of languages spoken in each country as lang_num.
SELECT code, COUNT(*) AS lang_num
FROM languages
GROUP BY code;

--Instruction -2
--Select local_name from countries, with the aliased lang_num from your subquery (which has been nested and aliased for you as sub).
-- Use WHERE to match the code field from countries and sub.
select local_name, lang_num
from countries,
  (SELECT code, COUNT(*) AS lang_num
  FROM languages
  GROUP BY code) AS sub
-- Where codes match
where countries.code = sub.code
ORDER BY lang_num DESC;


------------------------------------------------------------------------------------------
--Subquery challenge
/*
Suppose you're interested in analyzing inflation and unemployment rate for certain countries in 2015. You are not 
interested in countries with "Republic" or "Monarchy" as their form of government, but are interested in all other forms 
of government, such as emirate federations, socialist states, and commonwealths.

You will use the field gov_form to filter for these two conditions, which represents a country's form of government.
 You can review the different entries for gov_form in the countries table.*/
/*
Instructions:
Select country code, inflation_rate, and unemployment_rate from economies.
Filter code for the set of countries which do not contain the words "Republic" or "Monarchy" in their gov_form.
*/

SELECT 
  code, 
  inflation_rate, 
  unemployment_rate
FROM economies
WHERE year = 2015 
  AND code NOT IN
	(SELECT code
  FROM countries
  WHERE 
    gov_form LIKE '%Republic%'
    OR gov_form LIKE '%Monarchy%')
ORDER BY inflation_rate;