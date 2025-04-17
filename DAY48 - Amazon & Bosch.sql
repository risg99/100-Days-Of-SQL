-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Amazon, Doordash, Bosch (Medium Level) #SQL Interview Question — Solution
-- Find all employees who have or had a job title that includes manager.
-- Output the first name along with the corresponding title.

-- Database setup:
CREATE TABLE WORKERS (
	DEPARTMENT VARCHAR(100),
	FIRST_NAME VARCHAR(50),
	JOINING_DATE DATE,
	LAST_NAME VARCHAR(50),
	SALARY BIGINT,
	WORKER_ID BIGINT PRIMARY KEY
);

INSERT INTO
	WORKERS (
		DEPARTMENT,
		FIRST_NAME,
		JOINING_DATE,
		LAST_NAME,
		SALARY,
		WORKER_ID
	)
VALUES
	('HR', 'Alice', '2020-01-15', 'Smith', 60000, 1),
	(
		'Engineering',
		'Bob',
		'2019-03-10',
		'Johnson',
		80000,
		2
	),
	(
		'Sales',
		'Charlie',
		'2021-07-01',
		'Brown',
		50000,
		3
	),
	(
		'Engineering',
		'David',
		'2018-12-20',
		'Wilson',
		90000,
		4
	),
	(
		'Marketing',
		'Emma',
		'2020-06-30',
		'Taylor',
		70000,
		5
	);

CREATE TABLE TITLES (
	AFFECTED_FROM DATE,
	WORKER_REF_ID BIGINT,
	WORKER_TITLE VARCHAR(100),
	FOREIGN KEY (WORKER_REF_ID) REFERENCES WORKERS (WORKER_ID)
);

INSERT INTO
	TITLES (AFFECTED_FROM, WORKER_REF_ID, WORKER_TITLE)
VALUES
	('2020-01-15', 1, 'HR Manager'),
	('2019-03-10', 2, 'Software Engineer'),
	('2021-07-01', 3, 'Sales Representative'),
	('2018-12-20', 4, 'Engineering Manager'),
	('2020-06-30', 5, 'Marketing Specialist'),
	('2022-01-01', 5, 'Marketing Manager');

-- Query:
SELECT
	W.FIRST_NAME,
	T.WORKER_TITLE
FROM
	WORKERS W
	JOIN TITLES T ON W.WORKER_ID = T.WORKER_REF_ID
WHERE
	UPPER(T.WORKER_TITLE) LIKE ('%MANAGER%');

-- Reset Database:
DROP TABLE TITLES;
DROP TABLE WORKERS;