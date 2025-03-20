-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Google (Medium Level) #SQL Interview Question — Solution
-- You are analyzing a social network dataset at Google.
-- Your task is to find mutual friends between two users, Karl and Hans. 
-- There is only one user named Karl and one named Hans in the dataset.
-- The output should contain 'user_id' and 'user_name' columns.

-- Database setup:
CREATE TABLE USERS (USER_ID INT, USER_NAME VARCHAR(30));
INSERT INTO
	USERS
VALUES
	(1, 'Karl'),
	(2, 'Hans'),
	(3, 'Emma'),
	(4, 'Emma'),
	(5, 'Mike'),
	(6, 'Lucas'),
	(7, 'Sarah'),
	(8, 'Lucas'),
	(9, 'Anna'),
	(10, 'John');
CREATE TABLE FRIENDS (USER_ID INT, FRIEND_ID INT);
INSERT INTO
	FRIENDS
VALUES
	(1, 3),
	(1, 5),
	(2, 3),
	(2, 4),
	(3, 1),
	(3, 2),
	(3, 6),
	(4, 7),
	(5, 8),
	(6, 9),
	(7, 10),
	(8, 6),
	(9, 10),
	(10, 7),
	(10, 9);

-- Query:
WITH
	KARL_FRIENDS AS (
		SELECT
			FRIEND_ID
		FROM
			FRIENDS
		WHERE
			USER_ID = (
				SELECT
					USER_ID
				FROM
					USERS
				WHERE
					USER_NAME = 'Karl'
			)
	),
	HANS_FRIENDS AS (
		SELECT
			FRIEND_ID
		FROM
			FRIENDS
		WHERE
			USER_ID = (
				SELECT
					USER_ID
				FROM
					USERS
				WHERE
					USER_NAME = 'Hans'
			)
	)
SELECT
	U.USER_ID,
	U.USER_NAME
FROM
	USERS U,
	KARL_FRIENDS KF,
	HANS_FRIENDS HF
WHERE
	KF.FRIEND_ID = U.USER_ID
	AND HF.FRIEND_ID = U.USER_ID;

-- Reset Database:
DROP TABLE USERS;
DROP TABLE FRIENDS;