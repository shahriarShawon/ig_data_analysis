-- Task 1: Find the 5 oldest users
SELECT *
FROM users
ORDER BY created_at
LIMIT 5;

-- Task 2: What are the two most popular days of the week do the most users registered on?
SELECT 
	DAYNAME(created_at) AS registration_day,
    COUNT(*) AS total_registered
FROM users
GROUP BY registration_day
ORDER BY total_registered DESC
LIMIT 2;

-- Task 3: How many inactive users are there (who have never posted a photo)?
SELECT COUNT(username) AS total_inactive_users
FROM users
LEFT JOIN photos
	ON users.id = photos.user_id
WHERE photos.image_url IS NULL;

-- Task 4: Identify those inactive users (who have never posted a photo)
SELECT username AS inactive_users
FROM users
LEFT JOIN photos
	ON users.id = photos.user_id
WHERE photos.image_url IS NULL;

-- Task 5: Identify the most liked photo the user of that photo
SELECT 
	username,
    photos.image_url,
    COUNT(*) AS total_likes
FROM photos
INNER JOIN likes
	ON photos.id = likes.photo_id
INNER JOIN users
	ON photos.user_id = users.id
GROUP BY photo_id
ORDER BY total_likes DESC
LIMIT 1;

-- Task 6: Calculate the average number of photos per user
SELECT 
	ROUND((SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users)) AS avg_post_per_user;
    
-- Task 7: Find the 5 most popular hashtags used
SELECT 
	tags.tag_name,
    COUNT(*) AS total_used
FROM photo_tags
JOIN tags
	ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY total_used DESC
LIMIT 5;

-- Task 8: Find the bots (users) who have liked all the photos

SELECT 
	username,
    COUNT(*) AS num_likes
FROM users
INNER JOIN likes
	ON users.id = likes.user_id
GROUP BY likes.user_id
HAVING num_likes = 
	(SELECT COUNT(*)
    FROM photos);
    


