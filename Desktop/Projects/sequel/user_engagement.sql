-- You are a Data Analyst on the Apple Music Personalization Team. 
-- Your team is focused on evaluating the effectiveness of the recommendation algorithm for artist discovery. 
-- The goal is to analyze user interactions with recommended artists to enhance the recommendation engine and improve user engagement.

-- Question 1 of 3
-- How many unique users have streamed an artist on or after the date it was recommended to them?

SELECT COUNT(DISTINCT us.user_id) AS unique_users
FROM user_streams us
JOIN artist_recommendations ar
  ON us.user_id = ar.user_id
 AND us.artist_id = ar.artist_id
WHERE us.stream_date >= ar.recommendation_date;