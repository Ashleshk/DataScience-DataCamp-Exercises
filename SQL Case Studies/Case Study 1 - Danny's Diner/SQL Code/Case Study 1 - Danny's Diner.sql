-- This is the solution for 1st case study of the challenge
-- CREATING DATA SET
CREATE TABLE sales (
  "customer_id" VARCHAR(1),
  "order_date" DATE,
  "product_id" INTEGER
);

INSERT INTO sales
  ("customer_id", "order_date", "product_id")
VALUES
  ('A', '2021-01-01', '1'),
  ('A', '2021-01-01', '2'),
  ('A', '2021-01-07', '2'),
  ('A', '2021-01-10', '3'),
  ('A', '2021-01-11', '3'),
  ('A', '2021-01-11', '3'),
  ('B', '2021-01-01', '2'),
  ('B', '2021-01-02', '2'),
  ('B', '2021-01-04', '1'),
  ('B', '2021-01-11', '1'),
  ('B', '2021-01-16', '3'),
  ('B', '2021-02-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-01', '3'),
  ('C', '2021-01-07', '3');
 

CREATE TABLE menu (
  "product_id" INTEGER,
  "product_name" VARCHAR(5),
  "price" INTEGER
);

INSERT INTO menu
  ("product_id", "product_name", "price")
VALUES
  ('1', 'sushi', '10'),
  ('2', 'curry', '15'),
  ('3', 'ramen', '12');
  

CREATE TABLE members (
  "customer_id" VARCHAR(1),
  "join_date" DATE
);

INSERT INTO members
  ("customer_id", "join_date")
VALUES
  ('A', '2021-01-07'),

  ('B', '2021-01-09');


-- SOLUTIONS

--1 Total amount spend by each customer
SELECT S.customer_id, Sum(M.price) AS Total_sales
FROM Menu m
JOIN Sales s
ON m.product_id = s.product_id
GROUP BY S.customer_id;

-- 2. How many days has each customer visited the restaurant?
SELECT customer_id, COUNT(DISTINCT order_date) AS Times_visited
FROM Sales
GROUP BY customer_id;

-- 3. What was the first item from the menu purchased by each customer?
With Rank as
(
Select S.customer_id, 
       M.product_name, 
	   S.order_date,
	   DENSE_RANK() OVER (PARTITION BY S.Customer_ID Order by S.order_date) as rank
From Menu m
Join Sales s
On m.product_id = s.product_id
Group by S.customer_id, M.product_name,S.order_date
)
Select Customer_id, product_name
From Rank
Where rank = 1;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT m.product_name, count(s.product_id) AS times_purchased
FROM Menu m
JOIN Sales s
On m.product_id = s.product_id
GROUP BY m.product_name 
ORDER BY Count(S.product_id) desc 
LIMIT 1;

-- 5. Which item was the most popular for each customer?
With rank as
(
Select S.customer_ID ,
       M.product_name, 
	   Count(S.product_id) as Count,
       Dense_rank()  Over (Partition by S.Customer_ID order by Count(S.product_id) DESC ) as Rank
From Menu m
Join Sales s
On m.product_id = s.product_id
Group by S.customer_id,S.product_id,M.product_name
)
Select Customer_id,Product_name,Count
From rank
Where rank = 1;

-- 6. Which item was purchased first by the customer after they became a member?
WITH Rank as
(
SELECT 
  s.customer_id,
  m.product_name,
  S.order_date,
  Dense_rank() Over (Partition by s.Customer_ID order by s.order_date) as Rank
FROM Sales s
JOIN Menu m 
ON m.product_id = s.product_id
JOIN members mem
ON mem.customer_id = s.customer_id
Where S.order_date >= Mem.join_date
)
SELECT customer_id, product_name, Order_date
From Rank
Where Rank = 1;

-- 7. Which item was purchased just before the customer became a member?
WITH Rank as
(
SELECT 
  s.customer_id,
  m.product_name,
  S.order_date,
  Dense_rank() Over (Partition by s.Customer_ID order by s.order_date desc) as Rank
FROM Sales s
JOIN Menu m 
ON m.product_id = s.product_id
JOIN members mem
ON mem.customer_id = s.customer_id
Where S.order_date < Mem.join_date
)
SELECT customer_id, product_name, Order_date
From Rank
Where Rank = 1;

-- 8. What is the total items and amount spent for each member before they became a member?
SELECT S.customer_id, count(S.product_id) as Items ,Sum(M.price) as total_sales 
FROM Sales S
JOIN Menu M 
ON M.product_id = S.product_id
JOIN members mem
ON mem.customer_id = S.customer_id
Where S.order_date < Mem.join_date
GROUP BY S.customer_id;


-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
WITH points AS
(
SELECT *, CASE WHEN product_id = 1 THEN price*2 
  			   ELSE price*10 
			   END AS points
FROM MENU
)
SELECT S.customer_id, sum(p.points) AS total_points
FROM SALES S
JOIN points p
ON S.product_id = p.product_id
GROUP BY S.customer_id; 


-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

WITH dates AS 
(
   SELECT *, 
   (join_date + INTERVAL '6 day') AS valid_date,
   (date_trunc('month', DATE '2021-01-31') + INTERVAL '1 MONTH - 1 day') AS last_date
   FROM members 
)
Select 
  S.Customer_id, 
  SUM(
	  Case When m.product_ID = 1 THEN m.price*20
		   When S.order_date between D.join_date and D.valid_date Then m.price*20
		   Else m.price*10
		   END 
	 ) as Points
From Dates D
join Sales S
On D.customer_id = S.customer_id
Join Menu M
On M.product_id = S.product_id
Where S.order_date < D.last_date
Group by S.customer_id;
