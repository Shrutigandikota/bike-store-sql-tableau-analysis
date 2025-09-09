USE bikestore;

-- Highest to lowest store revenues
SELECT s.store_id, s.store_name,
ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS store_revenue
FROM stores s JOIN orders o
ON s.store_id = o.store_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY s.store_id, s.store_name
ORDER BY store_revenue DESC;

-- Staff who generated the highest revenue 
SELECT sf.staff_id, sf.first_name, sf.last_name,
COUNT(o.order_id) as orders_handled,
ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS revenue
FROM staffs sf JOIN orders o
ON sf.staff_id = o.staff_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY sf.staff_id, sf.first_name, sf.last_name
ORDER BY revenue DESC;

-- Monthly orders managed by every staff member
SELECT sf.staff_id, sf.first_name, sf.last_name,
DATENAME(month, o.order_date) AS month,YEAR(o.order_date) AS year,
COUNT(o.order_id) AS order_count
FROM staffs sf JOIN orders o
ON sf.staff_id = o.staff_id
GROUP BY sf.staff_id, sf.first_name, sf.last_name,
YEAR(o.order_date), MONTH(o.order_date),DATENAME(month, o.order_date)
ORDER BY YEAR(o.order_date), MONTH(o.order_date);

