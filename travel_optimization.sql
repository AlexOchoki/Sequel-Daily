-- Question 1 of 3
-- What is the average booking cost for corporate travelers? 
-- For this question, let's look only at trips which were booked in January 2024
-- fct_corporate_bookings(booking_id, company_id, employee_id, booking_cost, booking_date, travel_date)
-- dim_companies(company_id, company_name)

SELECT AVG(booking_cost) AS avg_cost
FROM fct_corporate_bookings
WHERE booking_date >= '2024-01-01' AND booking_date < '2024-02-01'