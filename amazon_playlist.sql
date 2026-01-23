-- The Amazon Music Recommendation Team wants to know which playlists have the least number of tracks. 
-- Can you find out the playlist with the minimum number of tracks?

-- Tables
-- playlists(playlist_id, playlist_name, number_of_tracks)
-- playlist_engagement(playlist_id, user_id, listening_time_minutes, engagement_date)

-- just order the playlists by number_of_tracks in ascending order and limit the result to 1.
SELECT  playlist_name
FROM playlists
ORDER BY number_of_tracks ASC
LIMIT 1;


-- Q2
-- We are interested in understanding the engagement level of playlists. Specifically, we want to identify which playlist has the lowest average listening time per track. This means calculating the total listening time for each playlist in October 2024 and then normalizing it by the number of tracks in that playlist. 
-- Can you provide the name of the playlist with the lowest value based on this calculation?

SELECT  p.playlist_name AS playlist_name,
         SUM(pe.listening_time_minutes)/p.number_of_tracks AS avg_duration
FROM playlist_engagement pe
LEFT JOIN playlists p
ON p.playlist_id = pe.playlist_id
WHERE pe.engagement_date >= '2024-10-01' AND pe.engagement_date < '2024-11-01'
GROUP BY p.playlist_name, p.number_of_tracks
ORDER BY avg_duration
LIMIT 1

-- Q3
-- To optimize our recommendations, we need the average monthly listening time per listener for each playlist in October 2024. 
-- For readability, please round down the average listening time to the nearest whole number.

SELECT
    p.playlist_name,
    FLOOR(SUM(pe.listening_time_minutes) * 1.0 / COUNT(DISTINCT pe.user_id)) AS avg_monthly_listening_time_per_listener
FROM playlists p
JOIN playlist_engagement pe
  ON pe.playlist_id = p.playlist_id
WHERE pe.engagement_date >= '2024-10-01'
  AND pe.engagement_date <  '2024-11-01'
GROUP BY p.playlist_id, p.playlist_name
ORDER BY avg_monthly_listening_time_per_listener DESC;