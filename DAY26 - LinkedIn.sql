-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Linkedln (Hard Level) #SQL Interview Question — Solution
-- Consider all LinkedIn users who, at some point, worked at Microsoft. For how many
-- of them was Google their next employer right after Microsoft (no employers in between)?

-- Database setup:
CREATE TABLE LINKEDIN_USERS (
	USER_ID INT,
	EMPLOYER VARCHAR(255),
	POSITION VARCHAR(255),
	START_DATE TIMESTAMP,
	END_DATE TIMESTAMP
);

INSERT INTO
	LINKEDIN_USERS (USER_ID, EMPLOYER, POSITION, START_DATE, END_DATE)
VALUES
	(
		1,
		'Microsoft',
		'developer',
		'2020-04-13',
		'2021-11-01'
	),
	(1, 'Google', 'developer', '2021-11-01', NULL),
	(
		2,
		'Google',
		'manager',
		'2021-01-01',
		'2021-01-11'
	),
	(2, 'Microsoft', 'manager', '2021-01-11', NULL),
	(
		3,
		'Microsoft',
		'analyst',
		'2019-03-15',
		'2020-07-24'
	),
	(
		3,
		'Amazon',
		'analyst',
		'2020-08-01',
		'2020-11-01'
	),
	(
		3,
		'Google',
		'senior analyst',
		'2020-11-01',
		'2021-03-04'
	),
	(
		4,
		'Google',
		'junior developer',
		'2018-06-01',
		'2021-11-01'
	),
	(
		4,
		'Google',
		'senior developer',
		'2021-11-01',
		NULL
	),
	(5, 'Microsoft', 'manager', '2017-09-26', NULL),
	(6, 'Google', 'CEO', '2015-10-02', NULL);

-- Query:
WITH
	ALL_EMPLOYERS_CTE AS (
		SELECT
			USER_ID,
			EMPLOYER AS FIRST_EMPLOYER,
			LEAD(EMPLOYER) OVER (
				PARTITION BY
					USER_ID
				ORDER BY
					START_DATE
			) AS SECOND_EMPLOYER
		FROM
			LINKEDIN_USERS
	)
SELECT
	USER_ID
FROM
	ALL_EMPLOYERS_CTE
WHERE
	FIRST_EMPLOYER = 'Microsoft'
	AND SECOND_EMPLOYER = 'Amazon';

-- Reset Database:
DROP TABLE LINKEDIN_USERS;