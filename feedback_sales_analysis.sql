CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50),
    signup_date DATE
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE feedback (
    feedback_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    rating INT,
    comment VARCHAR(255),
    feedback_date DATE
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    sale_date DATE
);


SELECT * FROM feedback;
SELECT * FROM sales;
SELECT * FROM customers;
SELECT * FROM products;


SELECT 
    p.product_name,
    p.category,
    ROUND(AVG(f.rating), 2) AS avg_rating,
    COUNT(f.feedback_id) AS num_reviews
FROM feedback f
JOIN products p ON f.product_id = p.product_id
GROUP BY p.product_name, p.category
ORDER BY avg_rating DESC;

SELECT 
    p.category,
    SUM(s.quantity * p.price) AS total_revenue,
    SUM(s.quantity) AS total_units_sold
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

SELECT 
    c.name,
    f.rating,
    f.comment
FROM feedback f
JOIN customers c ON f.customer_id = c.customer_id
WHERE f.rating < (SELECT AVG(rating) FROM feedback);

SELECT 
    p.category,
    p.product_name,
    SUM(s.quantity * p.price) AS revenue,
    RANK() OVER (PARTITION BY p.category ORDER BY SUM(s.quantity * p.price) DESC) AS rank_in_category
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.category, p.product_name;