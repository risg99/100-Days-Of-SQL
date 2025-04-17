-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Microsoft (Medium Level) #SQL Interview Question — Solution
-- Write a query that returns the company (customer id column) with highest number of users 
-- that use desktop only.

-- Database setup:
CREATE TABLE FACT_EVENTS (
	ID INT PRIMARY KEY,
	TIME_ID TIMESTAMP,
	USER_ID VARCHAR(50),
	CUSTOMER_ID VARCHAR(50),
	CLIENT_ID VARCHAR(50),
	EVENT_TYPE VARCHAR(50),
	EVENT_ID INT
);

INSERT INTO
	FACT_EVENTS (
		ID,
		TIME_ID,
		USER_ID,
		CUSTOMER_ID,
		CLIENT_ID,
		EVENT_TYPE,
		EVENT_ID
	)
VALUES
	(
		1,
		'2024-12-01 10:00:00',
		'U1',
		'C1',
		'desktop',
		'click',
		101
	),
	(
		2,
		'2024-12-01 11:00:00',
		'U2',
		'C1',
		'mobile',
		'view',
		102
	),
	(
		3,
		'2024-12-01 12:00:00',
		'U3',
		'C2',
		'desktop',
		'click',
		103
	),
	(
		4,
		'2024-12-01 13:00:00',
		'U1',
		'C1',
		'desktop',
		'click',
		104
	),
	(
		5,
		'2024-12-01 14:00:00',
		'U2',
		'C1',
		'tablet',
		'view',
		105
	),
	(
		6,
		'2024-12-01 15:00:00',
		'U4',
		'C3',
		'desktop',
		'click',
		106
	),
	(
		7,
		'2024-12-01 16:00:00',
		'U3',
		'C2',
		'desktop',
		'click',
		107
	),
	(
		8,
		'2024-12-01 17:00:00',
		'U5',
		'C4',
		'desktop',
		'click',
		108
	),
	(
		9,
		'2024-12-01 18:00:00',
		'U6',
		'C4',
		'mobile',
		'view',
		109
	),
	(
		10,
		'2024-12-01 19:00:00',
		'U7',
		'C5',
		'desktop',
		'click',
		110
	);

-- Query:
WITH
	ONLY_DESKTOP AS (
		SELECT
			*
		FROM
			FACT_EVENTS FE
		WHERE
			CUSTOMER_ID NOT IN (
				SELECT
					CUSTOMER_ID
				FROM
					FACT_EVENTS
				WHERE
					CLIENT_ID <> 'desktop'
			)
	)
SELECT
	CUSTOMER_ID,
	COUNT(DISTINCT USER_ID)
FROM
	ONLY_DESKTOP
GROUP BY
	1
ORDER BY
	COUNT(USER_ID) DESC
LIMIT
	1;

-- Reset Database:
DROP TABLE FACT_EVENTS;