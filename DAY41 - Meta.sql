-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Meta/Facebook (Easy Level) #SQL Interview Question — Solution
-- Find all posts which were reacted to with a heart. For such posts output all columns
-- from facebook_posts table.

-- Database setup:
CREATE TABLE FACEBOOK_REACTIONS (
	POSTER INT,
	FRIEND INT,
	REACTION VARCHAR(50),
	DATE_DAY INT,
	POST_ID INT
);

INSERT INTO
	FACEBOOK_REACTIONS (POSTER, FRIEND, REACTION, DATE_DAY, POST_ID)
VALUES
	(1, 2, 'heart', 20240101, 101),
	(2, 3, 'heart', 20240102, 102),
	(3, 4, 'like', 20240103, 103),
	(4, 5, 'heart', 20240104, 104),
	(5, 6, 'laugh', 20240105, 105),
	(6, 7, 'heart', 20240106, 106);

CREATE TABLE FACEBOOK_POSTS (
	POST_ID INT PRIMARY KEY,
	POSTER INT,
	POST_TEXT VARCHAR(500),
	POST_KEYWORDS VARCHAR(200),
	POST_DATE TIMESTAMP
);

INSERT INTO
	FACEBOOK_POSTS (
		POST_ID,
		POSTER,
		POST_TEXT,
		POST_KEYWORDS,
		POST_DATE
	)
VALUES
	(
		101,
		1,
		'Had a great day at the park!',
		'park, fun',
		'2024-01-01 08:00:00'
	),
	(
		102,
		2,
		'Enjoying the new book I bought.',
		'book, reading',
		'2024-01-02 09:00:00'
	),
	(
		103,
		3,
		'Looking forward to the weekend!',
		'weekend, plans',
		'2024-01-03 10:00:00'
	),
	(
		104,
		4,
		'Just finished a workout session!',
		'workout, fitness',
		'2024-01-04 11:00:00'
	),
	(
		105,
		5,
		'Great movie night with friends!',
		'movie, friends',
		'2024-01-05 12:00:00'
	),
	(
		106,
		6,
		'Cooking dinner at home tonight.',
		'cooking, food',
		'2024-01-06 13:00:00'
	);

-- Query:
SELECT
	P.*
FROM
	FACEBOOK_POSTS P
	JOIN FACEBOOK_REACTIONS R ON P.POST_ID = R.POST_ID
WHERE
	R.REACTION = 'heart';

-- Reset Database:
DROP TABLE FACEBOOK_REACTIONS;
DROP TABLE FACEBOOK_POSTS;