-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Amazon, Doordash(Medium Level) #SQL Interview Question — Solution
-- You have been asked to find the job titles of the highest-paid employees.
-- Your output should include the highest-paid title or multiple titles with the same salary.

-- Database setup:
CREATE TABLE WORKER (
	WORKER_ID INT PRIMARY KEY,
	FIRST_NAME VARCHAR(50),
	LAST_NAME VARCHAR(50),
	SALARY INT,
	JOINING_DATE TIMESTAMP,
	DEPARTMENT VARCHAR(50)
);

INSERT INTO
	WORKER (
		WORKER_ID,
		FIRST_NAME,
		LAST_NAME,
		SALARY,
		JOINING_DATE,
		DEPARTMENT
	)
VALUES
	(
		1,
		'John',
		'Doe',
		80000,
		'2020-01-15',
		'Engineering'
	),
	(
		2,
		'Jane',
		'Smith',
		120000,
		'2019-03-10',
		'Marketing'
	),
	(
		3,
		'Alice',
		'Brown',
		120000,
		'2021-06-21',
		'Sales'
	),
	(
		4,
		'Bob',
		'Davis',
		75000,
		'2018-04-30',
		'Engineering'
	),
	(
		5,
		'Charlie',
		'Miller',
		95000,
		'2021-01-15',
		'Sales'
	);

CREATE TABLE TITLE (
	WORKER_REF_ID INT,
	WORKER_TITLE VARCHAR(50),
	AFFECTED_FROM TIMESTAMP
);

INSERT INTO
	TITLE (WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM)
VALUES
	(1, 'Engineer', '2020-01-15'),
	(2, 'Marketing Manager', '2019-03-10'),
	(3, 'Sales Manager', '2021-06-21'),
	(4, 'Junior Engineer', '2018-04-30'),
	(5, 'Senior Salesperson', '2021-01-15');

-- Query:
SELECT
	T.WORKER_TITLE
FROM
	TITLE T
	JOIN WORKER W ON T.WORKER_REF_ID = W.WORKER_ID
WHERE
	W.SALARY = (
		SELECT
			MAX(SALARY)
		FROM
			WORKER
	);

-- Reset Database:
DROP TABLE WORKER;
DROP TABLE TITLE;