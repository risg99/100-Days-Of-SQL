-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Meta (Hard Level) #SQL Interview Question — Solution
-- Write a query to calculate the distribution of comments by the count of users that 
-- joined Meta/Facebook between 2018 and 2020, for the month of January 2020.
-- The output should contain a count of comments and the corresponding number of users 
-- that made that number of comments in Jan-2020. For example, you'll be counting how 
-- many users made 1 comment, 2 comments, 3 comments, 4 comments, etc in Jan-2020. 
-- Your left column in the output will be the number of comments while your right column
-- in the output will be the number of users. Sort the output from the least number of 
-- comments to highest.
-- To add some complexity, there might be a bug where an user post is dated before the user 
-- join date. You'll want to remove these posts from the result.

-- Database setup:
CREATE TABLE FB_USERS (
	CITY_ID BIGINT,
	DEVICE BIGINT,
	ID BIGINT PRIMARY KEY,
	JOINED_AT DATE,
	NAME VARCHAR(255)
);

INSERT INTO
	FB_USERS (CITY_ID, DEVICE, ID, JOINED_AT, NAME)
VALUES
	(101, 1, 1, '2019-06-15', 'Alice'),
	(102, 2, 2, '2020-03-10', 'Bob'),
	(103, 1, 3, '2018-11-25', 'Charlie'),
	(104, 3, 4, '2017-09-05', 'David'),
	(105, 1, 5, '2019-01-20', 'Eve'),
	(106, 2, 6, '2020-01-05', 'Frank');

CREATE TABLE FB_COMMENTS (
	BODY VARCHAR(500),
	CREATED_AT TIMESTAMP,
	USER_ID BIGINT,
	FOREIGN KEY (USER_ID) REFERENCES FB_USERS (ID)
);

INSERT INTO
	FB_COMMENTS (BODY, CREATED_AT, USER_ID)
VALUES
	('Great post!', '2020-01-01 10:00:00', 1),
	('Interesting article', '2020-01-02 12:30:00', 1),
	('Thanks for sharing!', '2020-01-05 08:20:00', 2),
	('Nice update', '2020-01-08 15:45:00', 3),
	('Good job', '2020-01-12 14:00:00', 3),
	('Helpful content', '2020-01-14 09:00:00', 3),
	('Loved it!', '2020-01-18 11:10:00', 5),
	('Noted', '2020-01-20 17:40:00', 6),
	('Cool!', '2020-01-22 08:55:00', 6),
	('Agreed', '2020-01-25 19:30:00', 6),
	('Well written', '2020-01-28 20:45:00', 1),
	('Informative', '2020-01-30 13:50:00', 5),
	('Awesome', '2019-12-31 23:59:00', 2);

-- Query:
WITH
	CTE AS (
		SELECT
			C.USER_ID,
			COUNT(*) AS COUNT
		FROM
			FB_COMMENTS C
			JOIN FB_USERS U ON C.USER_ID = U.ID
		WHERE
			U.JOINED_AT < C.CREATED_AT
			AND EXTRACT(
				YEAR
				FROM
					U.JOINED_AT
			) IN (2018, 2019, 2020)
			AND TO_CHAR(C.CREATED_AT, 'Mon-YYYY') = 'Jan-2020'
		GROUP BY
			C.USER_ID
	)
SELECT
	COUNT AS TOTAL_COMMENTS,
	COUNT(*) AS TOTAL_USERS
FROM
	CTE
GROUP BY
	TOTAL_COMMENTS
ORDER BY
	TOTAL_COMMENTS;

-- Reset Database:
DROP TABLE FB_COMMENTS;
DROP TABLE FB_USERS CASCADE;