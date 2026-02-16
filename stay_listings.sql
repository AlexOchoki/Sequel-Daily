-- As a Product Analyst on the Airbnb Stays team, you are investigating how listing amenities and pricing strategies impact hosts' supplemental income. 
--Your focus is on understanding the influence of features like pools or ocean views, and the effect of cleaning fees on pricing. 
--Your goal is to derive insights that will help build a pricing recommendation framework to optimize potential nightly earnings for hosts.

-- Q1
-- What is the overall average nightly price for listings with either a 'pool' or 'ocean view' in July 2024? 
-- Consider only listings that have been booked at least once during this period.

SELECT AVG(B.nightly_price) AS av_price
FROM fct_bookings b 
JOIN dim_listings l
ON b.listing_id = l.listing_id
WHERE b.booking_date >= '2024-07-01' AND b.booking_date < '2024-08-01'
AND b.booked_nights >= 1
AND (l.amenities LIKE '%pool%' OR l.amenities LIKE '%ocean view%');

--Q2
--For listings with no cleaning fee (i.e., NULL values in the 'cleaning_fee' column), 
--what is the average difference in nightly price compared to listings with a cleaning fee in July 2024?

SELECT 
    AVG(CASE WHEN cleaning_fee IS NULL 
             THEN nightly_price END)
  -
    AVG(CASE WHEN cleaning_fee IS NOT NULL 
             THEN nightly_price END)
    AS avg_price_difference
FROM fct_bookings
WHERE booking_date >= '2024-07-01'
  AND booking_date <  '2024-08-01'
  AND booked_nights >= 1;
