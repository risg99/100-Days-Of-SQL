-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Uber (Hard Level) #SQL Interview Question — Solution
-- Find the most profitable location. Write a query that calculates the average signup 
-- duration and average transaction amount for each location, and then compare these 
-- two measures together by taking the ratio of the average transaction amount and average
-- duration for each location.
-- Your output should include the location, average duration, average transaction amount, 
-- and ratio. Sort your results from highest ratio to lowest.

-- Database setup:
CREATE TABLE CUST_SIGNUPS (
	LOCATION VARCHAR(100),
	PLAN_ID BIGINT,
	SIGNUP_ID BIGINT PRIMARY KEY,
	SIGNUP_START_DATE DATE,
	SIGNUP_STOP_DATE DATE
);

INSERT INTO
	CUST_SIGNUPS (
		LOCATION,
		PLAN_ID,
		SIGNUP_ID,
		SIGNUP_START_DATE,
		SIGNUP_STOP_DATE
	)
VALUES
	('New York', 101, 1, '2025-01-01', '2025-01-31'),
	(
		'San Francisco',
		102,
		2,
		'2025-01-05',
		'2025-02-05'
	),
	('Los Angeles', 103, 3, '2025-01-10', '2025-01-20'),
	('New York', 104, 4, '2025-02-01', '2025-02-28'),
	('Los Angeles', 105, 5, '2025-01-15', '2025-01-25');

CREATE TABLE CUST_TRANSACTIONS (
	AMT FLOAT,
	SIGNUP_ID BIGINT,
	TRANSACTION_ID BIGINT PRIMARY KEY,
	TRANSACTION_START_DATE DATE
);

INSERT INTO
	CUST_TRANSACTIONS (
		AMT,
		SIGNUP_ID,
		TRANSACTION_ID,
		TRANSACTION_START_DATE
	)
VALUES
	(100.50, 1, 1001, '2025-01-10'),
	(200.75, 1, 1002, '2025-01-20'),
	(150.00, 2, 1003, '2025-01-15'),
	(300.00, 3, 1004, '2025-01-12'),
	(400.00, 4, 1005, '2025-02-15'),
	(250.00, 5, 1006, '2025-01-20');

-- Query:
SELECT
	LOCATION,
	AVG(SIGNUP_STOP_DATE - SIGNUP_START_DATE) AS AVG_DURATION,
	AVG(AMT) AS AVG_AMOUNT,
	AVG(AMT) / AVG(SIGNUP_STOP_DATE - SIGNUP_START_DATE) AS RATIO
FROM
	CUST_SIGNUPS CS
	INNER JOIN CUST_TRANSACTIONS CT ON CS.SIGNUP_ID = CT.SIGNUP_ID
GROUP BY
	LOCATION
ORDER BY
	RATIO DESC;

-- Reset Database:
DROP TABLE CUST_SIGNUPS;
DROP TABLE CUST_TRANSACTIONS;