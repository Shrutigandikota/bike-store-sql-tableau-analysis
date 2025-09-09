USE bikestore;

-- Average time between order date and ship date
SELECT
AVG(DATEDIFF(day, order_date, shipped_date)) as lead_time
FROM orders
WHERE shipped_date IS NOT NULL;

-- Orders not shipped on time
SELECT COUNT(*) as late_shipments
FROM orders
WHERE shipped_date > required_date;



