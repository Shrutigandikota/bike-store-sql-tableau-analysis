USE bikestore;

-- Customer and sales insights

-- Top 10 customers by total sales
SELECT TOP 10 c.customer_id, c.first_name, c.last_name,
ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS total_sales
FROM customers c JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_sales DESC;

-- Monthly distribution of sales over time
SELECT DATENAME(month, o.order_date) as month,
YEAR(o.order_date) AS year,
ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS total_sales
FROM orders o JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY YEAR(o.order_date), MONTH(o.order_date),DATENAME(month, o.order_date)
ORDER BY YEAR(o.order_date), MONTH(o.order_date);

-- Sales by customer region
SELECT c.city, c.state, c.zip_code,
ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS total_sales,
COUNT(DISTINCT o.order_id) AS order_count
FROM customers c JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY c.city, c.state, c.zip_code
ORDER BY total_sales DESC;

-- Top 10 cities with highest number of customers
SELECT TOP 10
c.city, c.state, COUNT(DISTINCT c.customer_id) AS customer_count,
COUNT(DISTINCT o.order_id) AS order_count
FROM customers c LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.city, c.state
ORDER BY customer_count DESC;

-- Customer distribution by state
SELECT c.state, 
COUNT(DISTINCT c.customer_id) AS customer_count
FROM customers c LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.state
ORDER BY customer_count DESC;

-- Repeat vs New customers
CREATE VIEW customer_orders AS
SELECT c.customer_id, COUNT(o.order_id) as order_count
FROM customers c JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id;

SELECT CASE
	WHEN order_count = 1 THEN 'New Customer'
	ELSE 'Repeat Customer'
END as customer_type,
COUNT(*) AS  num_customers
FROM customer_orders
GROUP BY CASE
	WHEN order_count = 1 THEN 'New Customer'
	ELSE 'Repeat Customer'
END;

-- Total sales by brand
SELECT b.brand_id, b.brand_name,
ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS total_sales
FROM customers c JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
JOIN products p
ON oi.product_id = p.product_id
JOIN brands b
ON p.brand_id = b.brand_id
GROUP BY b.brand_id, b.brand_name
ORDER BY total_sales DESC;

-- Monthly active customers
SELECT DATENAME(month, o.order_date) as month,
YEAR(o.order_date) AS year,
COUNT(DISTINCT o.customer_id) AS customer_count
FROM orders o
GROUP BY YEAR(o.order_date), MONTH(o.order_date),DATENAME(month, o.order_date)
ORDER BY YEAR(o.order_date), MONTH(o.order_date);


-- KPIs: Sales, Orders, AOV, Customers, Avg revenue per customer

-- Total sales
SELECT ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS total_sales
FROM customers c JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id;

-- Total orders
SELECT COUNT(DISTINCT o.order_id) as total_orders
FROM orders o;

-- Number of customers
SELECT COUNT(DISTINCT c.customer_id) AS customer_count
FROM customers c;

-- Average order value
SELECT 
ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount))/COUNT(DISTINCT o.order_id), 2)
AS average_order_val
FROM orders o JOIN order_items oi
ON o.order_id = oi.order_id;

-- Average revenue per customer
SELECT ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount))/COUNT(DISTINCT c.customer_id), 2)
AS avg_revenue_per_customer
FROM customers c JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id;


