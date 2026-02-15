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


-- Q2
-- For the stores with an average checkout wait time exceeding 10 minutes in July 2024, 
-- what are the average checkout wait times in minutes broken down by each hour of the day? 
-- Use the store information from dim_stores to ensure proper identification of each store. 
-- This detail will help pinpoint specific hours when wait times are particularly long.

WITH stores_over_10 AS (
    SELECT c.store_id
    FROM fct_checkout_times c
    WHERE c.checkout_end_time >= '2024-07-01'
      AND c.checkout_end_time <  '2024-08-01'
    GROUP BY c.store_id
    HAVING AVG(DATE_PART('epoch', c.checkout_end_time - c.checkout_start_time) / 60.0) > 10
)
SELECT
    EXTRACT(HOUR FROM c.checkout_end_time) AS hour_,
    s.store_name,
    ROUND(
        AVG(DATE_PART('epoch', c.checkout_end_time - c.checkout_start_time) / 60.0)::numeric,
        2
    ) AS avg_wait_minutes
FROM fct_checkout_times c
JOIN dim_stores s 
  ON c.store_id = s.store_id
JOIN stores_over_10 so
  ON so.store_id = c.store_id
WHERE c.checkout_end_time >= '2024-07-01'
  AND c.checkout_end_time <  '2024-08-01'
GROUP BY s.store_name, hour_
ORDER BY s.store_name, hour_;


-- Q3:
-- Across all stores in July 2024, which hours exhibit the longest average checkout wait times in minutes? 
-- This analysis will guide recommendations for optimal staffing strategies.

SELECT EXTRACT(HOUR FROM checkout_end_time) AS hour_ ,
       AVG(date_part('epoch', checkout_end_time - checkout_start_time)) / 60.0  AS avg_wait_time
FROM fct_checkout_times
WHERE checkout_end_time >= '2024-07-01' AND checkout_end_time < '2024-08-01'
group BY hour_
order by avg_wait_time DESC