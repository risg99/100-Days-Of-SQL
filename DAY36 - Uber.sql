-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Uber (Hard Level) #SQL Interview Question — Solution
-- Find the most profitable location. Write a query that calculates the 
-- average signup duration and average transaction amount for each location, 
-- and then compare these two measures together by taking the ratio of the 
-- average transaction amount and average duration for each location.
-- Your output should include the location, average duration, average transaction 
-- amount, and ratio. Sort your results from highest ratio to lowest.

-- Database setup:
CREATE TABLE SIGNUPS (
	SIGNUP_ID INT PRIMARY KEY,
	SIGNUP_START_DATE TIMESTAMP,
	SIGNUP_STOP_DATE TIMESTAMP,
	PLAN_ID INT,
	LOCATION VARCHAR(100)
);

INSERT INTO
	SIGNUPS (
		SIGNUP_ID,
		SIGNUP_START_DATE,
		SIGNUP_STOP_DATE,
		PLAN_ID,
		LOCATION
	)
VALUES
	(
		1,
		'2020-01-01 10:00:00',
		'2020-01-01 12:00:00',
		101,
		'New York'
	),
	(
		2,
		'2020-01-02 11:00:00',
		'2020-01-02 13:00:00',
		102,
		'Los Angeles'
	),
	(
		3,
		'2020-01-03 10:00:00',
		'2020-01-03 14:00:00',
		103,
		'Chicago'
	),
	(
		4,
		'2020-01-04 09:00:00',
		'2020-01-04 10:30:00',
		101,
		'San Francisco'
	),
	(
		5,
		'2020-01-05 08:00:00',
		'2020-01-05 11:00:00',
		102,
		'New York'
	);

CREATE TABLE TRANSACTIONS (
	TRANSACTION_ID INT PRIMARY KEY,
	SIGNUP_ID INT,
	TRANSACTION_START_DATE TIMESTAMP,
	AMT FLOAT,
	FOREIGN KEY (SIGNUP_ID) REFERENCES SIGNUPS (SIGNUP_ID)
);

INSERT INTO
	TRANSACTIONS (
		TRANSACTION_ID,
		SIGNUP_ID,
		TRANSACTION_START_DATE,
		AMT
	)
VALUES
	(1, 1, '2020-01-01 10:30:00', 50.00),
	(2, 1, '2020-01-01 11:00:00', 30.00),
	(3, 2, '2020-01-02 11:30:00', 100.00),
	(4, 2, '2020-01-02 12:00:00', 75.00),
	(5, 3, '2020-01-03 10:30:00', 120.00),
	(6, 4, '2020-01-04 09:15:00', 80.00),
	(7, 5, '2020-01-05 08:30:00', 90.00);

-- Query:
WITH
	DURATION_CTE AS (
		SELECT
			SIGNUP_ID,
			LOCATION,
			(
				(
					EXTRACT(
						HOUR
						FROM
							SIGNUP_STOP_DATE - SIGNUP_START_DATE
					) * 60
				) + (
					EXTRACT(
						MINUTE
						FROM
							SIGNUP_STOP_DATE - SIGNUP_START_DATE
					)
				) + (
					EXTRACT(
						SECOND
						FROM
							SIGNUP_STOP_DATE - SIGNUP_START_DATE
					) / 60
				)
			) AS AVG_MINS
		FROM
			SIGNUPS
		GROUP BY
			SIGNUP_ID,
			LOCATION
	),
	TRANSACTIONS_CTE AS (
		SELECT
			SIGNUP_ID,
			AVG(AMT) AS AVG_AMT
		FROM
			TRANSACTIONS
		GROUP BY
			SIGNUP_ID
	)
SELECT
	D.LOCATION,
	AVG(D.AVG_MINS) AS AVG_SIGNUP_DURATION,
	AVG(COALESCE(T.AVG_AMT, 0)) AS AVG_TRANSACTION_AMOUNT,
	(
		CASE
			WHEN AVG(D.AVG_MINS) = 0 THEN 0
			ELSE AVG(COALESCE(AVG_AMT, 0)) / AVG(D.AVG_MINS)
		END
	) AS RATIO
FROM
	DURATION_CTE D
	JOIN TRANSACTIONS_CTE T ON D.SIGNUP_ID = T.SIGNUP_ID
GROUP BY
	D.LOCATION
ORDER BY
	RATIO DESC;

-- Reset Database:
DROP TABLE TRANSACTIONS;
DROP TABLE SIGNUPS;