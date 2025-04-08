-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Nvidia, Microsoft (Medium Level) #SQL Interview Question — Solution
-- Find the number of transactions that occurred for each product. Output the product
-- name along with the corresponding number of transactions and order records by the 
-- product id in ascending order. You can ignore products without transactions.

-- Database setup:
CREATE TABLE EXCEL_SQL_INVENTORY_DATA (
	PRODUCT_ID INT,
	PRODUCT_NAME VARCHAR(50),
	PRODUCT_TYPE VARCHAR(50),
	UNIT VARCHAR(20),
	PRICE_UNIT FLOAT,
	WHOLESALE FLOAT,
	CURRENT_INVENTORY INT
);

INSERT INTO
	EXCEL_SQL_INVENTORY_DATA (
		PRODUCT_ID,
		PRODUCT_NAME,
		PRODUCT_TYPE,
		UNIT,
		PRICE_UNIT,
		WHOLESALE,
		CURRENT_INVENTORY
	)
VALUES
	(1, 'strawberry', 'produce', 'lb', 3.28, 1.77, 13),
	(2, 'apple_fuji', 'produce', 'lb', 1.44, 0.43, 2),
	(3, 'orange', 'produce', 'lb', 1.02, 0.37, 2),
	(4, 'clementines', 'produce', 'lb', 1.19, 0.44, 44),
	(
		5,
		'blood_orange',
		'produce',
		'lb',
		3.86,
		1.66,
		19
	);

CREATE TABLE EXCEL_SQL_TRANSACTION_DATA (
	TRANSACTION_ID INT PRIMARY KEY,
	TIME TIMESTAMP,
	PRODUCT_ID INT
);

INSERT INTO
	EXCEL_SQL_TRANSACTION_DATA (TRANSACTION_ID, TIME, PRODUCT_ID)
VALUES
	(153, '2016-01-06 08:57:52', 1),
	(91, '2016-01-07 12:17:27', 1),
	(31, '2016-01-05 13:19:25', 1),
	(24, '2016-01-03 10:47:44', 3),
	(4, '2016-01-06 17:57:42', 3),
	(163, '2016-01-03 10:11:22', 3),
	(92, '2016-01-08 12:03:20', 2),
	(32, '2016-01-04 19:37:14', 4),
	(253, '2016-01-06 14:15:20', 5),
	(118, '2016-01-06 14:27:33', 5);

-- Query:
SELECT
	I.PRODUCT_NAME,
	COUNT(TRANSACTION_ID) AS TRANSACTIONS_COUNT
FROM
	EXCEL_SQL_INVENTORY_DATA I
	JOIN EXCEL_SQL_TRANSACTION_DATA T ON I.PRODUCT_ID = T.PRODUCT_ID
GROUP BY
	I.PRODUCT_NAME,
	I.PRODUCT_ID
ORDER BY
	I.PRODUCT_ID ASC;

-- Reset Database:
DROP TABLE EXCEL_SQL_INVENTORY_DATA;
DROP TABLE EXCEL_SQL_TRANSACTION_DATA;