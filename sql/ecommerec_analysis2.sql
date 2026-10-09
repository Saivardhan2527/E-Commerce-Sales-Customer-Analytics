
--Overall Business KPIs
SELECT
    SUM(revenue) AS total_revenue,
    SUM(profit) AS total_profit,
    SUM(quantity) AS total_quantity,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    ROUND(
        SUM(profit) * 100.0 / NULLIF(SUM(revenue), 0),
        2
    ) AS profit_margin_pct
FROM orders;

--Average Order Value
select round(sum(revenue)/count(distinct(order_id)), 2) as AOV from orders;

--Order Status Analysis
SELECT
    order_status,
    COUNT(*) AS transaction_count,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM orders
GROUP BY order_status
ORDER BY transaction_count DESC;

--Revenue by Category
select category,
	   sum(profit) as tot_profit,
	   sum(revenue) as tot_rev,
	   round(((sum(profit)/sum(revenue)) *100),2) as profit_margin
from orders
group by category
order by profit_margin

-- revenue by region
SELECT
    region,
    SUM(revenue) AS total_revenue,
    SUM(profit) AS total_profit,
    ROUND(
        SUM(profit) * 100.0 /
        NULLIF(SUM(revenue), 0),
        2
    ) AS profit_margin_pct
FROM orders
GROUP BY region
ORDER BY total_revenue DESC;


--monthly sales trend
SELECT
    DATE_TRUNC('month', order_date)::date AS month,
    SUM(revenue) AS total_revenue,
    SUM(profit) AS total_profit
FROM orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

--monthly growth
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date)::date AS month,
        SUM(revenue) AS revenue
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
),
monthly_comparison AS (
    SELECT
        month,
        revenue,
        LAG(revenue) OVER (ORDER BY month) AS previous_month_revenue
    FROM monthly_sales
)
SELECT
    month,
    revenue,
    previous_month_revenue,
    ROUND(
        (revenue - previous_month_revenue) * 100.0 /
        NULLIF(previous_month_revenue, 0),
        2
    ) AS mom_growth_pct
FROM monthly_comparison
ORDER BY month;

--top 10 customers
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(o.revenue) AS total_revenue,
    SUM(o.profit) AS total_profit
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_revenue DESC
LIMIT 10;

--top 10 products
SELECT
    p.product_id,
    p.product_name,
    p.category,
    SUM(o.quantity) AS total_quantity,
    SUM(o.revenue) AS total_revenue,
    SUM(o.profit) AS total_profit
FROM products p
INNER JOIN orders o
    ON p.product_id = o.product_id
GROUP BY
    p.product_id,
    p.product_name,
    p.category
ORDER BY total_revenue DESC
LIMIT 10;

--payment method analysis
SELECT
    payment_method,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(revenue) AS total_revenue,
    SUM(profit) AS total_profit
FROM orders
GROUP BY payment_method
ORDER BY total_revenue DESC;

-- rating analysis
SELECT
    p.category,
    ROUND(AVG(r.rating), 2) AS average_rating,
    COUNT(r.review_id) AS review_count
FROM products p
INNER JOIN orders o
    ON p.product_id = o.product_id
INNER JOIN reviews r
    ON o.order_id = r.order_id
GROUP BY p.category
ORDER BY average_rating DESC;


-- repeat customers
SELECT
    customer_id,
    COUNT(DISTINCT order_id) AS order_count
FROM orders
GROUP BY customer_id
ORDER BY order_count DESC;
-----

WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS order_count
    FROM orders
    GROUP BY customer_id
)
SELECT
    CASE
        WHEN order_count = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM customer_orders
GROUP BY
    CASE
        WHEN order_count = 1 THEN 'One-Time Customer'
        ELSE 'Repeat Customer'
    END;

--rfm
WITH customer_rfm AS (
    SELECT
        customer_id,
        MAX(order_date) AS last_purchase_date,
        COUNT(DISTINCT order_id) AS frequency,
        SUM(revenue) AS monetary
    FROM orders
    GROUP BY customer_id
)
SELECT
    customer_id,
    CURRENT_DATE - last_purchase_date AS recency,
    frequency,
    monetary
FROM customer_rfm
ORDER BY monetary DESC;









