-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Google, Linkedln (Hard Level) #SQL Interview Question — Solution
-- Find the average absolute fare difference between a specific passenger and all 
-- passengers that belong to the same pclass, both are non-survivors and age difference
-- between two of them is 5 or less years. Do that for each passenger (that satisfy
-- above mentioned coniditions). Output the result along with the passenger name.

-- Database setup:
CREATE TABLE TITANIC (
	PASSENGERID BIGINT PRIMARY KEY,
	NAME VARCHAR(255),
	PCLASS BIGINT,
	SURVIVED BIGINT,
	AGE FLOAT,
	FARE FLOAT,
	CABIN VARCHAR(50),
	EMBARKED VARCHAR(1),
	PARCH BIGINT,
	SIBSP BIGINT,
	TICKET VARCHAR(50),
	SEX VARCHAR(10)
);

INSERT INTO
	TITANIC (
		PASSENGERID,
		NAME,
		PCLASS,
		SURVIVED,
		AGE,
		FARE,
		CABIN,
		EMBARKED,
		PARCH,
		SIBSP,
		TICKET,
		SEX
	)
VALUES
	(
		1,
		'John Smith',
		1,
		0,
		35,
		71.28,
		'C85',
		'C',
		0,
		1,
		'PC 17599',
		'male'
	),
	(
		2,
		'Mary Johnson',
		1,
		0,
		30,
		53.1,
		'C123',
		'C',
		0,
		0,
		'PC 17601',
		'female'
	),
	(
		3,
		'James Brown',
		1,
		1,
		40,
		50.0,
		NULL,
		'S',
		0,
		0,
		'113803',
		'male'
	),
	(
		4,
		'Anna Davis',
		2,
		0,
		28,
		13.5,
		NULL,
		'S',
		0,
		1,
		'250644',
		'female'
	),
	(
		5,
		'Robert Wilson',
		2,
		0,
		32,
		13.5,
		NULL,
		'S',
		0,
		1,
		'250655',
		'male'
	),
	(
		6,
		'Emma Moore',
		3,
		0,
		25,
		7.25,
		NULL,
		'S',
		0,
		0,
		'349909',
		'female'
	),
	(
		7,
		'William Taylor',
		3,
		0,
		27,
		7.75,
		NULL,
		'Q',
		0,
		0,
		'STON/O 2. 3101282',
		'male'
	),
	(
		8,
		'Sophia Anderson',
		3,
		1,
		22,
		8.05,
		NULL,
		'S',
		0,
		0,
		'347082',
		'female'
	),
	(
		9,
		'David Thomas',
		1,
		0,
		36,
		71.28,
		'C85',
		'C',
		0,
		1,
		'PC 17599',
		'male'
	),
	(
		10,
		'Alice Walker',
		1,
		0,
		33,
		53.1,
		'C123',
		'C',
		0,
		0,
		'PC 17601',
		'female'
	);

-- Query:
WITH
	ALL_PASSENGERS_DATA AS (
		SELECT
			T1.NAME,
			T1.PASSENGERID,
			ABS(T1.FARE - T2.FARE) AS DIFF
		FROM
			TITANIC T1
			JOIN TITANIC T2 ON T1.PCLASS = T2.PCLASS
			AND T1.SURVIVED = 0
			AND T2.SURVIVED = 0
			AND ABS(T1.AGE - T2.AGE) <= 5
			AND T1.PASSENGERID <> T2.PASSENGERID
	)
SELECT
	T.NAME,
	AVG(DIFF) AS AVG_ABS_FARE_DIFF
FROM
	TITANIC T
	LEFT JOIN ALL_PASSENGERS_DATA A ON T.PASSENGERID = A.PASSENGERID
WHERE
	T.SURVIVED = 0
GROUP BY
	T.NAME;

-- Reset Database:
DROP TABLE TITANIC;