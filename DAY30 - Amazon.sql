-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Amazon (Hard Level) #SQL Interview Question — Solution
-- Given the users' sessions logs on a particular day, calculate how many hours 
-- each user was active that day. Note: The session starts when state=1 and ends 
-- when state=0.

-- Database setup:
CREATE TABLE CUSTOMER_STATE_LOG (CUST_ID VARCHAR(10), STATE INT, TIMESTAMP TIME);

INSERT INTO
	CUSTOMER_STATE_LOG (CUST_ID, STATE, TIMESTAMP)
VALUES
	('c001', 1, '07:00:00'),
	('c001', 0, '09:30:00'),
	('c001', 1, '12:00:00'),
	('c001', 0, '14:30:00'),
	('c002', 1, '08:00:00'),
	('c002', 0, '09:30:00'),
	('c002', 1, '11:00:00'),
	('c002', 0, '12:30:00'),
	('c002', 1, '15:00:00'),
	('c002', 0, '16:30:00'),
	('c003', 1, '09:00:00'),
	('c003', 0, '10:30:00'),
	('c004', 1, '10:00:00'),
	('c004', 0, '10:30:00'),
	('c004', 1, '14:00:00'),
	('c004', 0, '15:30:00'),
	('c005', 1, '10:00:00'),
	('c005', 0, '14:30:00'),
	('c005', 1, '15:30:00'),
	('c005', 0, '18:30:00');

-- Query:
WITH
	SESSIONS AS (
		SELECT
			CUST_ID,
			TIMESTAMP AS T,
			LEAD(TIMESTAMP) OVER (
				PARTITION BY
					CUST_ID
				ORDER BY
					TIMESTAMP,
					STATE
			) AS NEXT_T,
			STATE
		FROM
			CUSTOMER_STATE_LOG
	)
SELECT
	CUST_ID,
	ROUND(
		SUM(
			EXTRACT(
				EPOCH
				FROM
					NEXT_T - T
			)
		) / 3600.0,
		1
	) AS ACTIVE_HOURS
FROM
	SESSIONS
WHERE
	STATE = 1
	AND NEXT_T IS NOT NULL
GROUP BY
	CUST_ID;

-- Reset Database:
DROP TABLE CUSTOMER_STATE_LOG;