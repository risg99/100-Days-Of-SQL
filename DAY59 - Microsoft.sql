-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Microsoft (Medium Level) #SQL Interview Question — Solution
-- Considering a dataset that tracks user interactions with different clients, 
-- identify which clients have users who are exclusively loyal to them (i.e., they 
-- don't interact with any other clients). For each of these clients, calculate the 
-- number of such exclusive users. The output should include the client_id and the
-- corresponding count of exclusive users.

-- Database setup:
CREATE TABLE MEETUP_EVENTS (
	CLIENT_ID VARCHAR(255),
	CUSTOMER_ID VARCHAR(255),
	EVENT_ID BIGINT,
	EVENT_TYPE VARCHAR(255),
	ID BIGINT PRIMARY KEY,
	TIME_ID TIMESTAMP,
	USER_ID VARCHAR(255)
);

INSERT INTO
	MEETUP_EVENTS (
		CLIENT_ID,
		CUSTOMER_ID,
		EVENT_ID,
		EVENT_TYPE,
		ID,
		TIME_ID,
		USER_ID
	)
VALUES
	(
		'C001',
		'CU001',
		101,
		'click',
		1,
		'2025-01-01 10:00:00',
		'U001'
	),
	(
		'C001',
		'CU002',
		102,
		'view',
		2,
		'2025-01-01 11:00:00',
		'U002'
	),
	(
		'C002',
		'CU003',
		103,
		'click',
		3,
		'2025-01-02 10:00:00',
		'U003'
	),
	(
		'C002',
		'CU003',
		104,
		'view',
		4,
		'2025-01-02 11:00:00',
		'U003'
	),
	(
		'C003',
		'CU004',
		105,
		'click',
		5,
		'2025-01-03 10:00:00',
		'U004'
	),
	(
		'C001',
		'CU001',
		106,
		'view',
		6,
		'2025-01-04 10:00:00',
		'U001'
	),
	(
		'C003',
		'CU005',
		107,
		'click',
		7,
		'2025-01-05 10:00:00',
		'U005'
	),
	(
		'C004',
		'CU006',
		108,
		'view',
		8,
		'2025-01-06 10:00:00',
		'U006'
	),
	(
		'C004',
		'CU006',
		109,
		'click',
		9,
		'2025-01-07 10:00:00',
		'U006'
	),
	(
		'C001',
		'CU007',
		110,
		'click',
		10,
		'2025-01-08 10:00:00',
		'U007'
	);

-- Query:
WITH
	LOYAL_CUSTOMERS AS (
		SELECT
			M1.CLIENT_ID AS CLIENT,
			M1.CUSTOMER_ID AS CUSTOMER
		FROM
			MEETUP_EVENTS M1
			JOIN MEETUP_EVENTS M2 ON M1.CUSTOMER_ID = M2.CUSTOMER_ID
			AND M1.CLIENT_ID = M2.CLIENT_ID
	)
SELECT
	CLIENT,
	COUNT(DISTINCT CUSTOMER) AS EXCLUSIVE_USERS
FROM
	LOYAL_CUSTOMERS
GROUP BY
	CLIENT
ORDER BY
	EXCLUSIVE_USERS DESC;

-- Reset Database:
DROP TABLE MEETUP_EVENTS;