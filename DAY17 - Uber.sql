-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Uber (Medium Level) #SQL Interview Question — Solution
-- You’re given a table of Uber rides that contains the mileage and the 
-- purpose for the business expense. You’re asked to find business purposes
-- that generate the most miles driven for passengers that use Uber for their
-- business transportation. Find the top 3 business purpose categories by total mileage.

-- Database setup:
CREATE TABLE MY_UBER_DRIVES (
	START_DATE TIMESTAMP,
	END_DATE TIMESTAMP,
	CATEGORY VARCHAR(50),
	START VARCHAR(50),
	STOP VARCHAR(50),
	MILES FLOAT,
	PURPOSE VARCHAR(50)
);

INSERT INTO
	MY_UBER_DRIVES (
		START_DATE,
		END_DATE,
		CATEGORY,
		START,
		STOP,
		MILES,
		PURPOSE
	)
VALUES
	(
		'2016-01-01 21:11',
		'2016-01-01 21:17',
		'Business',
		'Fort Pierce',
		'Fort Pierce',
		5.1,
		'Meal/Entertain'
	),
	(
		'2016-01-02 01:25',
		'2016-01-02 01:37',
		'Business',
		'Fort Pierce',
		'Fort Pierce',
		5,
		NULL
	),
	(
		'2016-01-02 20:25',
		'2016-01-02 20:38',
		'Business',
		'Fort Pierce',
		'Fort Pierce',
		4.8,
		'Errand/Supplies'
	),
	(
		'2016-01-05 17:31',
		'2016-01-05 17:45',
		'Business',
		'Fort Pierce',
		'Fort Pierce',
		4.7,
		'Meeting'
	),
	(
		'2016-01-06 14:42',
		'2016-01-06 15:49',
		'Business',
		'Fort Pierce',
		'West Palm Beach',
		63.7,
		'Customer Visit'
	),
	(
		'2016-01-06 17:15',
		'2016-01-06 17:19',
		'Business',
		'West Palm Beach',
		'West Palm Beach',
		4.3,
		'Meal/Entertain'
	),
	(
		'2016-01-06 17:30',
		'2016-01-06 17:35',
		'Business',
		'West Palm Beach',
		'Palm Beach',
		7.1,
		'Meeting'
	);

-- Query:
SELECT
	PURPOSE,
	SUM(MILES) AS TOTAL_MILES
FROM
	MY_UBER_DRIVES
WHERE
	CATEGORY = 'Business'
	AND PURPOSE IS NOT NULL
GROUP BY
	PURPOSE
ORDER BY
	2 DESC
LIMIT
	3;

-- Reset Database:
DROP TABLE MY_UBER_DRIVES;