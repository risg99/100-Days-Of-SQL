-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: DoorDash(Hard Level) #SQL Interview Question — Solution
-- You have been asked to investigate whether there is a correlation between the average 
-- total order value and the average time in minutes between placing an order and having 
-- it delivered per restaurant. You have also been told that the column order_total 
-- represents the gross order total for each order. Therefore, you'll need to calculate 
-- the net order total. The gross order total is the total of the order before adding the 
-- tip and deducting the discount and refund. Make sure correlation is rounded to 2 decimals.

-- Database setup:
CREATE TABLE DELIVERY_DETAILS (
	CUSTOMER_PLACED_ORDER_DATETIME TIMESTAMP,
	PLACED_ORDER_WITH_RESTAURANT_DATETIME TIMESTAMP,
	DRIVER_AT_RESTAURANT_DATETIME TIMESTAMP,
	DELIVERED_TO_CONSUMER_DATETIME TIMESTAMP,
	DRIVER_ID BIGINT,
	RESTAURANT_ID BIGINT,
	CONSUMER_ID BIGINT,
	IS_NEW INT,
	DELIVERY_REGION VARCHAR(255),
	IS_ASAP INT,
	ORDER_TOTAL FLOAT,
	DISCOUNT_AMOUNT FLOAT,
	TIP_AMOUNT FLOAT,
	REFUNDED_AMOUNT FLOAT
);

INSERT INTO
	DELIVERY_DETAILS (
		CUSTOMER_PLACED_ORDER_DATETIME,
		PLACED_ORDER_WITH_RESTAURANT_DATETIME,
		DRIVER_AT_RESTAURANT_DATETIME,
		DELIVERED_TO_CONSUMER_DATETIME,
		DRIVER_ID,
		RESTAURANT_ID,
		CONSUMER_ID,
		IS_NEW,
		DELIVERY_REGION,
		IS_ASAP,
		ORDER_TOTAL,
		DISCOUNT_AMOUNT,
		TIP_AMOUNT,
		REFUNDED_AMOUNT
	)
VALUES
	(
		'2024-02-01 12:00:00',
		'2024-02-01 12:05:00',
		'2024-02-01 12:15:00',
		'2024-02-01 12:30:00',
		101,
		1,
		1001,
		1,
		'New York',
		1,
		50.00,
		5.00,
		3.00,
		0.00
	),
	(
		'2024-02-01 13:10:00',
		'2024-02-01 13:15:00',
		'2024-02-01 13:25:00',
		'2024-02-01 13:50:00',
		102,
		2,
		1002,
		0,
		'Los Angeles',
		0,
		75.00,
		10.00,
		5.00,
		2.00
	),
	(
		'2024-02-01 14:30:00',
		'2024-02-01 14:40:00',
		'2024-02-01 14:50:00',
		'2024-02-01 15:05:00',
		103,
		1,
		1003,
		1,
		'New York',
		1,
		60.00,
		8.00,
		4.00,
		0.00
	),
	(
		'2024-02-01 15:00:00',
		'2024-02-01 15:05:00',
		'2024-02-01 15:15:00',
		'2024-02-01 15:45:00',
		104,
		3,
		1004,
		0,
		'Chicago',
		0,
		90.00,
		15.00,
		6.00,
		5.00
	),
	(
		'2024-02-01 16:20:00',
		'2024-02-01 16:25:00',
		'2024-02-01 16:35:00',
		'2024-02-01 16:50:00',
		105,
		2,
		1005,
		1,
		'Los Angeles',
		1,
		110.00,
		20.00,
		8.00,
		0.00
	);

-- Query:
WITH
	RESTUARANT_METRICS AS (
		SELECT
			RESTAURANT_ID,
			AVG(
				ORDER_TOTAL + TIP_AMOUNT - DISCOUNT_AMOUNT - REFUNDED_AMOUNT
			) AS AVG_NET_ORDER_TOTAL,
			AVG(
				EXTRACT(
					MINUTE
					FROM
						DELIVERED_TO_CONSUMER_DATETIME - PLACED_ORDER_WITH_RESTAURANT_DATETIME
				)
			) AS AVG_NET_DELIVERY_TIME
		FROM
			DELIVERY_DETAILS
		GROUP BY
			RESTAURANT_ID
	),
	STATISTICS AS (
		SELECT
			COUNT(*) AS N,
			SUM(AVG_NET_ORDER_TOTAL) AS SUM_X,
			SUM(AVG_NET_DELIVERY_TIME) AS SUM_Y,
			SUM(AVG_NET_ORDER_TOTAL * AVG_NET_DELIVERY_TIME) AS SUM_XY,
			SUM(AVG_NET_ORDER_TOTAL * AVG_NET_ORDER_TOTAL) AS SUM_X2,
			SUM(AVG_NET_DELIVERY_TIME * AVG_NET_DELIVERY_TIME) AS SUM_Y2
		FROM
			RESTUARANT_METRICS
	)
SELECT
	(N * SUM_XY - SUM_X * SUM_Y) / (
		SQRT(N * SUM_X2 - SUM_X * SUM_X) * SQRT(N * SUM_Y2 - SUM_Y * SUM_Y)
	) AS CORRELATION_VALUE
FROM
	STATISTICS;

-- Reset Database:
DROP TABLE DELIVERY_DETAILS;