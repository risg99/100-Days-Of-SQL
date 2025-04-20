-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Goldman Sachs(Medium Level) #SQL Interview Question — Solution
-- You are given a list of exchange rates from various currencies to US Dollars (USD) 
-- in different months. Show how the exchange rate of all the currencies changed in the
-- first half of 2020. Output the currency code and the difference between values of the 
-- exchange rate between July 1, 2020 and January 1, 2020.

-- Database setup:
CREATE TABLE SF_EXCHANGE_RATES (
	DATE DATE,
	EXCHANGE_RATE FLOAT,
	SOURCE_CURRENCY VARCHAR(10),
	TARGET_CURRENCY VARCHAR(10)
);

INSERT INTO
	SF_EXCHANGE_RATES (
		DATE,
		EXCHANGE_RATE,
		SOURCE_CURRENCY,
		TARGET_CURRENCY
	)
VALUES
	('2020-01-01', 1.12, 'EUR', 'USD'),
	('2020-01-01', 1.31, 'GBP', 'USD'),
	('2020-01-01', 109.56, 'JPY', 'USD'),
	('2020-07-01', 1.17, 'EUR', 'USD'),
	('2020-07-01', 1.29, 'GBP', 'USD'),
	('2020-07-01', 109.66, 'JPY', 'USD'),
	('2020-01-01', 0.75, 'AUD', 'USD'),
	('2020-07-01', 0.73, 'AUD', 'USD'),
	('2020-01-01', 6.98, 'CNY', 'USD'),
	('2020-07-01', 7.05, 'CNY', 'USD');

-- Query:
WITH
	ALL_RATES AS (
		SELECT
			SOURCE_CURRENCY,
			MAX(
				CASE
					WHEN DATE = '2020-01-01' THEN EXCHANGE_RATE
				END
			) AS JAN_RATE,
			MAX(
				CASE
					WHEN DATE = '2020-07-01' THEN EXCHANGE_RATE
				END
			) AS JULY_RATE
		FROM
			SF_EXCHANGE_RATES
		WHERE
			TARGET_CURRENCY = 'USD'
			AND DATE IN ('2020-01-01', '2020-07-01')
		GROUP BY
			SOURCE_CURRENCY
	)
SELECT
	SOURCE_CURRENCY AS CURRENCY_CODE,
	COALESCE(JULY_RATE, 0) - COALESCE(JAN_RATE, 0) AS DIFF_EXCHANGE_RATE
FROM
	ALL_RATES;

-- Reset Database:
DROP TABLE SF_EXCHANGE_RATES;