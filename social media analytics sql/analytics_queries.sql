-- Analytics Queries for Social Media Platform

-- 1. Total posts per user
SELECT u.username, COUNT(p.post_id) AS total_posts
FROM users u
LEFT JOIN posts p ON u.user_id = p.user_id
GROUP BY u.user_id, u.username
ORDER BY total_posts DESC;

-- 2. Most liked posts
SELECT p.post_id, p.content, u.username AS author, COUNT(l.like_id) AS like_count
FROM posts p
JOIN users u ON p.user_id = u.user_id
LEFT JOIN likes l ON p.post_id = l.post_id
GROUP BY p.post_id, p.content, u.username
ORDER BY like_count DESC;

-- 3. Posts with most comments
SELECT p.post_id, p.content, u.username AS author, COUNT(c.comment_id) AS comment_count
FROM posts p
JOIN users u ON p.user_id = u.user_id
LEFT JOIN comments c ON p.post_id = c.post_id
GROUP BY p.post_id, p.content, u.username
ORDER BY comment_count DESC;

-- 4. User engagement (total likes and comments per post)
SELECT p.post_id, p.content, u.username AS author,
       COUNT(DISTINCT l.like_id) AS like_count,
       COUNT(DISTINCT c.comment_id) AS comment_count,
       (COUNT(DISTINCT l.like_id) + COUNT(DISTINCT c.comment_id)) AS total_engagement
FROM posts p
JOIN users u ON p.user_id = u.user_id
LEFT JOIN likes l ON p.post_id = l.post_id
LEFT JOIN comments c ON p.post_id = c.post_id
GROUP BY p.post_id, p.content, u.username
ORDER BY total_engagement DESC;

-- 5. Followers count per user
SELECT u.username, COUNT(f.following_id) AS follower_count
FROM users u
LEFT JOIN following f ON u.user_id = f.followee_id
GROUP BY u.user_id, u.username
ORDER BY follower_count DESC;

-- 6. Following count per user
SELECT u.username, COUNT(f.following_id) AS following_count
FROM users u
LEFT JOIN following f ON u.user_id = f.follower_id
GROUP BY u.user_id, u.username
ORDER BY following_count DESC;

-- 7. Recent posts (last 7 days)
SELECT p.post_id, p.content, u.username, p.created_at
FROM posts p
JOIN users u ON p.user_id = u.user_id
WHERE p.created_at >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
ORDER BY p.created_at DESC;

-- 8. Top users by total engagement on their posts
SELECT u.username,
       SUM(eng.like_count + eng.comment_count) AS total_engagement
FROM users u
JOIN (
    SELECT p.user_id,
           COUNT(DISTINCT l.like_id) AS like_count,
           COUNT(DISTINCT c.comment_id) AS comment_count
    FROM posts p
    LEFT JOIN likes l ON p.post_id = l.post_id
    LEFT JOIN comments c ON p.post_id = c.post_id
    GROUP BY p.post_id, p.user_id
) eng ON u.user_id = eng.user_id
GROUP BY u.user_id, u.username
ORDER BY total_engagement DESC;

-- 9. Average engagement per post per user
SELECT u.username,
       COUNT(p.post_id) AS total_posts,
       AVG(eng.total_engagement) AS avg_engagement_per_post
FROM users u
LEFT JOIN posts p ON u.user_id = p.user_id
LEFT JOIN (
    SELECT p.post_id,
           (COUNT(DISTINCT l.like_id) + COUNT(DISTINCT c.comment_id)) AS total_engagement
    FROM posts p
    LEFT JOIN likes l ON p.post_id = l.post_id
    LEFT JOIN comments c ON p.post_id = c.post_id
    GROUP BY p.post_id
) eng ON p.post_id = eng.post_id
GROUP BY u.user_id, u.username
HAVING total_posts > 0
ORDER BY avg_engagement_per_post DESC;

-- 10. Posts with no engagement
SELECT p.post_id, p.content, u.username
FROM posts p
JOIN users u ON p.user_id = u.user_id
LEFT JOIN likes l ON p.post_id = l.post_id
LEFT JOIN comments c ON p.post_id = c.post_id
WHERE l.like_id IS NULL AND c.comment_id IS NULL;
