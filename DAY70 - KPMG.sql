-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: KPMG (Medium Level) #SQL Interview Question — Solution
-- Identify the second-highest salary in each department.
-- Your output should include the department, the second highest salary, 
-- and the employee ID. Do not remove duplicate salaries when ordering salaries, 
-- and apply the rankings without a gap in the rank. For example, if multiple employees
-- share the same highest salary, the second-highest salary will be the next salary that
-- is lower than the highest salaries.

-- Database setup:
CREATE TABLE EMPLOYEE_DATA (
	DEPARTMENT VARCHAR(100),
	EMPLOYEE_ID BIGINT,
	HIRE_DATE DATE,
	RANK FLOAT,
	SALARY BIGINT
);

INSERT INTO
	EMPLOYEE_DATA (DEPARTMENT, EMPLOYEE_ID, HIRE_DATE, RANK, SALARY)
VALUES
	('HR', 101, '2022-01-15', 5.0, 60000),
	('HR', 102, '2021-03-10', 4.5, 75000),
	('HR', 103, '2020-05-20', 4.2, 75000),
	('HR', 104, '2023-06-01', 4.0, 50000),
	('Finance', 201, '2020-07-15', 3.8, 85000),
	('Finance', 202, '2021-09-25', 4.1, 95000),
	('Finance', 203, '2023-03-30', 4.3, 95000),
	('Finance', 204, '2022-11-12', 4.0, 70000),
	('IT', 301, '2021-12-11', 5.0, 120000),
	('IT', 302, '2023-01-15', 4.5, 110000),
	('IT', 303, '2020-08-19', 4.8, 105000),
	('IT', 304, '2021-06-30', 4.1, 100000),
	('Sales', 401, '2019-11-20', 4.7, 65000),
	('Sales', 402, '2022-02-10', 4.5, 55000),
	('Sales', 403, '2020-01-25', 4.3, 75000),
	('Sales', 404, '2023-07-18', 4.0, 72000);

-- Query:
WITH
	ALL_DEPTS_SALARY AS (
		SELECT
			DEPARTMENT,
			SALARY,
			EMPLOYEE_ID,
			DENSE_RANK() OVER (
				PARTITION BY
					DEPARTMENT
				ORDER BY
					SALARY DESC
			) AS RNK
		FROM
			EMPLOYEE_DATA
	)
SELECT
	DEPARTMENT,
	SALARY AS SECOND_HIGHEST_SALARY,
	EMPLOYEE_ID
FROM
	ALL_DEPTS_SALARY
WHERE
	RNK = 2;

-- Reset Database:
DROP TABLE EMPLOYEE_DATA;