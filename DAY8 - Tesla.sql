-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Tesla(Medium Level) #SQL Interview Question — Solution
-- You are given a table of product launches by company by year. Write a query to count 
-- the net difference between the number of products companies launched in 2020 with the
-- number of products companies launched in the previous year. Output the name of the companies
-- and a net difference of net products released for 2020 compared to the previous year.

-- Database setup:
CREATE TABLE CAR_LAUNCHES (
	YEAR INT,
	COMPANY_NAME VARCHAR(15),
	PRODUCT_NAME VARCHAR(30)
);
INSERT INTO
	CAR_LAUNCHES
VALUES
	(2019, 'Toyota', 'Avalon'),
	(2019, 'Toyota', 'Camry'),
	(2020, 'Toyota', 'Corolla'),
	(2019, 'Honda', 'Accord'),
	(2019, 'Honda', 'Passport'),
	(2019, 'Honda', 'CR-V'),
	(2020, 'Honda', 'Pilot'),
	(2019, 'Honda', 'Civic'),
	(2020, 'Chevrolet', 'Trailblazer'),
	(2020, 'Chevrolet', 'Trax'),
	(2019, 'Chevrolet', 'Traverse'),
	(2020, 'Chevrolet', 'Blazer'),
	(2019, 'Ford', 'Figo'),
	(2020, 'Ford', 'Aspire'),
	(2019, 'Ford', 'Endeavour'),
	(2020, 'Jeep', 'Wrangler');

-- Query:
WITH
	PRODUCTS_COUNT AS (
		SELECT
			COMPANY_NAME,
			SUM(
				CASE
					WHEN YEAR = 2020 THEN 1
					ELSE 0
				END
			) AS PRODUCTS_2020,
			SUM(
				CASE
					WHEN YEAR = 2019 THEN 1
					ELSE 0
				END
			) AS PRODUCTS_2019
		FROM
			CAR_LAUNCHES
		WHERE
			YEAR IN (2019, 2020)
		GROUP BY
			COMPANY_NAME
	)
SELECT
	COMPANY_NAME,
	PRODUCTS_2020 - PRODUCTS_2019 AS NET_DIFFERENCE
FROM
	PRODUCTS_COUNT
ORDER BY
	NET_DIFFERENCE DESC;

-- Reset Database:
DROP TABLE car_launches;