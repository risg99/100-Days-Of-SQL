-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Amazon (Hard Level) #SQL Interview Question — Solution
-- Find the 3-month rolling average of total revenue from purchases given a table with users, 
-- their purchase amount, and date purchased. Do not include returns which are represented by
-- negative purchase values. Output the year-month (YYYY-MM) and 3-month rolling average of revenue, 
-- sorted from earliest month to latest month.
-- A 3-month rolling average is defined by calculating the average total revenue from all user purchases
-- for the current month and previous two months. The first two months will not be a true 3-month rolling 
-- average since we are not given data from last year. Assume each month has at least one purchase.

-- Database setup:
CREATE TABLE AMAZON_PURCHASES (
	CREATED_AT DATE,
	PURCHASE_AMT BIGINT,
	USER_ID BIGINT
);

INSERT INTO
	AMAZON_PURCHASES (CREATED_AT, PURCHASE_AMT, USER_ID)
VALUES
	('2023-01-05', 1500, 101),
	('2023-01-15', -200, 102),
	('2023-02-10', 2000, 103),
	('2023-02-20', 1200, 101),
	('2023-03-01', 1800, 104),
	('2023-03-15', -100, 102),
	('2023-04-05', 2200, 105),
	('2023-04-10', 1400, 103),
	('2023-05-01', 2500, 106),
	('2023-05-15', 1700, 107),
	('2023-06-05', 1300, 108),
	('2023-06-15', 1900, 109);

-- Query:
WITH
	MONTHLY_REVENUE AS (
		SELECT
			TO_CHAR(CREATED_AT, 'YYYY-MM') AS YEAR_MONTH,
			DATE_TRUNC('month', CREATED_AT) AS MONTH_START,
			SUM(
				CASE
					WHEN PURCHASE_AMT > 0 THEN PURCHASE_AMT
					ELSE 0
				END
			) AS TOTAL_REVENUE
		FROM
			AMAZON_PURCHASES
		GROUP BY
			TO_CHAR(CREATED_AT, 'YYYY-MM'),
			DATE_TRUNC('month', CREATED_AT)
	),
	ROLLING_AVERAGE AS (
		SELECT
			YEAR_MONTH,
			TOTAL_REVENUE,
			ROUND(
				AVG(TOTAL_REVENUE) OVER (
					ORDER BY
						MONTH_START ROWS BETWEEN UNBOUNDED PRECEDING
						AND CURRENT ROW
				),
				2
			) AS AVERAGE_REVENUE
		FROM
			MONTHLY_REVENUE
	)
SELECT
	YEAR_MONTH,
	AVERAGE_REVENUE
FROM
	ROLLING_AVERAGE
ORDER BY
	YEAR_MONTH;

-- Reset Database:
DROP TABLE AMAZON_PURCHASES;