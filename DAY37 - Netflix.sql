-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Netflix(Hard Level) #SQL Interview Question — Solution
-- Find all the users who were active for 3 consecutive days or more.

-- Database setup:
CREATE TABLE SF_EVENTS (
	DATE DATE,
	ACCOUNT_ID VARCHAR(10),
	USER_ID VARCHAR(10)
);

INSERT INTO
	SF_EVENTS (DATE, ACCOUNT_ID, USER_ID)
VALUES
	('2021-01-01', 'A1', 'U1'),
	('2021-01-01', 'A1', 'U2'),
	('2021-01-06', 'A1', 'U3'),
	('2021-01-02', 'A1', 'U1'),
	('2020-12-24', 'A1', 'U2'),
	('2020-12-08', 'A1', 'U1'),
	('2020-12-09', 'A1', 'U1'),
	('2021-01-10', 'A2', 'U4'),
	('2021-01-11', 'A2', 'U4'),
	('2021-01-12', 'A2', 'U4'),
	('2021-01-15', 'A2', 'U5'),
	('2020-12-17', 'A2', 'U4'),
	('2020-12-25', 'A3', 'U6'),
	('2020-12-25', 'A3', 'U6'),
	('2020-12-25', 'A3', 'U6'),
	('2020-12-06', 'A3', 'U7'),
	('2020-12-06', 'A3', 'U6'),
	('2021-01-14', 'A3', 'U6'),
	('2021-02-07', 'A1', 'U1'),
	('2021-02-10', 'A1', 'U2'),
	('2021-02-01', 'A2', 'U4'),
	('2021-02-01', 'A2', 'U5'),
	('2020-12-05', 'A1', 'U8');

-- Query:
WITH
	ACTIVE_USERS AS (
		SELECT
			USER_ID,
			LAG(DATE) OVER (
				PARTITION BY
					USER_ID
				ORDER BY
					DATE ASC
			) AS PREV_DATE,
			DATE AS CURR_DATE,
			LEAD(DATE) OVER (
				PARTITION BY
					USER_ID
				ORDER BY
					DATE ASC
			) AS NEXT_DATE
		FROM
			SF_EVENTS
	)
SELECT DISTINCT
	USER_ID
FROM
	ACTIVE_USERS
WHERE
	NEXT_DATE - CURR_DATE = 1
	AND CURR_DATE - PREV_DATE = 1;

-- Reset Database:
DROP TABLE SF_EVENTS;