-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Tesla (Hard Level) #SQL Interview Question — Solution
-- The company you are working for wants to anticipate their staffing needs by identifying
-- their top two busiest times of the week. To find this, each day should be segmented into 
-- differents parts using following criteria:
-- 1. Morning: Before 12 p.m. (not inclusive)
-- 2. Early afternoon: 12 - 15 p.m.
-- 3. Late afternoon: after 15 p.m. (not inclusive)

-- Your output should include the day and time of day combination for the two busiest times, 
-- i.e. the combinations with the most orders, along with the number of orders (e.g. top two 
-- results could be Friday Late afternoon with 12 orders and Sunday Morning with 10 orders). 
-- The company has also requested that the day be displayed in text format (i.e. Monday).
-- Note: In the event of a tie in ranking, all results should be displayed.\

-- Database setup:
CREATE TABLE SALES_LOG (
	ORDER_ID BIGINT PRIMARY KEY,
	PRODUCT_ID BIGINT,
	TIME TIMESTAMP
);

INSERT INTO
	SALES_LOG (ORDER_ID, PRODUCT_ID, TIME)
VALUES
	(1, 101, '2024-12-15 09:30:00'),
	(2, 102, '2024-12-15 11:45:00'),
	(3, 103, '2024-12-15 12:10:00'),
	(4, 104, '2024-12-15 13:15:00'),
	(5, 105, '2024-12-15 14:20:00'),
	(6, 106, '2024-12-15 15:30:00'),
	(7, 107, '2024-12-15 16:40:00'),
	(8, 108, '2024-12-16 09:50:00'),
	(9, 109, '2024-12-16 10:30:00'),
	(10, 110, '2024-12-16 12:05:00'),
	(11, 111, '2024-12-16 13:50:00'),
	(12, 112, '2024-12-16 14:15:00'),
	(13, 113, '2024-12-16 15:30:00'),
	(14, 114, '2024-12-17 09:45:00'),
	(15, 115, '2024-12-17 11:20:00'),
	(16, 116, '2024-12-17 12:25:00'),
	(17, 117, '2024-12-17 13:30:00'),
	(18, 118, '2024-12-17 14:55:00'),
	(19, 119, '2024-12-17 15:10:00'),
	(20, 120, '2024-12-18 10:40:00');

-- Query:
WITH
	EXTRACT_TIMES AS (
		SELECT
			ORDER_ID,
			TO_CHAR(TIME, 'Day') AS WEEKDAY,
			EXTRACT(
				HOUR
				FROM
					TIME
			) AS HOUR,
			EXTRACT(
				MINUTE
				FROM
					TIME
			) AS MINUTE
		FROM
			SALES_LOG
	),
	DAY_TIMES AS (
		SELECT
			(
				CASE
					WHEN HOUR < 12 THEN 'Morning'
					WHEN HOUR = 15
					AND MINUTE != 0 THEN 'Late afternoon'
					WHEN HOUR >= 12
					AND HOUR <= 15 THEN 'Early afternoon'
					WHEN HOUR > 15 THEN 'Late afternoon'
					ELSE 'Out of bounds'
				END
			) AS DAYTIME,
			WEEKDAY,
			COUNT(*) AS TOTAL_ORDERS
		FROM
			EXTRACT_TIMES
		GROUP BY
			WEEKDAY,
			DAYTIME
	),
	ORDER_RANKS AS (
		SELECT
			*,
			RANK() OVER (
				ORDER BY
					TOTAL_ORDERS DESC
			) AS RANK
		FROM
			DAY_TIMES
	)
SELECT
	WEEKDAY,
	DAYTIME,
	TOTAL_ORDERS
FROM
	ORDER_RANKS
WHERE
	RANK <= 2;

-- Reset Database:
DROP TABLE SALES_LOG;