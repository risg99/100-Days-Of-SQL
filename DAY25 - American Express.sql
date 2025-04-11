-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: American Express (Medium Level) #SQL Interview Question — Solution
-- American Express is reviewing their customers' transactions, and you have been tasked
-- with locating the customer who has the third highest total transaction amount. The output
-- should include the customer's id, as well as their first name and last name. For ranking 
-- the customers, use type of ranking with no gaps between subsequent ranks.

-- Database setup:
CREATE TABLE CUSTOMERS (
	ID INT,
	FIRST_NAME VARCHAR(50),
	LAST_NAME VARCHAR(50),
	CITY VARCHAR(100),
	ADDRESS VARCHAR(200),
	PHONE_NUMBER VARCHAR(20)
);

INSERT INTO
	CUSTOMERS (
		ID,
		FIRST_NAME,
		LAST_NAME,
		CITY,
		ADDRESS,
		PHONE_NUMBER
	)
VALUES
	(
		1,
		'Jill',
		'Doe',
		'New York',
		'123 Main St',
		'555-1234'
	),
	(
		2,
		'Henry',
		'Smith',
		'Los Angeles',
		'456 Oak Ave',
		'555-5678'
	),
	(
		3,
		'William',
		'Johnson',
		'Chicago',
		'789 Pine Rd',
		'555-8765'
	),
	(
		4,
		'Emma',
		'Daniel',
		'Houston',
		'321 Maple Dr',
		'555-4321'
	),
	(
		5,
		'Charlie',
		'Davis',
		'Phoenix',
		'654 Elm St',
		'555-6789'
	);

CREATE TABLE CARD_ORDERS (
	ORDER_ID INT,
	CUST_ID INT,
	ORDER_DATE TIMESTAMP,
	ORDER_DETAILS VARCHAR(255),
	TOTAL_ORDER_COST INT
);

INSERT INTO
	CARD_ORDERS (
		ORDER_ID,
		CUST_ID,
		ORDER_DATE,
		ORDER_DETAILS,
		TOTAL_ORDER_COST
	)
VALUES
	(1, 1, '2024-11-01 10:00:00', 'Electronics', 200),
	(2, 2, '2024-11-02 11:30:00', 'Groceries', 150),
	(3, 1, '2024-11-03 15:45:00', 'Clothing', 120),
	(4, 3, '2024-11-04 09:10:00', 'Books', 90),
	(8, 3, '2024-11-08 10:20:00', 'Groceries', 130),
	(9, 1, '2024-11-09 12:00:00', 'Books', 180),
	(10, 4, '2024-11-10 11:15:00', 'Electronics', 200),
	(11, 5, '2024-11-11 14:45:00', 'Furniture', 150),
	(12, 2, '2024-11-12 09:30:00', 'Furniture', 180);

-- Query:
WITH
	ALL_CUSTOMER_TRANSACTIONS AS (
		SELECT
			C.ID,
			C.FIRST_NAME,
			C.LAST_NAME,
			SUM(O.TOTAL_ORDER_COST) AS TOTAL_TRANSACTION_AMOUNT
		FROM
			CUSTOMERS C
			JOIN CARD_ORDERS O ON C.ID = O.CUST_ID
		GROUP BY
			C.ID,
			C.FIRST_NAME,
			C.LAST_NAME
	),
	ALL_RANKS AS (
		SELECT
			ID,
			FIRST_NAME,
			LAST_NAME,
			TOTAL_TRANSACTION_AMOUNT,
			RANK() OVER (
				ORDER BY
					TOTAL_TRANSACTION_AMOUNT DESC
			) AS RNK
		FROM
			ALL_CUSTOMER_TRANSACTIONS
	)
SELECT
	ID,
	FIRST_NAME,
	LAST_NAME,
	TOTAL_TRANSACTION_AMOUNT
FROM
	ALL_RANKS
WHERE
	RNK = 3;

-- Reset Database:
DROP TABLE CUSTOMERS;
DROP TABLE CARD_ORDERS;