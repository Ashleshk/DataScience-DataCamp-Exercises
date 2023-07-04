CREATE SCHEMA pizza_runner;
SET search_path = pizza_runner;

DROP TABLE IF EXISTS runners;
CREATE TABLE runners (
  "runner_id" INTEGER,
  "registration_date" DATE
);

INSERT INTO runners
  ("runner_id", "registration_date")
VALUES
  (1, '2021-01-01'),
  (2, '2021-01-03'),
  (3, '2021-01-08'),
  (4, '2021-01-15');


DROP TABLE IF EXISTS customer_orders;
CREATE TABLE customer_orders (
  "order_id" INTEGER,
  "customer_id" INTEGER,
  "pizza_id" INTEGER,
  "exclusions" VARCHAR(4),
  "extras" VARCHAR(4),
  "order_time" TIMESTAMP
);

INSERT INTO customer_orders
  ("order_id", "customer_id", "pizza_id", "exclusions", "extras", "order_time")
VALUES
  ('1', '101', '1', '', '', '2020-01-01 18:05:02'),
  ('2', '101', '1', '', '', '2020-01-01 19:00:52'),
  ('3', '102', '1', '', '', '2020-01-02 23:51:23'),
  ('3', '102', '2', '', NULL, '2020-01-02 23:51:23'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '1', '4', '', '2020-01-04 13:23:46'),
  ('4', '103', '2', '4', '', '2020-01-04 13:23:46'),
  ('5', '104', '1', 'null', '1', '2020-01-08 21:00:29'),
  ('6', '101', '2', 'null', 'null', '2020-01-08 21:03:13'),
  ('7', '105', '2', 'null', '1', '2020-01-08 21:20:29'),
  ('8', '102', '1', 'null', 'null', '2020-01-09 23:54:33'),
  ('9', '103', '1', '4', '1, 5', '2020-01-10 11:22:59'),
  ('10', '104', '1', 'null', 'null', '2020-01-11 18:34:49'),
  ('10', '104', '1', '2, 6', '1, 4', '2020-01-11 18:34:49');


DROP TABLE IF EXISTS runner_orders;
CREATE TABLE runner_orders (
  "order_id" INTEGER,
  "runner_id" INTEGER,
  "pickup_time" VARCHAR(19),
  "distance" VARCHAR(7),
  "duration" VARCHAR(10),
  "cancellation" VARCHAR(23)
);

INSERT INTO runner_orders
  ("order_id", "runner_id", "pickup_time", "distance", "duration", "cancellation")
VALUES
  ('1', '1', '2020-01-01 18:15:34', '20km', '32 minutes', ''),
  ('2', '1', '2020-01-01 19:10:54', '20km', '27 minutes', ''),
  ('3', '1', '2020-01-03 00:12:37', '13.4km', '20 mins', NULL),
  ('4', '2', '2020-01-04 13:53:03', '23.4', '40', NULL),
  ('5', '3', '2020-01-08 21:10:57', '10', '15', NULL),
  ('6', '3', 'null', 'null', 'null', 'Restaurant Cancellation'),
  ('7', '2', '2020-01-08 21:30:45', '25km', '25mins', 'null'),
  ('8', '2', '2020-01-10 00:15:02', '23.4 km', '15 minute', 'null'),
  ('9', '2', 'null', 'null', 'null', 'Customer Cancellation'),
  ('10', '1', '2020-01-11 18:50:20', '10km', '10minutes', 'null');


DROP TABLE IF EXISTS pizza_names;
CREATE TABLE pizza_names (
  "pizza_id" INTEGER,
  "pizza_name" TEXT
);
INSERT INTO pizza_names
  ("pizza_id", "pizza_name")
VALUES
  (1, 'Meatlovers'),
  (2, 'Vegetarian');


DROP TABLE IF EXISTS pizza_recipes;
CREATE TABLE pizza_recipes (
  "pizza_id" INTEGER,
  "toppings" TEXT
);
INSERT INTO pizza_recipes
  ("pizza_id", "toppings")
VALUES
  (1, '1, 2, 3, 4, 5, 6, 8, 10'),
  (2, '4, 6, 7, 9, 11, 12');


DROP TABLE IF EXISTS pizza_toppings;
CREATE TABLE pizza_toppings (
  "topping_id" INTEGER,
  "topping_name" TEXT
);
INSERT INTO pizza_toppings
  ("topping_id", "topping_name")
VALUES
  (1, 'Bacon'),
  (2, 'BBQ Sauce'),
  (3, 'Beef'),
  (4, 'Cheese'),
  (5, 'Chicken'),
  (6, 'Mushrooms'),
  (7, 'Onions'),
  (8, 'Pepperoni'),
  (9, 'Peppers'),
  (10, 'Salami'),
  (11, 'Tomatoes'),
  (12, 'Tomato Sauce');
  
---      Data Cleaning				
----- Cleaning extras column
SELECT *
FROM customer_orders
;

UPDATE customer_orders
SET extras = CASE
					WHEN extras='' THEN '0'
					WHEN extras IS NULL THEN '0'
					WHEN extras='null' THEN '0'
					ELSE extras
				END;

---------Cleaning exclusions column
UPDATE customer_orders
SET exclusions = CASE
					WHEN exclusions='' THEN '0'
					WHEN exclusions IS NULL THEN '0'
					WHEN exclusions='null' THEN '0'
					ELSE exclusions
				END;

---------Cleaning cancellation column
UPDATE runner_orders
SET cancellation = CASE
					WHEN cancellation='' THEN '0'
					WHEN cancellation IS NULL THEN '0'
					WHEN cancellation='null' THEN '0'
					ELSE cancellation
				END;

---------Cleaning pickup_time column
UPDATE runner_orders
SET pickup_time = CASE
					WHEN pickup_time IS NULL THEN '1970-01-01'
					WHEN pickup_time='null' THEN '1970-01-01'
					ELSE pickup_time
				END;

--changing data type of pickup_time  column
ALTER TABLE runner_orders
ALTER pickup_time DROP DEFAULT,
ALTER COLUMN pickup_time
TYPE timestamp USING pickup_time::timestamp,
ALTER pickup_time SET DEFAULT '1970-01-01 01:00:00'::timestamp;

---------Cleaning distance column
UPDATE runner_orders
SET distance = CASE
					WHEN distance='null' THEN '0'
					ELSE distance
				END;

UPDATE runner_orders 
SET distance=REPLACE(distance,'km','');

ALTER TABLE runner_orders 
ALTER COLUMN distance
TYPE decimal USING distance::decimal;

---------Cleaning duration column
UPDATE runner_orders
SET duration = CASE
					WHEN duration='null' THEN '0'
					ELSE duration
				END;
				
UPDATE runner_orders 
SET duration=REPLACE(duration,'minutes','');

UPDATE runner_orders 
SET duration=REPLACE(duration,'minute','');

UPDATE runner_orders 
SET duration=REPLACE(duration,'mins','');

UPDATE runner_orders 
SET duration=REPLACE(duration,'s','');

--changing data type of duration column
ALTER TABLE runner_orders 
ALTER COLUMN duration
TYPE decimal USING duration::decimal;

-------------------------------------------A. Pizza Metrics-----------------------------
--1.How many pizzas were ordered?
SELECT COUNT(pizza_id) AS "Total number of pizzas ordered"
FROM customer_orders;

--2.How many unique customer orders were made?
SELECT COUNT(DISTINCT(customer_id))
FROM customer_orders;

--3.How many successful orders were delivered by each runner?				
SELECT COUNT(cancellation)
FROM runner_orders
WHERE cancellation!='Restaurant Cancellation' AND cancellation!='Customer Cancellation';

--4.How many of each type of pizza was delivered?
SELECT pizza_name,
COUNT(c.pizza_id)
FROM customer_orders AS c
JOIN pizza_names AS p
ON c.pizza_id=p.pizza_id
JOIN runner_orders AS r
ON c.order_id=r.order_id
WHERE cancellation!='Restaurant Cancellation' AND cancellation!='Customer Cancellation'
GROUP BY pizza_name
;

--5.How many Vegetarian and Meatlovers were ordered by each customer?
SELECT customer_id,
pizza_name,
COUNT(c.pizza_id)
FROM customer_orders AS c
JOIN pizza_names AS p
ON c.pizza_id=p.pizza_id
GROUP BY customer_id,pizza_name
ORDER BY customer_id
;

--6.What was the maximum number of pizzas delivered in a single order?
SELECT order_id, 
COUNT(order_id)
FROM customer_orders
GROUP BY order_id
ORDER BY COUNT(order_id) DESC 
LIMIT 1;

--7.For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
---Customers with change in pizza
SELECT customer_id,
COUNT(pizza_id) 
FROM customer_orders
WHERE exclusions != '0' OR extras != '0' 
GROUP BY customer_id;

---Customers with no change in pizza
SELECT customer_id,
COUNT(pizza_id) 
FROM customer_orders
WHERE exclusions = '0' OR extras = '0' 
GROUP BY customer_id;

--8.How many pizzas were delivered that had both exclusions and extras?
SELECT COUNT(pizza_id) 
FROM customer_orders
WHERE exclusions != '0' AND extras != '0' ;

--9. What was the total volume of pizzas ordered for each hour of the day?
SELECT *
FROM customer_orders;

ALTER TABLE customer_orders
ADD COLUMN Hour Integer;

UPDATE customer_orders
SET Hour=EXTRACT(HR FROM  order_time);

SELECT hour, COUNT(pizza_id) AS "No. of pizzas delivered"
FROM customer_orders
GROUP BY hour
ORDER BY hour;

--10. What was the volume of orders for each day of the week?
ALTER TABLE customer_orders
ADD COLUMN Day Integer;

UPDATE customer_orders
SET Day=EXTRACT(dow FROM  order_time);

SELECT Day, 
COUNT(pizza_id) AS "No. of pizzas delivered"
FROM customer_orders
GROUP BY Day
ORDER BY Day;

--------------------------B. Runner and Customer Experience-----------------------------
--1.How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
WITH CTE AS
(SELECT COUNT(runner_id) AS "No. of runners signed up for 1st week period(2020-12-31 to 2021-01-08)" 
FROM runners
WHERE registration_date BETWEEN '2020-12-31' AND '2021-01-08') 
,CTE1 AS
(SELECT COUNT(runner_id) AS "No. of runners signed up for 2nd week period(2021-01-08 AND 2021-01-14)" 
FROM runners
WHERE registration_date BETWEEN '2021-01-08' AND '2021-01-14') 
SELECT * 
FROM CTE
NATURAL JOIN CTE1;

--2.What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
WITH CTE_avg_time AS (
SELECT runner_id, 
	pickup_time-order_time AS "time taken"
FROM runner_orders AS r
JOIN customer_orders AS c
ON r.order_id=c.order_id
WHERE cancellation='0' )

SELECT runner_id,
AVG("time taken") AS "avg time taken" 
FROM CTE_avg_time
GROUP BY runner_id;

--3.Is there any relationship between the number of pizzas and how long the order takes to prepare?
SELECT pizza_name, 
pickup_time-order_time AS "time taken for order to get ready"
FROM pizza_names AS p
JOIN customer_orders AS c
ON p.pizza_id=c.pizza_id
JOIN runner_orders AS r
ON r.order_id=c.order_id
WHERE cancellation='0' 
ORDER BY pizza_name;
--- Answer: NO

--4.What was the average distance travelled for each customer?
SELECT customer_id, 
ROUND(AVG(distance),2) AS "average distance travelled" 
FROM customer_orders AS c
JOIN runner_orders AS r
ON r.order_id = c.order_id 
GROUP BY customer_id
;

--5.What was the difference between the longest and shortest delivery times for all orders?
SELECT MIN(duration) AS "shortest delivery",
MAX(duration) AS "longest delivery" 
FROM runner_orders
WHERE cancellation='0' ;

--6.What was the average speed for each runner for each delivery and do you notice any trend for these values?
SELECT runner_id,
ROUND(AVG(distance/NULLIF(duration, 0)),2)AS "Average speed" 
FROM runner_orders
GROUP BY runner_id
ORDER BY runner_id;


--7.What is the successful delivery percentage for each runner?
WITH CTE AS(
SELECT runner_id,
	COUNT(order_id)::double precision AS "successful delivery" FROM runner_orders
WHERE cancellation='0' 
GROUP BY runner_id
	),
CTE1 AS(
	SELECT runner_id,
	COUNT(order_id)::double precision AS "total orders"
	FROM runner_orders
	GROUP BY runner_id
	)SELECT CTE.runner_id, 
	("successful delivery"/"total orders")*100 AS "successful delivery percentage"
FROM CTE
JOIN CTE1
ON CTE.runner_id=CTE1.runner_id
ORDER BY runner_id;

---------------------------------C. Ingredient Optimisation------------------------------
--1.What are the standard ingredients for each pizza?
SELECT DISTINCT(pizza_name),
toppings
FROM pizza_names AS pn
NATURAL JOIN pizza_recipes AS pr
;

--2.What was the most commonly added extra?

SELECT extras,
COUNT(extras)
FROM customer_orders
WHERE extras!='0'
GROUP BY extras
ORDER BY COUNT(extras) DESC
LIMIT 1
;
SELECT * 
FROM pizza_toppings
WHERE topping_id=1; 

--Better way of doing it
SELECT * 
FROM pizza_toppings
WHERE topping_id=(
	WITH CTE AS (
		SELECT extras,COUNT(extras)
		FROM customer_orders
		WHERE extras!='0'
		GROUP BY extras
		ORDER BY COUNT(extras) DESC
	
	)SELECT extras FROM CTE
     WHERE count=2)::integer
;

--3.What was the most common exclusion?
SELECT * 
FROM pizza_toppings
WHERE topping_id=(
	WITH CTE AS (SELECT exclusions,
				 COUNT(exclusions)
				 FROM customer_orders
			     WHERE exclusions!='0' AND exclusions != 'null' AND exclusions!=''
				 GROUP BY exclusions
			     ORDER BY COUNT(exclusions) DESC
	)SELECT exclusions 
	 FROM CTE
     WHERE count=4)::integer
;

--4.Generate an order item for each record in the customers_orders table in the format of one
--of the following:
-----Meat Lovers
-----Meat Lovers - Exclude Beef
-----Meat Lovers - Extra Bacon
-----Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers

SELECT order_id,
pizza_name,
CASE
	WHEN extras='0' THEN ''
	WHEN extras='1' THEN 'Extra Bacon'
	WHEN extras='2' THEN 'Extra BBQ Sauce'
	WHEN extras='3' THEN 'Extra Beef'
	WHEN extras='4' THEN 'Extra Cheese'
	WHEN extras='5' THEN 'Extra Chicken'
	WHEN extras='6' THEN 'Extra Mushrooms'
	WHEN extras='7' THEN 'Extra Onions'
	WHEN extras='8' THEN 'Extra Pepperoni'
	WHEN extras='9' THEN 'Extra Peppers'
	WHEN extras='10' THEN 'Extra Salami'
	WHEN extras='11' THEN 'Extra Tomatoes'
	WHEN extras='12' THEN 'Tomato Sauce'
	WHEN extras='1, 5' THEN 'Extra Bacon, Chicken'
	WHEN extras='1, 4' THEN 'Extra Bacon, Cheese'
END extras,
CASE 
	WHEN exclusions = '4' THEN 'Exclude Cheese'
	WHEN exclusions = '2, 6' THEN 'Exclude BBQ Sauce, Mushrooms'
	ELSE ''
END exclusions
FROM customer_orders
NATURAL JOIN pizza_names
ORDER BY order_id ;

SELECT * FROM customer_orders;



--5.Generate an alphabetically ordered comma separated ingredient list for each pizza order 
--from the customer_orders table and add a 2x in front of any relevant ingredients
--For example: "Meat Lovers: 2xBacon, Beef, ... , Salami"
SELECT order_id,
pizza_name,
CASE
	WHEN pizza_id=1 AND (extras='0') AND (exclusions='0') THEN 'Bacon, BBQ Sauce, Beef, Cheese, Chicken, Mushrooms, Pepperoni, Salami'
	WHEN pizza_id=2 AND (extras='0') AND (exclusions='0')THEN 'Cheese, Mushrooms, Onions, Peppers, Tomatoes, Tomato Sauce'
	WHEN (pizza_id=2) AND (extras='1') AND (exclusions='0') THEN '2XCheese, Mushrooms, Onions, Peppers, Tomatoes, Tomato Sauce'
	WHEN (pizza_id=1) AND (extras='1') AND (exclusions='0') THEN '2xBacon, BBQ Sauce, Beef, Cheese, Chicken, Mushrooms, Pepperoni, Salami'
	WHEN (pizza_id=1) AND (extras='1, 5') AND (exclusions='4') THEN '2xBacon, BBQ Sauce, Beef, 2xChicken, Mushrooms, Pepperoni, Salami'
	WHEN (pizza_id=1) AND (extras='1, 4') AND (exclusions='2, 6') THEN '2xBacon, Beef, 2xCheese, Chicken, Pepperoni, Salami'
	WHEN pizza_id=1 AND (extras='0') AND (exclusions='4') THEN 'Bacon, BBQ Sauce, Beef, Chicken, Mushrooms, Pepperoni, Salami'
	WHEN pizza_id=2 AND (extras='0') AND (exclusions='4')THEN 'Mushrooms, Onions, Peppers, Tomatoes, Tomato Sauce'
END ingredients,
exclusions
FROM customer_orders
NATURAL JOIN pizza_names
NATURAL JOIN pizza_recipes


--6.What is the total quantity of each ingredient used in all delivered pizzas sorted by the 
--most frequent first?

---No. of ingredients in each kind of pizza
SELECT pizza_name, 
cardinality(string_to_array(toppings::VARCHAR, ',')) 
FROM pizza_names
NATURAL JOIN pizza_recipes;


CREATE EXTENSION IF NOT EXISTS tablefunc;
SELECT * 
FROM pg_extension;

SELECT * 
FROM CROSSTAB
( ---put the columns in the select statement in the order in which you want the output
  ---i.e. y 1st,x 2nd,v 3rd
  ---Don't forget to use the order by to obtain results in proper order
'
  SELECT order_id,
          topping_name,
          COUNT(topping_name)::INT
  FROM pizza_toppings
  NATURAL JOIN customer_orders
  GROUP BY order_id,topping_name
  ORDER BY order_id
'
) AS T
( ---here write the output column names & their data types
  ---instead of year/x name put its different values name as the different columns
  ---b/c that's how they will appear in the final report
	order_id int,
	"Bacon" INT,
	"BBQ Sauce" INT,
	"Beef" INT,
	"Cheese" INT,
	"Chicken" INT,
	"Mushrooms" INT,
	"Onions" INT,
	"Pepperoni" INT,
	"Peppers" INT,
	"Salami" INT,
	"Tomatoes" INT,
	"Tomato Sauce" INT

);

-----------------------------------------D. Pricing and Ratings-------------------------------
--1.If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for 
--changes - how much money has Pizza Runner made so far if there are no delivery fees?
SELECT pizza_name, 
COUNT(pizza_name), 
CASE
	WHEN pizza_name='Meatlovers' THEN COUNT(pizza_name)*12
	ELSE COUNT(pizza_name)*10
END Total_money,
CASE
	WHEN pizza_name='Meatlovers' THEN (40+120)
	ELSE (40+120)
END Grand_Total
FROM pizza_names 
NATURAL JOIN customer_orders
GROUP BY pizza_name;

SELECT (40+120) --Total money made;

--2.What if there was an additional $1 charge for any pizza extras?
----Add cheese is $1 extra

SELECT pizza_name,
COUNT(pizza_name), 
CASE
	WHEN pizza_name='Meatlovers' THEN COUNT(pizza_name)*(12+5)--5 for 5 extras added to meat pizzas
	ELSE COUNT(pizza_name)*(10+1)--1 for 1 extra added to vegetarian pizza
END Total_money,
CASE
	WHEN pizza_name='Meatlovers' THEN (44+170)
	ELSE (44+170)
END Grand_Total
FROM pizza_names 
NATURAL JOIN customer_orders
GROUP BY pizza_name;

--3.The Pizza Runner team now wants to add an additional ratings system that allows customers 
--to rate their runner, how would you design an additional table for this new dataset - 
--generate a schema for this new table and insert your own data for ratings for each 
--successful customer order between 1 to 5.

CREATE SCHEMA pizza_ratings;
SET search_path = pizza_ratings;

DROP TABLE IF EXISTS ratings;
CREATE TABLE ratings (
  "order_id" INTEGER,
  "rating" DECIMAL
);
INSERT INTO ratings
  ("order_id", "rating")
VALUES
  (1, 5),
  (2, 5),
  (3, 4.5),
  (4, 5),
  (5, 4),
  (7, 3.5),
  (8, 5),
  (10,4);
  
SELECT * FROM ratings;

--4.Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?
	--customer_id
	--order_id
	--runner_id
	--rating
	--order_time
	--pickup_time
	--Time between order and pickup
	--Delivery duration
	--Average speed

WITH CTE AS(
SELECT runner_id,
	ROUND(AVG(distance/NULLIF(duration, 0)),2)AS "Average speed" 
FROM runner_orders
GROUP BY runner_id
ORDER BY runner_id)
SELECT customer_id, 
	c.order_id,
	runner_id,
	r.rating,
	c.order_time,
	pickup_time,
	pickup_time-order_time AS "Time between order and pickup",
	duration AS "Delivery duration",
	"Average speed"
FROM customer_orders AS c
NATURAL JOIN runner_orders 
NATURAL JOIN pizza_ratings.ratings AS r
NATURAL JOIN CTE
	
--5.If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras 
--and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have
--left over after these deliveries?
ALTER TABLE customer_orders
ADD COLUMN pizza_cost double precision;

UPDATE customer_orders
SET pizza_cost = CASE
					WHEN pizza_id=1 THEN 12
					ELSE 10
				 END;

ALTER TABLE runner_orders
ADD COLUMN runner_charges double precision;

UPDATE runner_orders
SET runner_charges = distance*0.30 
------------
WITH CTE AS(
SELECT c.order_id, 
pizza_id,
pizza_cost,
runner_charges,
(pizza_cost-runner_charges) AS "Final_amount"
FROM customer_orders AS c
NATURAL JOIN runner_orders)
SELECT pizza_name, 
SUM(pizza_cost-runner_charges) AS "Final_amount",
(21.46+73.92) AS "Grand Total"
FROM CTE 
NATURAL JOIN pizza_names
GROUP BY pizza_name;

--------------------------------------E. Bonus Questions--------------------------------------
--1.If Danny wants to expand his range of pizzas - how would this impact the existing data 
--design? Write an INSERT statement to demonstrate what would happen if a new Supreme pizza
--with all the toppings was added to the Pizza Runner menu?

INSERT INTO pizza_names
  ("pizza_id", "pizza_name")
VALUES
  (3, 'Supreme pizza');
  
INSERT INTO pizza_recipes
  ("pizza_id", "toppings")
VALUES
  (3, '1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12')
;

SELECT * 
FROM pizza_names
NATURAL JOIN pizza_recipes;


