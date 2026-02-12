-- Question 1 of 3
-- What is the average booking cost for corporate travelers? 
-- For this question, let's look only at trips which were booked in January 2024
-- fct_corporate_bookings(booking_id, company_id, employee_id, booking_cost, booking_date, travel_date)
-- dim_companies(company_id, company_name)

SELECT AVG(booking_cost) AS avg_cost
FROM fct_corporate_bookings
WHERE booking_date >= '2024-01-01' AND booking_date < '2024-02-01'


-- Q2
-- Identify the top 5 companies with the highest average booking cost per employee for trips taken during the first quarter of 2024. 
-- Note that if an employee takes multiple trips, each booking will show up as a separate row in fct_corporate_bookings.

SELECT c.company_name,
       AVG(b.booking_cost) AS avg_booking_cost
FROM fct_corporate_bookings b
JOIN dim_companies c 
ON c.company_id = b.company_id
WHERE b.travel_date BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY c.company_name
ORDER BY AVG(b.booking_cost) DESC
LIMIT 5;

-- Q3
-- For bookings made in February 2024, 
-- what percentage of bookings were made more than 30 days in advance? 
-- Use this to recommend strategies for reducing booking costs.

SELECT
    100.0 * 
    SUM(CASE 
            WHEN travel_date - booking_date > 30 THEN 1 
            ELSE 0 
        END)
    / NULLIF(COUNT(*), 0) AS pct_booked_30plus_days
FROM fct_corporate_bookings
WHERE booking_date >= '2024-02-01'
  AND booking_date <  '2024-03-01';