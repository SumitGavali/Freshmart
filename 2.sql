-- Total orders
select count(distinct order_id)from orders;

--3421083

-- total products 
select count(distinct product_id)as count_of_products from order_products_prior;

--49677


-- total customers
select count(distinct user_id) from orders

--206209


-- list of products highest to lowest
SELECT 
    p.product_name,
    COUNT(order_id) AS total_orders
FROM order_products_prior op
JOIN products p ON op.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_orders DESC
LIMIT 10;

SELECT 
    p.product_name,
    COUNT(order_id) AS total_orders
FROM order_products_prior op
JOIN products p ON op.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_orders asc
LIMIT 10;

-- orders per customer 
select user_id , count(distinct order_id) as total_orders
from orders
group by user_id 
order by total_orders desc;

-- reorder rate
SELECT 
    ROUND(SUM(reordered)::decimal / COUNT(*), 2) AS reorder_rate
FROM order_products_prior;


-- basket size 
SELECT 
    AVG(product_count)
FROM (
    SELECT order_id, COUNT(*) AS product_count
    FROM order_products_prior
    GROUP BY order_id
) t;

-- reorder
SELECT 
    p.product_name,
    SUM(op.reordered) AS reorder_count
FROM order_products_prior op
JOIN products p ON op.product_id = p.product_id
GROUP BY p.product_name
ORDER BY reorder_count DESC
LIMIT 10;


-- orderbyhour
SELECT 
    order_hour_of_day,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_hour_of_day
ORDER BY order_hour_of_day;



SELECT 
    order_dow,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_dow
ORDER BY order_dow;



select * from sales
SELECT corr(target_column, other_column) AS correlation
FROM your_table;

select count(*)-count(days_since_prior_order)as null_finding
from sales ;
-- 2078068

WITH product_revenue AS (
  SELECT
    product_id,
    COUNT(*) AS order_volume
  FROM order_products_prior
  GROUP BY product_id
),
ranked AS (
  SELECT
    product_id,
    order_volume,
    SUM(order_volume) OVER (ORDER BY order_volume DESC) AS cumulative_volume,
    SUM(order_volume) OVER () AS total_volume
  FROM product_revenue
)
SELECT
  COUNT(*) AS product_count,
  MAX(cumulative_volume / total_volume) AS revenue_share
FROM ranked
WHERE cumulative_volume / total_volume <= 0.8;



WITH customer_orders AS (
  SELECT
    user_id,
    COUNT(order_id) AS order_count
  FROM orders
  GROUP BY user_id
)
SELECT
  CASE
    WHEN order_count = 1 THEN 'One-time'
    WHEN order_count BETWEEN 2 AND 4 THEN 'Occasional'
    WHEN order_count BETWEEN 5 AND 10 THEN 'Regular'
    ELSE 'Loyal'
  END AS customer_segment,
  COUNT(*) AS customers,
  ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS percentage
FROM customer_orders
GROUP BY customer_segment
ORDER BY MIN(order_count);




SELECT
  d.department,
  COUNT(*) AS total_orders,
  ROUND(SUM(op.reordered) * 1.0 / COUNT(*), 2) AS reorder_rate
FROM order_products_prior op
JOIN products p ON op.product_id = p.product_id
JOIN departments d ON p.department_id = d.department_id
GROUP BY d.department
HAVING COUNT(*) > 5000
ORDER BY reorder_rate ASC
LIMIT 10;











SELECT
  days_since_prior_order,
  COUNT(*) AS orders
FROM orders
WHERE days_since_prior_order IS NOT NULL
GROUP BY days_since_prior_order
ORDER BY days_since_prior_order;

--top paired product 


WITH pairs AS (
  SELECT
    a.order_id,
    a.product_id AS product_1,
    b.product_id AS product_2
  FROM order_products_prior a
  JOIN order_products_prior b
    ON a.order_id = b.order_id
   AND a.product_id < b.product_id
)
SELECT
  p1.product_name,
  p2.product_name,
  COUNT(*) AS co_occurrence
FROM pairs
JOIN products p1 ON pairs.product_1 = p1.product_id
JOIN products p2 ON pairs.product_2 = p2.product_id
GROUP BY p1.product_name, p2.product_name
ORDER BY co_occurrence DESC
LIMIT 10;



