-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Apple, Microsoft (Hard Level) #SQL Interview Question — Solution
-- Select the most popular client_id based on a count of the number of users who have 
-- at least 50% of their events from the following list: 'video call received', 
-- 'video call sent', 'voice call received', 'voice call sent'.

-- Database setup:
CREATE TABLE FACT_EVENT (
	ID BIGINT PRIMARY KEY,
	TIME_ID TIMESTAMP,
	USER_ID VARCHAR(50),
	CUSTOMER_ID VARCHAR(50),
	CLIENT_ID VARCHAR(50),
	EVENT_TYPE VARCHAR(50),
	EVENT_ID BIGINT
);

INSERT INTO
	FACT_EVENT (
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
		'2024-02-01 10:00:00',
		'U1',
		'C1',
		'CL1',
		'video call received',
		101
	),
	(
		2,
		'2024-02-01 10:05:00',
		'U1',
		'C1',
		'CL1',
		'video call sent',
		102
	),
	(
		3,
		'2024-02-01 10:10:00',
		'U1',
		'C1',
		'CL1',
		'message sent',
		103
	),
	(
		4,
		'2024-02-01 11:00:00',
		'U2',
		'C2',
		'CL2',
		'voice call received',
		104
	),
	(
		5,
		'2024-02-01 11:10:00',
		'U2',
		'C2',
		'CL2',
		'voice call sent',
		105
	),
	(
		6,
		'2024-02-01 11:20:00',
		'U2',
		'C2',
		'CL2',
		'message received',
		106
	),
	(
		7,
		'2024-02-01 12:00:00',
		'U3',
		'C3',
		'CL1',
		'video call sent',
		107
	),
	(
		8,
		'2024-02-01 12:15:00',
		'U3',
		'C3',
		'CL1',
		'voice call received',
		108
	),
	(
		9,
		'2024-02-01 12:30:00',
		'U3',
		'C3',
		'CL1',
		'voice call sent',
		109
	),
	(
		10,
		'2024-02-01 12:45:00',
		'U3',
		'C3',
		'CL1',
		'video call received',
		110
	);

-- Query:
WITH
	USER_EVENT_COUNTS AS (
		SELECT
			USER_ID,
			COUNT(*) AS TOTAL_EVENTS
		FROM
			FACT_EVENT
		GROUP BY
			USER_ID
	),
	FILTERED_EVENT_COUNTS AS (
		SELECT
			USER_ID,
			CLIENT_ID,
			COUNT(*) AS MATCHED_EVENTS
		FROM
			FACT_EVENT
		WHERE
			EVENT_TYPE IN (
				'video call received',
				'video call sent',
				'voice call received',
				'voice call sent'
			)
		GROUP BY
			USER_ID,
			CLIENT_ID
	),
	QUALIFIED_USERS AS (
		SELECT
			F.USER_ID,
			F.CLIENT_ID
		FROM
			FILTERED_EVENT_COUNTS F
			JOIN USER_EVENT_COUNTS U ON F.USER_ID = U.USER_ID
		WHERE
			F.MATCHED_EVENTS >= 0.5 * U.TOTAL_EVENTS
	),
	CLIENT_POPULARITY AS (
		SELECT
			CLIENT_ID,
			COUNT(DISTINCT USER_ID) AS USER_COUNT
		FROM
			QUALIFIED_USERS
		GROUP BY
			CLIENT_ID
	)
SELECT
	CLIENT_ID
FROM
	CLIENT_POPULARITY
ORDER BY
	USER_COUNT DESC
LIMIT
	1;

-- Reset Database:
DROP TABLE FACT_EVENT;