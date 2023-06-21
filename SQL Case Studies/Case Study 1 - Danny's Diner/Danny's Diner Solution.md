# Case Study 1: Danny's Diner

## Solution

[View the complete code](https://github.com/Ashleshk/DataScience-DataCamp-Exercises/blob/main/SQL%20Case%20Studies/Case%20Study%201%20-%20Danny's%20Diner/SQL%20Code/Case%20Study%201%20-%20Danny's%20Diner.sql).

***

### 1. What is the total amount each customer spent at the restaurant?

````sql
SELECT S.customer_id, Sum(M.price) AS Total_sales
FROM Menu m
JOIN Sales s
ON m.product_id = s.product_id
GROUP BY S.customer_id;
````

#### Answer:
| Customer_id | Total_sales |
| ----------- | ----------- |
| A           | 76          |
| B           | 74          |
| C           | 36          |

- Customer A, B and C spent $76, $74 and $36 respectivly.

***

### 2. How many days has each customer visited the restaurant?

````sql
SELECT customer_id, COUNT(DISTINCT order_date) AS Times_visited
FROM Sales
GROUP BY customer_id;
````

#### Answer:
| Customer_id | Times_visited |
| ----------- | ----------- |
| A           | 4          |
| B           | 6          |
| C           | 2          |

- Customer A, B and C visited 4, 6 and 2 times respectivly.

***

### 3. What was the first item from the menu purchased by each customer?

````sql
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
````

#### Answer:
| Customer_id | product_name | 
| ----------- | ----------- |
| A           | curry        | 
| A           | sushi        | 
| B           | curry        | 
| C           | ramen        |

- Customer A's first order is curry and sushi.
- Customer B's first order is curry.
- Customer C's first order is ramen.

***

### 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

````sql
SELECT m.product_name, count(s.product_id) AS times_purchased
FROM Menu m
JOIN Sales s
On m.product_id = s.product_id
GROUP BY m.product_name 
ORDER BY Count(S.product_id) desc 
LIMIT 1;
````



#### Answer:
| Product_name  | Times_Purchased | 
| ----------- | ----------- |
| ramen       | 8|


- Most purchased item on the menu is ramen which is 8 times.

***

### 5. Which item was the most popular for each customer?

````sql
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
````

#### Answer:
| Customer_id | Product_name | Count |
| ----------- | ---------- |------------  |
| A           | ramen        |  3   |
| B           | sushi        |  2   |
| B           | curry        |  2   |
| B           | ramen        |  2   |
| C           | ramen        |  3   |

- Customer A and C's favourite item is ramen while customer B savours all items on the menu. 

***

### 6. Which item was purchased first by the customer after they became a member?

````sql
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
````


#### Answer:
| customer_id |  product_name |order_date
| ----------- | ----------  |----------  |
| A           |  curry        |2021-01-07 |
| B           |  sushi        |2021-01-11 |

After becoming a member 
- Customer A's first order was curry.
- Customer B's first order was sushi.

***

### 7. Which item was purchased just before the customer became a member?

````sql
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
````

#### Answer:
| customer_id |product_name |order_date  |
| ----------- | ----------  |---------- |
| A           |  sushi      |2021-01-01 | 
| A           |  curry      |2021-01-01 | 
| B           |   sushi     |2021-01-04 |

Before becoming a member 
- Customer A’s last order was sushi and curry.
- Customer B’s last order wassushi.

***

### 8. What is the total items and amount spent for each member before they became a member?

````sql
SELECT S.customer_id, count(S.product_id) as Items ,Sum(M.price) as total_sales 
FROM Sales S
JOIN Menu M 
ON M.product_id = S.product_id
JOIN members mem
ON mem.customer_id = S.customer_id
Where S.order_date < Mem.join_date
GROUP BY S.customer_id;

````


#### Answer:
| customer_id |Items | total_sales |
| ----------- | ---------- |----------  |
| A           | 2 |  25       |
| B           | 3 |  40       |

Before becoming a member
- Customer A spent $25 on 2 items.
- Customer B spent $40 on 3 items.

***

### 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier — how many points would each customer have?

````sql
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
````


#### Answer:
| customer_id | Points | 
| ----------- | -------|
| A           | 860 |
| B           | 940 |
| C           | 360 |

- Total points for customer A, B and C are 860, 940 and 360 respectivly.

***

### 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi — how many points do customer A and B have at the end of January?

````sql
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


````

#### Answer:
| Customer_id | Points | 
| ----------- | ---------- |
| A           | 1370 |
| B           | 820 |

- Total points for Customer A and B are 1,370 and 820 respectivly.

***

