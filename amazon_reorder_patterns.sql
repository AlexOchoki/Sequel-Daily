-- Q1
-- To better understand customer preferences, the team needs to know the details of customers who reorder specific products. 
-- Can you retrieve the customer information along with their reordered product code(s) for Q4 2024?

-- fct_orders(order_id, customer_id, product_id, reorder_flag, order_date)
-- dim_products(product_id, product_code, category)
-- dim_customers(customer_id, customer_name)



SELECT   LEFT(p.product_code, 3) AS Product_Cdode,
         COUNT(f.reorder_flag) AS re_order_flag
FROM fct_orders f
JOIN dim_products p 
ON p.product_id = f.product_id
WHERE f.reorder_flag = '1'
AND f.order_date BETWEEN '2024-10-01' AND '2024-12-31'
GROUP BY LEFT(p.product_code, 3)




-- q2
-- To better understand customer preferences, the team needs to know the details of customers who reorder specific products. 
-- Can you retrieve the customer information along with their reordered product code(s) for Q4 2024?

SELECT  c.customer_name,
         p.product_code,
         COUNT(o.product_id) AS order_count
  FROM fct_orders o 
JOIN dim_customers c 
ON o.customer_id = c.customer_id
JOIN dim_products p 
ON o.product_id = p.product_id
WHERE reorder_flag = '1'
AND o.order_date BETWEEN '2024-10-01' AND '2024-12-31'
GROUP BY c.customer_name, p.product_code;


-- Q3
-- When calculating the average reorder frequency, 
-- it's important to handle cases where reorder counts may be missing or zero. 
-- Can you compute the average reorder frequency across the product categories, 
-- ensuring that any missing or null values are appropriately managed for Q4 2024?


WITH product_reorders AS (
    SELECT
        p.category,
        p.product_id,
        COALESCE(SUM(CASE WHEN o.reorder_flag = '1' THEN 1 ELSE 0 END), 0) AS reorder_count
    FROM dim_products p
    LEFT JOIN fct_orders o
        ON p.product_id = o.product_id
       AND o.order_date BETWEEN '2024-10-01' AND '2024-12-31'
    GROUP BY p.category, p.product_id
)

SELECT
    category,
    AVG(reorder_count) AS average_reorder_frequency
FROM product_reorders
GROUP BY category
ORDER BY average_reorder_frequency DESC;
