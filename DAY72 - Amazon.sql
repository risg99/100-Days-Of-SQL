-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Amazon (Hard Level) #SQL Interview Question — Solution
-- Given the users' sessions logs on a particular day, calculate how many hours 
-- each user was active that day.
-- Note: The session starts when state=1 and ends when state=0.

-- Database setup:
CREATE TABLE CUST_TRACKING (CUST_ID VARCHAR(50), STATE BIGINT, TIME TIMESTAMP);

INSERT INTO
	CUST_TRACKING (CUST_ID, STATE, TIME)
VALUES
	('101', 1, '2024-01-10 08:00:00'),
	('101', 0, '2024-01-10 10:30:00'),
	('101', 1, '2024-01-10 14:00:00'),
	('101', 0, '2024-01-10 15:45:00'),
	('102', 1, '2024-01-10 09:15:00'),
	('102', 0, '2024-01-10 12:00:00'),
	('103', 1, '2024-01-10 07:00:00'),
	('103', 0, '2024-01-10 09:30:00'),
	('103', 1, '2024-01-10 13:00:00'),
	('103', 0, '2024-01-10 16:00:00');

-- Query:
WITH
	ALL_CUSTOMER_DATA AS (
		SELECT
			CUST_ID,
			STATE,
			TIME AS CURR_TIME,
			LEAD(TIME) OVER (
				PARTITION BY
					CUST_ID
				ORDER BY
					TIME
			) AS NEXT_TIME
		FROM
			CUST_TRACKING
	)
SELECT
	CUST_ID,
	ROUND(
		SUM(
			EXTRACT(
				EPOCH
				FROM
					NEXT_TIME - CURR_TIME
			) / 3600.0
		),
		2
	) AS TOTAL_ACTIVE_HOURS
FROM
	ALL_CUSTOMER_DATA
WHERE
	STATE = 1
GROUP BY
	CUST_ID;

-- Reset Database:
DROP TABLE CUST_TRACKING;