-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Amazon (Hard Level) #SQL Interview Question — Solution
-- You have been asked to find the fifth highest salary without using TOP or LIMIT. 
-- Note: Duplicate salaries should not be removed.

-- Database setup:
CREATE TABLE WORKERS (
	WORKER_ID BIGINT PRIMARY KEY,
	DEPARTMENT VARCHAR(25),
	FIRST_NAME VARCHAR(25),
	LAST_NAME VARCHAR(25),
	JOINING_DATE DATE,
	SALARY BIGINT
);

INSERT INTO
	WORKERS (
		WORKER_ID,
		DEPARTMENT,
		FIRST_NAME,
		LAST_NAME,
		JOINING_DATE,
		SALARY
	)
VALUES
	(1, 'HR', 'John', 'Doe', '2020-01-15', 50000),
	(2, 'IT', 'Jane', 'Smith', '2019-03-10', 60000),
	(
		3,
		'Finance',
		'Emily',
		'Jones',
		'2021-06-20',
		75000
	),
	(
		4,
		'Sales',
		'Michael',
		'Brown',
		'2018-09-05',
		60000
	),
	(
		5,
		'Marketing',
		'Chris',
		'Johnson',
		'2022-04-12',
		70000
	),
	(6, 'IT', 'David', 'Wilson', '2020-11-01', 80000),
	(
		7,
		'Finance',
		'Sarah',
		'Taylor',
		'2017-05-25',
		45000
	),
	(8, 'HR', 'James', 'Anderson', '2023-01-09', 65000),
	(9, 'Sales', 'Anna', 'Thomas', '2020-02-18', 55000),
	(
		10,
		'Marketing',
		'Robert',
		'Jackson',
		'2021-07-14',
		60000
	);

-- Query:
WITH
	SALARY_RANKS AS (
		SELECT
			SALARY,
			DENSE_RANK() OVER (
				ORDER BY
					SALARY DESC
			) AS RANK
		FROM
			WORKERS
	)
SELECT DISTINCT
	SALARY
FROM
	SALARY_RANKS
WHERE
	RANK = 5;

-- Reset Database:
DROP TABLE WORKERS;