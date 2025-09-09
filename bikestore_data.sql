CREATE DATABASE bikestore;

USE bikestore;


CREATE TABLE customers (
customer_id INT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
phone VARCHAR(50),
email VARCHAR(50),
street VARCHAR(50),
city VARCHAR(50),
state VARCHAR(50),
zip_code VARCHAR(25)
);

CREATE TABLE stores (
store_id INT PRIMARY KEY,
store_name VARCHAR(100) NOT NULL,
phone VARCHAR(50),
email VARCHAR(50),
street VARCHAR(50),
city VARCHAR(50),
state VARCHAR(50),
zip_code VARCHAR(25)
);

CREATE TABLE staffs (
staff_id INT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL,
phone VARCHAR(50),
active INT,
store_id INT NOT NULL FOREIGN KEY REFERENCES stores(store_id) ,
manager_id INT
);

CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT NOT NULL FOREIGN KEY REFERENCES customers(customer_id),
order_status INT NOT NULL,
order_date DATE NOT NULL,
required_date DATE NOT NULL,
shipped_date DATE,
store_id INT NOT NULL FOREIGN KEY REFERENCES stores(store_id),
staff_id INT NOT NULL FOREIGN KEY REFERENCES staffs(staff_id)
);

ALTER TABLE orders
ALTER COLUMN shipped_date VARCHAR(50);

-- Add this after importing Orders dataset
UPDATE orders
SET shipped_date = NULL
WHERE shipped_date IN ('NULL', '-');

ALTER TABLE orders ALTER COLUMN shipped_date DATE;

CREATE TABLE categories (
category_id INT PRIMARY KEY,
category_name VARCHAR(50) NOT NULL
);

CREATE TABLE brands (
brand_id INT PRIMARY KEY,
brand_name VARCHAR(50) NOT NULL
);

CREATE TABLE products (
product_id INT PRIMARY KEY,
product_name VARCHAR(255) NOT NULL,
brand_id INT NOT NULL FOREIGN KEY REFERENCES brands(brand_id),
category_id INT NOT NULL FOREIGN KEY REFERENCES categories(category_id),
model_year INT,
list_price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE order_items (
order_id INT NOT NULL FOREIGN KEY REFERENCES orders(order_id),
item_id INT NOT NULL,
product_id INT NOT NULL FOREIGN KEY REFERENCES products(product_id),
quantity INT NOT NULL,
list_price DECIMAL(10, 2) NOT NULL,
discount DECIMAL(4, 2) NOT NULL,
CONSTRAINT PK_orderitems PRIMARY KEY (order_id, item_id)
);

CREATE TABLE stocks (
store_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL,
CONSTRAINT PK_stocks PRIMARY KEY (store_id, product_id)
);





