-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Amazon(Medium Level) #SQL Interview Question — Solution
-- Write a query that'll identify returning active users. A returning active 
-- user is a user that has made a second purchase within 7 days of any other 
-- of their purchases. Output a list of user_ids of these returning active users.

-- Database setup:
CREATE TABLE AMAZON_TRANSACTIONS (
	ID INT,
	USER_ID INT,
	ITEM VARCHAR(15),
	CREATED_AT TIMESTAMP,
	REVENUE INT
);

INSERT INTO
	AMAZON_TRANSACTIONS
VALUES
	(1, 109, 'milk', '2020-03-03 00:00:00', 123),
	(2, 139, 'biscuit', '2020-03-18 00:00:00', 421),
	(3, 120, 'milk', '2020-03-18 00:00:00', 176),
	(4, 108, 'banana', '2020-03-18 00:00:00', 862),
	(5, 130, 'milk', '2020-03-28 00:00:00', 333),
	(6, 103, 'bread', '2020-03-29 00:00:00', 862),
	(7, 122, 'banana', '2020-03-07 00:00:00', 952),
	(8, 125, 'bread', '2020-03-13 00:00:00', 317),
	(9, 139, 'bread', '2020-03-30 00:00:00', 929),
	(10, 141, 'banana', '2020-03-17 00:00:00', 812),
	(11, 116, 'bread', '2020-03-31 00:00:00', 226),
	(12, 128, 'bread', '2020-03-04 00:00:00', 112),
	(13, 146, 'biscuit', '2020-03-04 00:00:00', 362),
	(14, 119, 'banana', '2020-03-28 00:00:00', 127),
	(15, 142, 'bread', '2020-03-09 00:00:00', 503),
	(16, 122, 'bread', '2020-03-06 00:00:00', 593),
	(17, 128, 'biscuit', '2020-03-24 00:00:00', 160),
	(18, 112, 'banana', '2020-03-24 00:00:00', 262),
	(19, 149, 'banana', '2020-03-29 00:00:00', 382),
	(20, 100, 'banana', '2020-03-18 00:00:00', 599);

-- Query:
SELECT DISTINCT
	A1.USER_ID
FROM
	AMAZON_TRANSACTIONS A1,
	AMAZON_TRANSACTIONS A2
WHERE
	A1.USER_ID = A2.USER_ID
	AND A1.CREATED_AT < A2.CREATED_AT
	AND ABS(
		EXTRACT(
			DAY
			FROM
				A1.CREATED_AT - A2.CREATED_AT
		)
	) <= 7;

-- Reset Database:
DROP TABLE AMAZON_TRANSACTIONS;