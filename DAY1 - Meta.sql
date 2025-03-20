-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Meta (Hard Level) #SQL Interview Question — Solution
-- A table named “famous” has two columns called user id and follower id. 
-- It represents each user ID has a particular follower ID.
-- These follower IDs are also users of Meta. Then, find the famous percentage of each user. 
-- Famous Percentage = number of followers a user has / total number of users on the platform.

-- Database setup:
CREATE TABLE FAMOUS (USER_ID INT, FOLLOWER_ID INT);
INSERT INTO
	FAMOUS
VALUES
	(1, 2),
	(1, 3),
	(2, 4),
	(5, 1),
	(5, 3),
	(11, 7),
	(12, 8),
	(13, 5),
	(13, 10),
	(14, 12),
	(14, 3),
	(15, 14),
	(15, 13);
	
-- Query:
WITH
	DISTINCT_USERS AS (
		SELECT DISTINCT
			(USER_ID)
		FROM
			FAMOUS
		UNION
		SELECT DISTINCT
			(FOLLOWER_ID)
		FROM
			FAMOUS
	),
	FOLLOWERS_COUNT AS (
		SELECT
			USER_ID,
			COUNT(FOLLOWER_ID) AS FOLLOWERS
		FROM
			FAMOUS
		GROUP BY
			USER_ID
	)
SELECT
	F.USER_ID,
	(F.FOLLOWERS * 100.0) / (
		SELECT
			COUNT(*)
		FROM
			DISTINCT_USERS
	) AS FAMOUS_PERCENTAGE
FROM
	FOLLOWERS_COUNT F
ORDER BY
	F.USER_ID;

-- Reset Database:
DROP TABLE FAMOUS;