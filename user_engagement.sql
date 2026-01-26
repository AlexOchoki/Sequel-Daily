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

-- Question 2 of 3
-- What is the average number of times a recommended artist is streamed by users in May 2024? 
-- Similar to the previous question, only include streams on or after the date the artist was recommended to them.

WITH may_post_reco AS (
  SELECT
    us.user_id,
    us.artist_id,
    COUNT(*) AS streams_cnt
  FROM user_streams us
  JOIN artist_recommendations ar
    ON us.user_id = ar.user_id
   AND us.artist_id = ar.artist_id
  WHERE us.stream_date >= '2024-05-01'
    AND us.stream_date <  '2024-06-01'
    AND us.stream_date >= ar.recommendation_date
  GROUP BY us.user_id, us.artist_id
)
SELECT AVG(streams_cnt) AS avg_streams_per_recommended_artist
FROM may_post_reco;