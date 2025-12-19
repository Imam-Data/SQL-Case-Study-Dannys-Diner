/* ----------------------------------------------------
   CASE STUDY #1: DANNY'S DINER
   Solution by: Imam Ramdhani
   Tool: MySQL
   ----------------------------------------------------*/

-- 1. What is the total amount each customer spent at the restaurant?
SELECT 
    s.customer_id, 
    SUM(m.price) AS total_spent
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id
ORDER BY s.customer_id;

-- 2. How many days has each customer visited the restaurant?
SELECT 
    customer_id, 
    COUNT(DISTINCT order_date) AS visit_count
FROM sales
GROUP BY customer_id;

-- 3. What was the first item from the menu purchased by each customer?
WITH ordered_sales AS (
    SELECT 
        s.customer_id, 
        s.order_date, 
        m.product_name,
        DENSE_RANK() OVER (
            PARTITION BY s.customer_id 
            ORDER BY s.order_date
        ) AS ranking
    FROM sales s
    JOIN menu m ON s.product_id = m.product_id
)
SELECT customer_id, product_name
FROM ordered_sales
WHERE ranking = 1
GROUP BY customer_id, product_name;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?
SELECT 
    m.product_name, 
    COUNT(s.product_id) AS most_purchased
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY m.product_name
ORDER BY most_purchased DESC
LIMIT 1;

-- 5. Which item was the most popular for each customer?
WITH fav_item_cte AS (
    SELECT 
        s.customer_id, 
        m.product_name, 
        COUNT(m.product_id) AS order_count,
        DENSE_RANK() OVER (
            PARTITION BY s.customer_id 
            ORDER BY COUNT(s.customer_id) DESC
        ) AS ranking
    FROM sales s
    JOIN menu m ON s.product_id = m.product_id
    GROUP BY s.customer_id, m.product_name
)
SELECT customer_id, product_name, order_count
FROM fav_item_cte
WHERE ranking = 1;

-- 6. Which item was purchased first by the customer after they became a member?
WITH member_first_cte AS (
    SELECT 
        s.customer_id, 
        m.product_name,
        DENSE_RANK() OVER (
            PARTITION BY s.customer_id 
            ORDER BY s.order_date ASC
        ) AS ranking
    FROM sales s
    JOIN members mem ON s.customer_id = mem.customer_id
    JOIN menu m ON s.product_id = m.product_id
    WHERE s.order_date >= mem.join_date
)
SELECT customer_id, product_name
FROM member_first_cte
WHERE ranking = 1;

-- 7. Which item was purchased just before the customer became a member?
WITH prior_member_cte AS (
    SELECT 
        s.customer_id, 
        m.product_name, 
        s.order_date,
        DENSE_RANK() OVER (
            PARTITION BY s.customer_id 
            ORDER BY s.order_date DESC
        ) AS ranking
    FROM sales s
    JOIN members mem ON s.customer_id = mem.customer_id
    JOIN menu m ON s.product_id = m.product_id
    WHERE s.order_date < mem.join_date
)
SELECT customer_id, product_name, order_date
FROM prior_member_cte
WHERE ranking = 1;

-- 8. What is the total items and amount spent for each member before they became a member?
SELECT 
    s.customer_id, 
    COUNT(s.product_id) AS total_items, 
    SUM(m.price) AS total_spent
FROM sales s
JOIN members mem ON s.customer_id = mem.customer_id
JOIN menu m ON s.product_id = m.product_id
WHERE s.order_date < mem.join_date
GROUP BY s.customer_id;

-- 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
SELECT 
    s.customer_id, 
    SUM(
        CASE 
            WHEN m.product_name = 'sushi' THEN m.price * 10 * 2 
            ELSE m.price * 10 
        END
    ) AS total_points
FROM sales s
JOIN menu m ON s.product_id = m.product_id
GROUP BY s.customer_id;

-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?
SELECT 
    s.customer_id, 
    SUM(
        CASE 
            WHEN s.order_date BETWEEN mem.join_date AND DATE_ADD(mem.join_date, INTERVAL 6 DAY) THEN m.price * 10 * 2 
            WHEN m.product_name = 'sushi' THEN m.price * 10 * 2 
            ELSE m.price * 10 
        END
    ) AS total_points
FROM sales s
JOIN menu m ON s.product_id = m.product_id
JOIN members mem ON s.customer_id = mem.customer_id
WHERE s.order_date <= '2021-01-31'
GROUP BY s.customer_id
ORDER BY s.customer_id;