-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Amazon (Hard Level) #SQL Interview Question — Solution
-- Find the best selling item for each month (no need to separate months by year) where
-- the biggest total invoice was paid. The best selling item is calculated using the formula 
-- (unitprice * quantity). Output the month, the description of the item along with the amount paid.

-- Database setup:
CREATE TABLE ONLINE_RETAIL (
	INVOICENO VARCHAR(50),
	STOCKCODE VARCHAR(50),
	DESCRIPTION VARCHAR(255),
	QUANTITY INT,
	INVOICEDATE TIMESTAMP,
	UNITPRICE FLOAT,
	CUSTOMERID FLOAT,
	COUNTRY VARCHAR(100)
);

INSERT INTO
	ONLINE_RETAIL (
		INVOICENO,
		STOCKCODE,
		DESCRIPTION,
		QUANTITY,
		INVOICEDATE,
		UNITPRICE,
		CUSTOMERID,
		COUNTRY
	)
VALUES
	(
		'536365',
		'85123A',
		'WHITE HANGING HEART T-LIGHT HOLDER',
		10,
		'2021-01-15 10:00:00',
		2.55,
		17850,
		'United Kingdom'
	),
	(
		'536366',
		'71053',
		'WHITE METAL LANTERN',
		5,
		'2021-02-10 12:00:00',
		3.39,
		13047,
		'United Kingdom'
	),
	(
		'536367',
		'84406B',
		'CREAM CUPID HEARTS COAT HANGER',
		8,
		'2021-03-05 15:00:00',
		2.75,
		17850,
		'United Kingdom'
	),
	(
		'536368',
		'22423',
		'REGENCY CAKESTAND 3 TIER',
		2,
		'2021-04-12 16:30:00',
		12.75,
		13047,
		'United Kingdom'
	),
	(
		'536369',
		'85123A',
		'WHITE HANGING HEART T-LIGHT HOLDER',
		15,
		'2021-05-18 11:00:00',
		2.55,
		13047,
		'United Kingdom'
	),
	(
		'536370',
		'21730',
		'GLASS STAR FROSTED T-LIGHT HOLDER',
		12,
		'2021-06-25 14:00:00',
		4.25,
		17850,
		'United Kingdom'
	);

-- Query:
SELECT
	EXTRACT(
		MONTH
		FROM
			INVOICEDATE
	) AS MONTH,
	DESCRIPTION,
	SUM(UNITPRICE * QUANTITY) AS TOTAL_INVOICE
FROM
	ONLINE_RETAIL
GROUP BY
	MONTH,
	DESCRIPTION
ORDER BY
	MONTH ASC,
	TOTAL_INVOICE DESC;

-- Reset Database:
DROP TABLE ONLINE_RETAIL;