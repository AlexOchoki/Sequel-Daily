-- How many unique users have added at least one recommended track to their playlists in October 2024?
-- Tables
-- Explore data
-- tracks_added(interaction_id, user_id, track_id, added_date, is_recommended)
-- users(user_id, user_name)


SELECT
    COUNT(DISTINCT user_id) AS unique_users_with_recommended_tracks
FROM tracks_added
WHERE is_recommended = TRUE
  AND added_date >= '2024-10-01'
  AND added_date <  '2024-11-01';


-- Q2
-- Among the users who added recommended tracks in October 2024, 
-- what is the average number of recommended tracks added to their playlists? 
-- Please round this to 1 decimal place for better readability.

SELECT ROUND(AVG(recommended_count), 1) AS avg_recommended_added
FROM (
    SELECT user_id, COUNT(*) AS recommended_count
    FROM tracks_added
    WHERE added_date >= '2024-10-01'
      AND added_date < '2024-11-01'
      AND is_recommended = TRUE
    GROUP BY user_id
) subquery;

--Q3
---Can you give us the name(s) of users who added a non-recommended track to their playlist on October 2nd, 2024?
SELECT DISTINCT u.user_name
FROM tracks_added t
JOIN users u
  ON u.user_id = t.user_id
WHERE t.is_recommended = FALSE
  AND t.added_date = '2024-10-02';
