-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: EY, Deloitte, TCS, (Medium Level) #SQL Interview Question — Solution
-- In a marathon, gun time is counted from the moment of the formal start of the race while
-- net time is counted from the moment a runner crosses a starting line. Both variables are in seconds.
-- You are asked to check if the interval between the two times is different for male and female runners. 
-- First, calculate the average absolute difference between the gun time and net time. Group the results
-- by available genders (male and female). Output the absolute difference between those two values.

-- Database setup:
CREATE TABLE MARATHON_MALE (
	AGE BIGINT,
	DIV_TOT TEXT,
	GUN_TIME BIGINT,
	HOMETOWN TEXT,
	NET_TIME BIGINT,
	NUM BIGINT,
	PACE BIGINT,
	PERSON_NAME TEXT,
	PLACE BIGINT
);

INSERT INTO
	MARATHON_MALE (
		AGE,
		DIV_TOT,
		GUN_TIME,
		HOMETOWN,
		NET_TIME,
		NUM,
		PACE,
		PERSON_NAME,
		PLACE
	)
VALUES
	(
		25,
		'1/100',
		3600,
		'New York',
		3400,
		101,
		500,
		'John Doe',
		1
	),
	(
		30,
		'2/100',
		4000,
		'Boston',
		3850,
		102,
		550,
		'Michael Smith',
		2
	),
	(
		22,
		'3/100',
		4200,
		'Chicago',
		4150,
		103,
		600,
		'David Johnson',
		3
	);

CREATE TABLE MARATHON_FEMALE (
	AGE BIGINT,
	DIV_TOT TEXT,
	GUN_TIME BIGINT,
	HOMETOWN TEXT,
	NET_TIME BIGINT,
	NUM BIGINT,
	PACE BIGINT,
	PERSON_NAME TEXT,
	PLACE BIGINT
);

INSERT INTO
	MARATHON_FEMALE (
		AGE,
		DIV_TOT,
		GUN_TIME,
		HOMETOWN,
		NET_TIME,
		NUM,
		PACE,
		PERSON_NAME,
		PLACE
	)
VALUES
	(
		28,
		'1/100',
		3650,
		'San Francisco',
		3600,
		201,
		510,
		'Jane Doe',
		1
	),
	(
		26,
		'2/100',
		3900,
		'Los Angeles',
		3850,
		202,
		530,
		'Emily Davis',
		2
	),
	(
		24,
		'3/100',
		4100,
		'Seattle',
		4050,
		203,
		590,
		'Anna Brown',
		3
	);

-- Query:
WITH
	AVERAGE_DIFF AS (
		SELECT
			AVG(ABS(GUN_TIME - NET_TIME)) AS AVG_TIME_DIFF,
			'Male' AS GENDER
		FROM
			MARATHON_MALE
		UNION ALL
		SELECT
			AVG(ABS(GUN_TIME - NET_TIME)) AS AVG_TIME_DIFF,
			'Female' AS GENDER
		FROM
			MARATHON_FEMALE
	)
SELECT
	ABS(
		MAX(
			CASE
				WHEN GENDER = 'Male' THEN AVG_TIME_DIFF
			END
		) - MAX(
			CASE
				WHEN GENDER = 'Female' THEN AVG_TIME_DIFF
			END
		)
	) AS ABSOLUTE_DIFF
FROM
	AVERAGE_DIFF;

-- Reset Database:
DROP TABLE MARATHON_MALE;
DROP TABLE MARATHON_FEMALE;