USE bikestore;

-- Top 20 products that generate the most revenue
SELECT TOP 20
p.product_id, p.product_name,
ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS product_sales
FROM products p JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY product_sales DESC;


-- Top selling product categories
SELECT c.category_id, c.category_name, 
ROUND(SUM(oi.quantity * oi.list_price * (1 - oi.discount)), 2) AS product_sales
FROM categories c JOIN products p
ON c.category_id = p.category_id
JOIN order_items oi
ON p.product_id = oi.product_id
GROUP BY c.category_id, c.category_name
ORDER BY product_sales DESC;

-- Stores with lowest stock for each product
WITH product_min_stock AS (
SELECT product_id, MIN(quantity) as min_qty
FROM stocks
GROUP BY product_id)
SELECT s.store_id, s.store_name, p.product_name,st.quantity
FROM products p JOIN product_min_stock pms
ON p.product_id = pms.product_id
JOIN stocks st 
ON pms.product_id = st.product_id
AND pms.min_qty = st.quantity
JOIN stores s 
ON st.store_id = s.store_id
ORDER BY st.quantity;

-- Average list price by brand
SELECT b.brand_id, b.brand_name, ROUND(AVG(p.list_price), 2) as avg_list_price
FROM products  p JOIN brands b
ON p.brand_id = b.brand_id
GROUP BY b.brand_id, b.brand_name
ORDER BY avg_list_price;





