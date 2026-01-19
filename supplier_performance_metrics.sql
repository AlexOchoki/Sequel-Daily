-- We need to know who our most active suppliers are. Identify the top 5 suppliers based on the total volume of components delivered in October 2024.

-- Tables used:
-- supplier_deliveries(supplier_id, delivery_date, component_count, manufacturing_region)
-- suppliers(supplier_id, supplier_name)
SELECT
    s.supplier_id,
    s.supplier_name,
    SUM(d.component_count) AS total_components_delivered
FROM supplier_deliveries d
JOIN suppliers s
    ON d.supplier_id = s.supplier_id
WHERE d.delivery_date >= '2024-10-01'
  AND d.delivery_date < '2024-11-01'
GROUP BY
    s.supplier_id,
    s.supplier_name
ORDER BY total_components_delivered DESC
LIMIT 5;


-- Q2:
-- For each region, find the supplier ID that delivered the highest number of components in November 2024. 
-- This will help us understand which supplier is handling the most volume per market.


--- so my approach is to first aggregate the total components delivered by each supplier in each region for November 2024.
---- then I will use a window function to rank suppliers within each region based on their total deliveries.
------ finally, I will select the top-ranked supplier for each region.
WITH supplier_totals AS (
    SELECT
        manufacturing_region AS region,
        supplier_id,
        SUM(component_count) AS total_components
    FROM supplier_deliveries
    WHERE delivery_date >= '2024-11-01'
      AND delivery_date <  '2024-12-01'
    GROUP BY manufacturing_region, supplier_id
),
ranked AS (
    SELECT
        region,
        supplier_id,
        total_components,
        ROW_NUMBER() OVER (
            PARTITION BY region
            ORDER BY total_components DESC, supplier_id
        ) AS rn
    FROM supplier_totals
)
SELECT
    region,
    supplier_id,
    total_components
FROM ranked
WHERE rn = 1
ORDER BY region;

-- Q3
-- We need to identify potential gaps in our supply chain for Asia. 
-- List all suppliers by name who have not delivered any components to the 'Asia' manufacturing region in December 2024.

-- My approach is to first find all suppliers who have made deliveries to Asia in December 2024.
-- Then, RETURN the names of suppliers who are not in that list. 

SELECT s.supplier_name
FROM suppliers s
LEFT JOIN supplier_deliveries d 
  ON s.supplier_id = d.supplier_id 
  AND d.manufacturing_region = 'Asia'
  AND d.delivery_date >= '2024-12-01'
  AND d.delivery_date < '2025-01-01'
WHERE d.supplier_id IS NULL;