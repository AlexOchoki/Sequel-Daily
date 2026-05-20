-- Write an SQL query to calculate the total score for each hacker, where the total score is the sum of their highest score in each challenge. 
-- The query should return the hacker_id, name, and total_score, exclude hackers whose total score is 0, and 
-- sort the results by total_score in descending order and hacker_id in ascending order when scores are tied.
-- Hackers contains hacker_id (INTEGER), name (VARCHAR).
-- Submissions contains submission_id (INTEGER), hacker_id (INTEGER), challenge_id (INTEGER), score (INTEGER).

SELECT 
    h.hacker_id, 
    h.name, 
    SUM(ms.score) AS total_score
    JOIN (
        SELECT 
            hacker_id, 
            challenge_id, 
            MAX(score) AS score
        FROM Submissions
        GROUP BY hacker_id, challenge_id
    ) ms ON h.hacker_id = ms.hacker_id
FROM Hackers h
GROUP BY h.hacker_id, h.name    
HAVING SUM(ms.score) > 0
ORDER BY total_score DESC, h.hacker_id ASC;