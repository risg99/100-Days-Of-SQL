-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Amazon (Hard Level) #SQL Interview Question — Solution
-- Find the best selling item for each month (no need to separate months by year)
-- where the biggest total invoice was paid. The best selling item is calculated
-- using the formula (unitprice * quantity). Output the month, the description of
-- the item along with the amount paid.

-- Database setup:
CREATE TABLE ONLINE_RETAILS (
	COUNTRY VARCHAR(10),
	CUSTOMERID FLOAT,
	DESCRIPTION VARCHAR(10),
	INVOICEDATE TIMESTAMP,
	INVOICENO VARCHAR(10),
	QUANTITY BIGINT,
	STOCKCODE VARCHAR(10),
	UNITPRICE FLOAT
);

INSERT INTO
	ONLINE_RETAILS (
		COUNTRY,
		CUSTOMERID,
		DESCRIPTION,
		INVOICEDATE,
		INVOICENO,
		QUANTITY,
		STOCKCODE,
		UNITPRICE
	)
VALUES
	(
		'USA',
		12345,
		'Product A',
		'2025-01-01 12:00:00',
		'INV001',
		5,
		'A123',
		10.50
	),
	(
		'UK',
		67890,
		'Product B',
		'2025-01-02 14:30:00',
		'INV002',
		2,
		'B456',
		20.75
	),
	(
		'Canada',
		11223,
		'Product C',
		'2025-01-03 16:45:00',
		'INV003',
		10,
		'C789',
		15.00
	);

-- Query:
WITH
	ALL_SALES AS (
		SELECT
			EXTRACT(
				MONTH
				FROM
					INVOICEDATE
			) AS MONTH,
			DESCRIPTION,
			SUM(UNITPRICE * QUANTITY) AS TOTAL_AMOUNT
		FROM
			ONLINE_RETAILS
		GROUP BY
			DESCRIPTION,
			MONTH
		ORDER BY
			MONTH,
			DESCRIPTION
	),
	RANK_CTE AS (
		SELECT
			*,
			RANK() OVER (
				PARTITION BY
					MONTH
				ORDER BY
					TOTAL_AMOUNT DESC
			) AS RNK
		FROM
			ALL_SALES
	)
SELECT
	MONTH,
	DESCRIPTION,
	TOTAL_AMOUNT
FROM
	RANK_CTE
WHERE
	RNK = 1;

-- Reset Database:
DROP TABLE ONLINE_RETAILS;