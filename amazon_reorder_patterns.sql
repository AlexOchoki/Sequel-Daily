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