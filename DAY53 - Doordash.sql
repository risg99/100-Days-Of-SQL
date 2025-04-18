-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: DoorDash (Medium Level) #SQL Interview Question — Solution
-- Calculate the average net earnings per order grouped by weekday (in text format, e.g., Monday) 
-- and hour from customer_placed_order_datetime. The net earnings are computed as: order_total + 
-- tip_amount - discount_amount - refunded_amount. Round the result to 2 decimals.

-- Database setup:
CREATE TABLE DOORDASH_DELIVERY (
	CONSUMER_ID BIGINT,
	CUSTOMER_PLACED_ORDER_DATETIME TIMESTAMP,
	DELIVERED_TO_CONSUMER_DATETIME TIMESTAMP,
	DELIVERY_REGION VARCHAR(255),
	DISCOUNT_AMOUNT BIGINT,
	DRIVER_AT_RESTAURANT_DATETIME TIMESTAMP,
	DRIVER_ID INT,
	IS_ASAP INT,
	IS_NEW INT,
	ORDER_TOTAL FLOAT,
	PLACED_ORDER_WITH_RESTAURANT_DATETIME TIMESTAMP,
	REFUNDED_AMOUNT FLOAT,
	RESTAURANT_ID BIGINT,
	TIP_AMOUNT FLOAT
);

INSERT INTO
	DOORDASH_DELIVERY (
		CONSUMER_ID,
		CUSTOMER_PLACED_ORDER_DATETIME,
		DELIVERED_TO_CONSUMER_DATETIME,
		DELIVERY_REGION,
		DISCOUNT_AMOUNT,
		DRIVER_AT_RESTAURANT_DATETIME,
		DRIVER_ID,
		IS_ASAP,
		IS_NEW,
		ORDER_TOTAL,
		PLACED_ORDER_WITH_RESTAURANT_DATETIME,
		REFUNDED_AMOUNT,
		RESTAURANT_ID,
		TIP_AMOUNT
	)
VALUES
	(
		1,
		'2024-01-15 10:30:00',
		'2024-01-15 11:00:00',
		'Region A',
		5,
		'2024-01-15 10:40:00',
		101,
		1,
		1,
		50.00,
		'2024-01-15 10:25:00',
		0,
		201,
		5.00
	),
	(
		2,
		'2024-01-15 12:15:00',
		'2024-01-15 12:45:00',
		'Region B',
		10,
		'2024-01-15 12:20:00',
		102,
		1,
		0,
		40.00,
		'2024-01-15 12:10:00',
		5.00,
		202,
		3.00
	),
	(
		3,
		'2024-01-16 08:45:00',
		'2024-01-16 09:15:00',
		'Region C',
		0,
		'2024-01-16 08:50:00',
		103,
		0,
		1,
		30.00,
		'2024-01-16 08:40:00',
		0,
		203,
		2.00
	),
	(
		4,
		'2024-01-16 19:20:00',
		'2024-01-16 19:50:00',
		'Region D',
		8,
		'2024-01-16 19:30:00',
		104,
		1,
		0,
		60.00,
		'2024-01-16 19:15:00',
		0,
		204,
		4.00
	),
	(
		5,
		'2024-01-17 15:10:00',
		'2024-01-17 15:40:00',
		'Region E',
		12,
		'2024-01-17 15:20:00',
		105,
		1,
		0,
		70.00,
		'2024-01-17 15:05:00',
		0,
		205,
		6.00
	),
	(
		6,
		'2024-01-17 11:30:00',
		'2024-01-17 12:00:00',
		'Region F',
		3,
		'2024-01-17 11:40:00',
		106,
		0,
		1,
		45.00,
		'2024-01-17 11:25:00',
		5.00,
		206,
		2.00
	),
	(
		7,
		'2024-01-18 21:15:00',
		'2024-01-18 21:45:00',
		'Region G',
		6,
		'2024-01-18 21:20:00',
		107,
		1,
		0,
		55.00,
		'2024-01-18 21:10:00',
		0,
		207,
		3.50
	),
	(
		8,
		'2024-01-19 14:45:00',
		'2024-01-19 15:15:00',
		'Region H',
		0,
		'2024-01-19 14:50:00',
		108,
		1,
		1,
		35.00,
		'2024-01-19 14:40:00',
		0,
		208,
		2.50
	),
	(
		9,
		'2024-01-20 13:30:00',
		'2024-01-20 14:00:00',
		'Region I',
		7,
		'2024-01-20 13:40:00',
		109,
		1,
		0,
		65.00,
		'2024-01-20 13:25:00',
		0,
		209,
		4.00
	),
	(
		10,
		'2024-01-21 09:20:00',
		'2024-01-21 09:50:00',
		'Region J',
		15,
		'2024-01-21 09:30:00',
		110,
		0,
		0,
		80.00,
		'2024-01-21 09:15:00',
		0,
		210,
		10.00
	);

-- Query:
WITH
	EXTRACT_DATA AS (
		SELECT
			TO_CHAR(CUSTOMER_PLACED_ORDER_DATETIME, 'Day') AS WEEKDAY,
			EXTRACT(
				HOUR
				FROM
					CUSTOMER_PLACED_ORDER_DATETIME
			) AS HOUR,
			ORDER_TOTAL + TIP_AMOUNT - DISCOUNT_AMOUNT - REFUNDED_AMOUNT AS EARNING
		FROM
			DOORDASH_DELIVERY
	)
SELECT
	WEEKDAY,
	HOUR,
	AVG(EARNING) AS AVG_EARNINGS
FROM
	EXTRACT_DATA
GROUP BY
	WEEKDAY,
	HOUR
ORDER BY
	WEEKDAY,
	HOUR;

-- Reset Database:
DROP TABLE DOORDASH_DELIVERY;