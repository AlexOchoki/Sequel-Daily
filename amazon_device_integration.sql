-- Q1
-- The team wants to identify the total usage duration of the services for each device type 
-- by extracting the primary device category from the device name for the period from 
-- July 1, 2024 to September 30, 2024. 
-- The primary device category is derived from the first word of the device name.

-- Explore data
-- fct_device_usage(usage_id, device_id, service_id, usage_duration_minutes, usage_date)
-- dim_device(device_id, device_name)
-- dim_service(service_id, service_name)


SELECT
  SPLIT_PART(d.device_name, ' ', 1) AS device_category,
  s.service_name,
  SUM(f.usage_duration_minutes) AS total_usage_duration_minutes
FROM fct_device_usage f
JOIN dim_device d
  ON f.device_id = d.device_id
JOIN dim_service s
  ON f.service_id = s.service_id
WHERE f.usage_date >= '2024-07-01'
  AND f.usage_date <= '2024-09-30'
GROUP BY
  SPLIT_PART(d.device_name, ' ', 1),
  s.service_name
ORDER BY
  device_category,
  total_usage_duration_minutes DESC;

-- Q2
-- The team also wants to label the usage of each device category into 'Low' or 'High' based on usage duration from July 1, 2024 to September 30, 2024. 
-- If the total usage time was less than 300 minutes, we'll category it as 'Low'. Otherwise, we'll categorize it as 'high'. 
-- Can you return a report with device ID, usage category and total usage time?

SELECT   device_id,
          SUM(usage_duration_minutes) AS usage_duration,
          CASE 
             WHEN SUM(usage_duration_minutes) < 300 THEN 'Low' 
             ELSE 'High' END AS usage_category
FROM fct_device_usage
WHERE usage_date >= '2024-07-01' AND usage_date <= '2024-09-30'
GROUP BY device_id