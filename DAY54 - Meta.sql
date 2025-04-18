-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Meta (Hard Level) #SQL Interview Question — Solution
-- The sales department has given you the sales figures for the first two months of 2023. 
-- You've been tasked with determining the percentage of weekly sales on the first and last
-- day of every week. Consider Sunday as last day of week and Monday as first day of week.
-- In your output, include the week number, percentage sales for the first day of the week, 
-- and percentage sales for the last day of the week. Both proportions should be rounded to 
-- the nearest whole number.

-- Database setup:
CREATE TABLE EARLY_SALES (
	INVOICEDATE TIMESTAMP,
	INVOICENO BIGINT,
	QUANTITY BIGINT,
	STOCKCODE VARCHAR(50),
	UNITPRICE FLOAT
);

INSERT INTO
	EARLY_SALES (
		INVOICEDATE,
		INVOICENO,
		QUANTITY,
		STOCKCODE,
		UNITPRICE
	)
VALUES
	('2023-01-01 10:00:00', 1001, 5, 'A001', 20.0),
	('2023-01-01 15:30:00', 1002, 3, 'A002', 30.0),
	('2023-01-02 09:00:00', 1003, 10, 'A003', 15.0),
	('2023-01-02 11:00:00', 1004, 2, 'A004', 50.0),
	('2023-01-08 10:30:00', 1005, 4, 'A005', 25.0),
	('2023-01-08 14:45:00', 1006, 7, 'A006', 18.0),
	('2023-01-15 08:00:00', 1007, 6, 'A007', 22.0),
	('2023-01-15 16:00:00', 1008, 8, 'A008', 12.0),
	('2023-01-22 09:30:00', 1009, 3, 'A009', 40.0),
	('2023-01-22 18:00:00', 1010, 5, 'A010', 35.0),
	('2023-02-01 10:00:00', 1011, 9, 'A011', 20.0),
	('2023-02-01 12:00:00', 1012, 2, 'A012', 60.0),
	('2023-02-05 09:30:00', 1013, 4, 'A013', 25.0),
	('2023-02-05 13:00:00', 1014, 6, 'A014', 18.0),
	('2023-02-12 10:00:00', 1015, 7, 'A015', 22.0),
	('2023-02-12 14:00:00', 1016, 5, 'A016', 28.0);

-- Query:
WITH
	WEEKLY_SALES AS (
		SELECT
			EXTRACT(
				WEEK
				FROM
					INVOICEDATE
			) AS WEEK_NUM,
			SUM(QUANTITY * UNITPRICE) AS TOTAL_WEEKLY_SALES
		FROM
			EARLY_SALES
		WHERE
			INVOICEDATE BETWEEN '2023-01-01' AND '2023-02-28'
		GROUP BY
			EXTRACT(
				WEEK
				FROM
					INVOICEDATE
			)
	),
	DAY_SALES AS (
		SELECT
			EXTRACT(
				WEEK
				FROM
					INVOICEDATE
			) AS WEEK_NUM,
			TO_CHAR(INVOICEDATE, 'Day') AS WEEKDAY,
			SUM(QUANTITY * UNITPRICE) AS DAILY_SALES
		FROM
			EARLY_SALES
		WHERE
			INVOICEDATE BETWEEN '2023-01-01' AND '2023-02-28'
		GROUP BY
			EXTRACT(
				WEEK
				FROM
					INVOICEDATE
			),
			TO_CHAR(INVOICEDATE, 'Day')
	),
	FIRST_AND_LAST_DAY_SALES AS (
		SELECT
			WEEK_NUM,
			SUM(DAILY_SALES) FILTER (
				WHERE
					TRIM(WEEKDAY) = 'Monday'
			) AS MONDAY_SALES,
			SUM(DAILY_SALES) FILTER (
				WHERE
					TRIM(WEEKDAY) = 'Sunday'
			) AS SUNDAY_SALES
		FROM
			DAY_SALES
		GROUP BY
			WEEK_NUM
	)
SELECT
	W.WEEK_NUM,
	COALESCE(
		ROUND(100.0 * FL.MONDAY_SALES / W.TOTAL_WEEKLY_SALES),
		0
	) AS MONDAY_PERC_SALES,
	COALESCE(
		ROUND(100.0 * FL.SUNDAY_SALES / W.TOTAL_WEEKLY_SALES),
		0
	) AS SUNDAY_PERC_SALES
FROM
	WEEKLY_SALES W
	JOIN FIRST_AND_LAST_DAY_SALES FL ON W.WEEK_NUM = FL.WEEK_NUM
ORDER BY
	W.WEEK_NUM;

-- Reset Database:
DROP TABLE EARLY_SALES;