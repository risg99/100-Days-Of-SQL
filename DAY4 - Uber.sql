-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Uber(Hard Level) #SQL Interview Question — Solution
-- Some forecasting methods are extremely simple and surprisingly effective. 
-- Naïve forecast is one of them. To create a naïve forecast for "distance per dollar" (defined as distance_to_travel/monetary_cost), 
-- first sum the "distance to travel" and "monetary cost" values monthly. 
-- This gives the actual value for the current month. For the forecasted value, 
-- use the previous month value. After obtaining both actual and forecasted values, 
-- calculate the root mean squared error (RMSE) using the formula RMSE = sqrt(mean(square(actual - forecast))). 
-- Report the RMSE rounded to two decimal places.

-- Database setup:
CREATE TABLE UBER_REQUEST_LOGS (
	REQUEST_ID INT,
	REQUEST_DATE TIMESTAMP,
	REQUEST_STATUS VARCHAR(10),
	DISTANCE_TO_TRAVEL FLOAT,
	MONETARY_COST FLOAT,
	DRIVER_TO_CLIENT_DISTANCE FLOAT
);
INSERT INTO
	UBER_REQUEST_LOGS
VALUES
	(1, '2020-01-09', 'success', 70.59, 6.56, 14.36),
	(2, '2020-01-24', 'success', 93.36, 22.68, 19.9),
	(3, '2020-02-08', 'fail', 51.24, 11.39, 21.32),
	(4, '2020-02-23', 'success', 61.58, 8.04, 44.26),
	(5, '2020-03-09', 'success', 25.04, 7.19, 1.74),
	(6, '2020-03-24', 'fail', 45.57, 4.68, 24.19),
	(7, '2020-04-08', 'success', 24.45, 12.69, 15.91),
	(8, '2020-04-23', 'success', 48.22, 11.2, 48.82),
	(9, '2020-05-08', 'success', 56.63, 4.04, 16.08),
	(10, '2020-05-23', 'fail', 19.03, 16.65, 11.22),
	(11, '2020-06-07', 'fail', 81, 6.56, 26.6),
	(12, '2020-06-22', 'fail', 21.32, 8.86, 28.57),
	(13, '2020-07-07', 'fail', 14.74, 17.76, 19.33),
	(14, '2020-07-22', 'success', 66.73, 13.68, 14.07),
	(15, '2020-08-06', 'success', 32.98, 16.17, 25.34),
	(16, '2020-08-21', 'success', 46.49, 1.84, 41.9),
	(17, '2020-09-05', 'fail', 45.98, 12.2, 2.46),
	(18, '2020-09-20', 'success', 3.14, 24.8, 36.6),
	(19, '2020-10-05', 'success', 75.33, 23.04, 29.99),
	(20, '2020-10-20', 'success', 53.76, 22.94, 18.74);

-- Query:
WITH
	MONTHLY_AGGREGATES AS (
		SELECT
			TO_CHAR(REQUEST_DATE, 'yyyy-mm') AS YEAR_MONTH,
			SUM(DISTANCE_TO_TRAVEL) AS TOTAL_DISTANCE,
			SUM(MONETARY_COST) AS TOTAL_COST
		FROM
			UBER_REQUEST_LOGS
		GROUP BY
			YEAR_MONTH
	),
	DISTANCE_PER_DOLLAR AS (
		SELECT
			YEAR_MONTH,
			TOTAL_DISTANCE / TOTAL_COST AS DISTANCE_PER_DOLLAR
		FROM
			MONTHLY_AGGREGATES
	),
	NAIVE_FORECAST AS (
		SELECT
			YEAR_MONTH,
			DISTANCE_PER_DOLLAR,
			LAG(DISTANCE_PER_DOLLAR, 1) OVER (
				ORDER BY
					YEAR_MONTH
			) AS FORECASTED_VALUE
		FROM
			DISTANCE_PER_DOLLAR
	)
SELECT
	SQRT(
		AVG(POWER(DISTANCE_PER_DOLLAR - FORECASTED_VALUE, 2))
	) AS RMSE
FROM
	NAIVE_FORECAST;

-- Reset Database:
DROP TABLE UBER_REQUEST_LOGS;