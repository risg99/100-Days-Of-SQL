-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Goldman Sachs (Medium Level) #SQL Interview Question — Solution
-- You work for a multinational company that wants to calculate total sales across 
-- all their countries they do business in. You have 2 tables, one is a record of sales 
-- for all countries and currencies the company deals with, and the other holds currency 
-- exchange rate information. Calculate the total sales, per quarter, for the first 2 quarters
-- in 2020, and report the sales in USD currency.

-- Database setup:
CREATE TABLE SF_EXCHANGE_RATE (
	DATE DATE,
	EXCHANGE_RATE FLOAT,
	SOURCE_CURRENCY VARCHAR(10),
	TARGET_CURRENCY VARCHAR(10)
);

INSERT INTO
	SF_EXCHANGE_RATE (
		DATE,
		EXCHANGE_RATE,
		SOURCE_CURRENCY,
		TARGET_CURRENCY
	)
VALUES
	('2020-01-15', 1.1, 'EUR', 'USD'),
	('2020-01-15', 1.3, 'GBP', 'USD'),
	('2020-02-05', 1.2, 'EUR', 'USD'),
	('2020-02-05', 1.35, 'GBP', 'USD'),
	('2020-03-25', 1.15, 'EUR', 'USD'),
	('2020-03-25', 1.4, 'GBP', 'USD'),
	('2020-04-15', 1.2, 'EUR', 'USD'),
	('2020-04-15', 1.45, 'GBP', 'USD'),
	('2020-05-10', 1.1, 'EUR', 'USD'),
	('2020-05-10', 1.3, 'GBP', 'USD'),
	('2020-06-05', 1.05, 'EUR', 'USD'),
	('2020-06-05', 1.25, 'GBP', 'USD');

CREATE TABLE SF_SALES_AMOUNT (
	CURRENCY VARCHAR(10),
	SALES_AMOUNT BIGINT,
	SALES_DATE DATE
);

INSERT INTO
	SF_SALES_AMOUNT (CURRENCY, SALES_AMOUNT, SALES_DATE)
VALUES
	('USD', 1000, '2020-01-15'),
	('EUR', 2000, '2020-01-20'),
	('GBP', 1500, '2020-02-05'),
	('USD', 2500, '2020-02-10'),
	('EUR', 1800, '2020-03-25'),
	('GBP', 2200, '2020-03-30'),
	('USD', 3000, '2020-04-15'),
	('EUR', 1700, '2020-04-20'),
	('GBP', 2000, '2020-05-10'),
	('USD', 3500, '2020-05-25'),
	('EUR', 1900, '2020-06-05'),
	('GBP', 2100, '2020-06-10');

-- Query:
SELECT
	EXTRACT(
		QUARTER
		FROM
			SALES_DATE
	) AS SALES_QUARTER,
	SUM(S.SALES_AMOUNT * R.EXCHANGE_RATE) AS TOTAL_SALES_AMOUNT
FROM
	SF_SALES_AMOUNT S
	JOIN SF_EXCHANGE_RATE R ON S.SALES_DATE = R.DATE
	AND S.CURRENCY = R.SOURCE_CURRENCY
	AND R.TARGET_CURRENCY = 'USD'
WHERE
	EXTRACT(
		YEAR
		FROM
			SALES_DATE
	) = 2020
GROUP BY
	SALES_QUARTER;

-- Reset Database:
DROP TABLE SF_EXCHANGE_RATE;
DROP TABLE SF_SALES_AMOUNT;