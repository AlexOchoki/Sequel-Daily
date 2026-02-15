-- Q1
-- What is the average checkout wait time in minutes for each Walmart store during July 2024? 
-- Include the store name from the dim_stores table to identify location-specific impacts. 
-- This metric will help determine which stores have longer customer wait times.

-- Explore data
-- fct_checkout_times(store_id, transaction_id, checkout_start_time, checkout_end_time)
-- dim_stores(store_id, store_name, location)

SELECT 
    s.store_name,
    ROUND(
        AVG(DATE_PART('epoch', c.checkout_end_time - c.checkout_start_time) / 60.0)::numeric,
        2
    ) AS avg_checkout_minutes
FROM fct_checkout_times c
JOIN dim_stores s 
    ON s.store_id = c.store_id
WHERE c.checkout_end_time >= '2024-07-01'
  AND c.checkout_end_time <  '2024-08-01'
GROUP BY s.store_name
ORDER BY avg_checkout_minutes DESC;