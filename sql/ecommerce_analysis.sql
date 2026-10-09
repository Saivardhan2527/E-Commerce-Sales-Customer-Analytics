CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    discount_pct NUMERIC(5,2),
    payment_method VARCHAR(50),
    order_status VARCHAR(30),
    cost_price NUMERIC(12,2),
    selling_price NUMERIC(12,2),
    category VARCHAR(100),
    subcategory VARCHAR(100),
    region VARCHAR(50),
    gross_sales NUMERIC(14,2),
    discount_amount NUMERIC(14,2),
    revenue NUMERIC(14,2),
    cost NUMERIC(14,2),
    profit NUMERIC(14,2),
    profit_margin_pct NUMERIC(8,2)
);

CREATE TABLE customers (
    customer_id INT,
    customer_name VARCHAR(100),
    gender VARCHAR(20),
    age INT,
    city VARCHAR(100),
    state VARCHAR(100),
    registration_date DATE
);

DROP TABLE IF EXISTS products;

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(200),
    category VARCHAR(100),
    subcategory VARCHAR(100),
    cost_price NUMERIC(12,2),
    selling_price NUMERIC(12,2)
);


drop table if exists reviews;
CREATE TABLE reviews (
    review_id INT,
    order_id INT,
    rating INT,
    review_date DATE
);

select * from customers;
select * from products;
select * from orders;
select * from reviews;

select count(*) from customers;
select count(*) from products;
select count(*) from orders;
select count(*) from reviews;


-- Check missing values

select count(*) from customers where customer_id = Null;
select count(*) from products where product_id = Null;
select count(*) from orders where revenue = Null;

--duplicates

select count(distinct order_id) from orders;

-- order statuses
select order_status, count(*) as x
from orders
group by order_status
order by x desc;

-- Total business performance

select sum(revenue) total_revenue,
	   sum(profit) tot_profit,
	   sum(quantity) tot_quantity
from orders;

--Overall profit margin

select round(sum(profit) * 100 / nullif(sum(revenue),0),2)
from orders;
-- revenue by cate

select category,sum(revenue) as tot
from orders
group by category
order by tot desc;

select category,
		sum(revenue) as tot_rev,
		sum(profit) *100 / sum(revenue) as margin,
		sum(profit) as profit
from orders
group by category;
		

-- Revenue by region
select region,
		sum(revenue) as tot_rev,
		SUM(profit) AS total_profit
from orders
group by region;

--Payment method analysis

select payment_method,
	   count(*) as transactions,
	   sum(revenue) as tot_revenue,
	   round(sum(revenue) / count(order_id),2)
from orders
group by payment_method;

select payment_method,
		sum(profit) as tot_profit
from orders
group by payment_method;

select payment_method,
		sum(profit) as tot_profit
from orders
group by payment_method
having sum(profit)> 16000000;

select order_id,
		profit,
		case 
			when profit >= 10000 then 'high profit'
			when profit between 5000 and 9999 then 'medium profit'
			else 'low profit'
		end as profit_category
from orders;

select 
		count(*),
		case 
			when profit >= 10000 then 'high profit'
			when profit between 5000 and 9999 then 'medium profit'
			else 'low profit'
		end as profit_category
from orders
group by profit_category;

--DISPLAY
 -- order_id
-- customer_name
-- order_date
-- revenue
select o.order_id,
	   c.customer_name,
	   o.order_date,
	   o.revenue
from customers c inner join orders o
on c.customer_id = o.customer_id;


-- order_id
-- product_name
-- category
-- quantity
-- revenue
select o.order_id,
	   p.product_name,
	   o.quantity,
	   o.revenue,
	   o.category
from products p inner join orders o
on p.product_id = o.product_id;

-- Find the top 10 customers by total revenue.
-- customer_id
-- customer_name
-- total_revenue
select sum(o.revenue) as total_revenue,
	   c.customer_id,
	   c.customer_name
from customers c inner join orders o
on c.customer_id = o.customer_id
group by c.customer_name,
		 c.customer_id
order by total_revenue desc limit 10;

select * from customers

-- Customer with product
-- customer_name
-- product_name
-- category
-- quantity
-- revenue
select c.customer_name,
	   p.product_name,
	   o.quantity,
	   o.revenue,
	   o.category
from products p inner join orders o
on p.product_id = o.product_id

inner join customers c
on c.customer_id = o.customer_id


select * from products
select * from customers
select * from reviews


-- Customers with no orders

select c.customer_name,
	   o.order_id
from customers c left join orders o
on c.customer_id = o.customer_id
where o.order_id is null;

-- find the average rating for every product.
-- product_name
-- average_rating

select 
	   p.product_name,
	   avg (r.rating) as average
from products p inner join orders o
on p.product_id = o.product_id

inner join reviews r
on r.order_id = o.order_id

group by p.product_name

-- more than avg revenue

select oreder_id,revenue 
from orders 
where revenue >(select avg(revenue) 
				from orders);

--Find customers whose total revenue is greater than the average customer revenue.

select customer_id,
	    sum(revenue) as tot
from orders 
group by customer_id
having sum(revenue) > (select avg(revenue) from orders)
order by tot desc;
		

--Find the orders having the highest revenue.
select order_id 
from orders 
where revenue = (select max(revenue) from orders)

--Find customers who have placed an order with revenue greater than ₹100,000.

select customer_id 
from orders 
where customer_id in(select customer_id 
						from orders 
						where revenue > 100000)

--Find customers whose total revenue is greater than the average customer revenue.

select customer_id , sum(revenue) 
from orders 
group by customer_id 
having sum(revenue) >(select avg(sum(revenue)) from orders group by customer_id)

--Find customers whose total revenue is greater than the average customer revenue.

select customer_id, sum(revenue) from orders  group by customer_id
having sum(revenue) > (select avg(average) from (select sum(revenue) as average 
																	from orders group by customer_id)) 
order by sum(revenue);

select * from orders

--Find products whose total quantity sold is greater than the average quantity sold per product.

select product_id, sum(quantity) from orders group by product_id
having sum(quantity) > (select avg(quantity) from orders group by product_id order by avg(quantity) limit 1);

--Practice 1
-- Create a CTE called customer_totals that calculates:
-- customer_id
-- total_revenue
-- Then display the top 10 customers.

with cust_totals as (select sum(revenue) from orders group by customer_id)

select * from cust_totals;

-- Create a CTE called product_sales containing:

-- product_id
-- total_quantity
-- total_revenue

-- Then display products where:

-- total_quantity > 1000

with tot_sales as(select product_id, sum(quantity) tot_quan, sum(revenue) from orders group by product_id)
select product_id from tot_sales where tot_quan > 1000;











