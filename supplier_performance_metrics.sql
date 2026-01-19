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