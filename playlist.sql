-- How many unique users have added at least one recommended track to their playlists in October 2024?
-- Tables
-- Explore data
-- tracks_added(interaction_id, user_id, track_id, added_date, is_recommended)
-- users(user_id, user_name)


SELECT
    COUNT(DISTINCT user_id) AS unique_users_with_recommended_tracks
FROM tracks_added
WHERE is_recommended = 1
  AND added_date >= '2024-10-01'
  AND added_date <  '2024-11-01';