/*
A basic pivot
You have the following table of Pole Vault gold medalist countries by gender in 2008 and 2012.

| Gender | Year | Country |
|--------|------|---------|
| Men    | 2008 | AUS     |
| Men    | 2012 | FRA     |
| Women  | 2008 | RUS     |
| Women  | 2012 | USA     |
Pivot it by Year to get the following reshaped, cleaner table.

| Gender | 2008 | 2012 |
|--------|------|------|
| Men    | AUS  | FRA  |
| Women  | RUS  | USA  |

*/

/*
Create the correct extension.
Fill in the column names of the pivoted table.*/
-- Create the correct extention to enable CROSSTAB
CREATE EXTENSION IF NOT EXISTS TableFunc;

SELECT * FROM CROSSTAB($$
  SELECT
    Gender, Year, Country
  FROM Summer_Medals
  WHERE
    Year IN (2008, 2012)
    AND Medal = 'Gold'
    AND Event = 'Pole Vault'
  ORDER By Gender ASC, Year ASC;
-- Fill in the correct column names for the pivoted table
$$) AS ct (Gender VARCHAR,
           "2008" VARCHAR,
           "2012" VARCHAR)

ORDER BY Gender ASC;


/**
Count the gold medals that France (FRA), the UK (GBR), and Germany (GER) have earned per country and year.
*/
-- Count the gold medals per country and year
SELECT
  Country,
  Year,
  Count(*) AS Awards
FROM Summer_Medals
WHERE
  Country IN ('FRA', 'GBR', 'GER')
  AND Year IN (2004, 2008, 2012)
  AND Medal = 'Gold'
GROUP BY Country, Year
ORDER BY Country ASC, Year ASC

/*
Select the country and year columns, then rank the three countries by how many gold medals they earned per year.
*/
WITH Country_Awards AS (
  SELECT
    Country,
    Year,
    COUNT(*) AS Awards
  FROM Summer_Medals
  WHERE
    Country IN ('FRA', 'GBR', 'GER')
    AND Year IN (2004, 2008, 2012)
    AND Medal = 'Gold'
  GROUP BY Country, Year)

SELECT
  -- Select Country and Year
  Country,
  Year,
  -- Rank by gold medals earned per year
  rank() Over(Partition BY year Order by Awards Desc) :: INTEGER AS rank
FROM Country_Awards
ORDER BY Country ASC, Year ASC;


/*
Pivot the query's results by Year by filling in the new table's correct column names.
*/

CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT * FROM CROSSTAB($$
  WITH Country_Awards AS (
    SELECT
      Country,
      Year,
      COUNT(*) AS Awards
    FROM Summer_Medals
    WHERE
      Country IN ('FRA', 'GBR', 'GER')
      AND Year IN (2004, 2008, 2012)
      AND Medal = 'Gold'
    GROUP BY Country, Year)

  SELECT
    Country,
    Year,
    RANK() OVER
      (PARTITION BY Year
       ORDER BY Awards DESC) :: INTEGER AS rank
  FROM Country_Awards
  ORDER BY Country ASC, Year ASC;
-- Fill in the correct column names for the pivoted table
$$) AS ct (Country VARCHAR,
           "2004" INTEGER,
           "2008" INTEGER,
           "2012" INTEGER)

Order by Country ASC;



/*
Country-level subtotals
You want to look at three Scandinavian countries' earned gold medals per country and gender in the year
 2004. You're also interested in Country-level subtotals to get the total medals earned 
 for each country, but Gender-level subtotals don't make much sense in this case, so disregard them.
*/
/*
    Count the gold medals awarded per country and gender.
    Generate Country-level gold award counts.
*/
-- Count the gold medals per country and gender
SELECT
  Country,
  Gender,
  COUNT(*) AS Gold_Awards
FROM Summer_Medals
WHERE
  Year = 2004
  AND Medal = 'Gold'
  AND Country IN ('DEN', 'NOR', 'SWE')
-- Generate Country-level subtotals
GROUP BY Country, ROLLUP(gender)
ORDER BY Country ASC, Gender ASC;

/*
All group-level subtotals
You want to break down all medals awarded to Russia in the 2012 Olympic games per gender and medal type. Since the medals all belong to one country, Russia, it makes sense to generate all possible subtotals (Gender- and Medal-level subtotals), as well as a grand total.

Generate a breakdown of the medals awarded to Russia per country and medal type, including all group-level subtotals and a grand total
*/

/*
Count the medals awarded per gender and medal type.
Generate all possible group-level counts (per gender and medal type subtotals and the grand total).*/

-- Count the medals per gender and medal type
SELECT
  Gender,
  Medal,
  count(*) AS Awards
FROM Summer_Medals
WHERE
  Year = 2012
  AND Country = 'RUS'
-- Get all possible group-level subtotals
GROUP BY CUBE(Gender,Medal)
ORDER BY Gender ASC, Medal ASC;

/*
Cleaning up results
Returning to the breakdown of Scandinavian awards you previously made, you want to clean up the results by replacing the nulls with meaningful text.
*/











