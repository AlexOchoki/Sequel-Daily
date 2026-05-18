
-- You are a Data Analyst in the Physical Stores Pricing Strategy team, working to ensure competitive pricing for essential household items.
--  Your team is focused on categorizing products by price range and understanding sales trends to maintain affordability for customers. 
-- The objective is to use data to identify which price ranges drive the most sales volume, aiding in strategic pricing decisions.

-- Question 1 of 3

-- What is the total sales volume (i.e. total quantity sold) for essential household items in July 2024?
--  Provide the result with a column named 'Total_Sales_Volume'.

SELECT SUM(f.quantity_sold) AS Total_Sales_Volume
FROM fct_sales f 
JOIN dim_products d
ON f.product_id = d.product_id
WHERE d.category = 'Essential Items'
AND f.sale_date >= '01-07-2024' AND f.sale_date < '01-08-2024'
GROUP BY d.category;

-- Question 2:
-- For essential household items sold in July 2024, categorize the items into 'Low', 'Medium', and 'High' price ranges based on their average price. 
-- Use the following criteria: 'Low' for prices below $5, 'Medium' for prices between $5 and $15, and 'High' for prices above $15.

SELECT 
    Price_Range,
    COUNT(*) AS Product_Count
FROM (
    SELECT 
        d.product_id,
        AVG(f.unit_price) AS avg_price,
        CASE 
            WHEN AVG(f.unit_price) < 5 THEN 'Low'
            WHEN AVG(f.unit_price) BETWEEN 5 AND 15 THEN 'Medium'
            ELSE 'High'
        END AS Price_Range
    FROM fct_sales f
    JOIN dim_products d
        ON f.product_id = d.product_id
    WHERE d.category = 'Essential Items'
      AND f.sale_date >= '2024-07-01'
      AND f.sale_date < '2024-08-01'
    GROUP BY d.product_id
) t
GROUP BY Price_Range;

-- Question 3:
-- Identify the price range with the highest total sales volume for essential household items in July 2024. 
-- Use the same criteria as the previous question: 'Low' for prices below $5, 'Medium' for prices between $5 and $15, and 'High' for prices above $15.
-- Provide the result with columns named 'Price_Range' and 'Total_Sales_Volume'.

SELECT CASE WHEN f.unit_price < 5 THEN 'Low'
            WHEN f.unit_price <= 15 THEN 'Medium'
            ELSE 'High'
       END AS Price_Range,
       SUM(f.quantity_sold) AS Total_Sales_Volume
FROM fct_sales f
JOIN dim_products p 
  ON f.product_id = p.product_id
WHERE p.category = 'Essential Household'
  AND f.sale_date >= '2024-07-01' 
  AND f.sale_date < '2024-08-01'
GROUP BY CASE WHEN f.unit_price < 5 THEN 'Low'
             WHEN f.unit_price <= 15 THEN 'Medium'
             ELSE 'High'
        END
ORDER BY Total_Sales_Volume DESC
LIMIT 1;