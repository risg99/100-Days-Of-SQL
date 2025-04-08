-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Apple, Microsoft, Dell (Easy Level) #SQL Interview Question — Solution
-- Write a query that returns the number of unique users per client per month

-- Database setup:
CREATE TABLE FACT_EVENTS (
	ID INT PRIMARY KEY,
	TIME_ID TIMESTAMP,
	USER_ID VARCHAR(20),
	CUSTOMER_ID VARCHAR(50),
	CLIENT_ID VARCHAR(20),
	EVENT_TYPE VARCHAR(50),
	EVENT_ID INT
);

INSERT INTO
	FACT_EVENTS (
		ID,
		TIME_ID,
		USER_ID,
		CUSTOMER_ID,
		CLIENT_ID,
		EVENT_TYPE,
		EVENT_ID
	)
VALUES
	(
		1,
		'2020-02-28',
		'3668-QPYBK',
		'Sendit',
		'desktop',
		'message sent',
		3
	),
	(
		2,
		'2020-02-28',
		'7892-POOKP',
		'Connectix',
		'mobile',
		'file received',
		2
	),
	(
		3,
		'2020-04-03',
		'9763-GRSKD',
		'Zoomit',
		'desktop',
		'video call received',
		7
	),
	(
		4,
		'2020-04-02',
		'9763-GRSKD',
		'Connectix',
		'desktop',
		'video call received',
		7
	),
	(
		5,
		'2020-02-06',
		'9237-HQITU',
		'Sendit',
		'desktop',
		'video call received',
		7
	),
	(
		6,
		'2020-02-27',
		'8191-XWSZG',
		'Connectix',
		'desktop',
		'file received',
		2
	),
	(
		7,
		'2020-04-03',
		'9237-HQITU',
		'Connectix',
		'desktop',
		'video call received',
		7
	),
	(
		8,
		'2020-03-01',
		'9237-HQITU',
		'Connectix',
		'mobile',
		'message received',
		4
	),
	(
		9,
		'2020-04-02',
		'4190-MFLUW',
		'Connectix',
		'mobile',
		'video call received',
		7
	),
	(
		10,
		'2020-04-21',
		'9763-GRSKD',
		'Sendit',
		'desktop',
		'file received',
		2
	);

-- Query:
SELECT
	CLIENT_ID,
	TO_CHAR(TIME_ID, 'yyyy-mm') AS YEAR_MONTH,
	COUNT(DISTINCT USER_ID) AS UNIQUE_USERS
FROM
	FACT_EVENTS
GROUP BY
	CLIENT_ID,
	TO_CHAR(TIME_ID, 'yyyy-mm')
ORDER BY
	CLIENT_ID,
	TO_CHAR(TIME_ID, 'yyyy-mm');

-- Reset Database:
DROP TABLE FACT_EVENTS;