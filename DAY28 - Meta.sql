-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Meta, Salesforce (Hard Level) #SQL Interview Question — Solution
-- Find the highest salary among salaries that appears only once.

-- Database setup:
CREATE TABLE EMPLOYEE (
	ID INT,
	FIRST_NAME VARCHAR(50),
	LAST_NAME VARCHAR(50),
	AGE INT,
	SEX VARCHAR(1),
	EMPLOYEE_TITLE VARCHAR(50),
	DEPARTMENT VARCHAR(50),
	SALARY INT,
	TARGET INT,
	BONUS INT,
	EMAIL VARCHAR(100),
	CITY VARCHAR(50),
	ADDRESS VARCHAR(100),
	MANAGER_ID INT
);

INSERT INTO
	EMPLOYEE (
		ID,
		FIRST_NAME,
		LAST_NAME,
		AGE,
		SEX,
		EMPLOYEE_TITLE,
		DEPARTMENT,
		SALARY,
		TARGET,
		BONUS,
		EMAIL,
		CITY,
		ADDRESS,
		MANAGER_ID
	)
VALUES
	(
		5,
		'Max',
		'George',
		26,
		'M',
		'Sales',
		'Sales',
		1300,
		200,
		150,
		'Max@company.com',
		'California',
		'2638 Richards Avenue',
		1
	),
	(
		13,
		'Katty',
		'Bond',
		56,
		'F',
		'Manager',
		'Management',
		150000,
		0,
		300,
		'Katty@company.com',
		'Arizona',
		NULL,
		1
	),
	(
		11,
		'Richerd',
		'Gear',
		57,
		'M',
		'Manager',
		'Management',
		250000,
		0,
		300,
		'Richerd@company.com',
		'Alabama',
		NULL,
		1
	),
	(
		10,
		'Jennifer',
		'Dion',
		34,
		'F',
		'Sales',
		'Sales',
		1000,
		200,
		150,
		'Jennifer@company.com',
		'Alabama',
		NULL,
		13
	),
	(
		19,
		'George',
		'Joe',
		50,
		'M',
		'Manager',
		'Management',
		250000,
		0,
		300,
		'George@company.com',
		'Florida',
		'1003 Wyatt Street',
		1
	),
	(
		18,
		'Laila',
		'Mark',
		26,
		'F',
		'Sales',
		'Sales',
		1000,
		200,
		150,
		'Laila@company.com',
		'Florida',
		'3655 Spirit Drive',
		11
	),
	(
		20,
		'Sarrah',
		'Bicky',
		31,
		'F',
		'Senior Sales',
		'Sales',
		2000,
		200,
		150,
		'Sarrah@company.com',
		'Florida',
		'1176 Tyler Avenue',
		19
	);

-- Query:
WITH
	SALARY_COUNTS AS (
		SELECT
			SALARY,
			COUNT(*) AS COUNT_SALARY
		FROM
			EMPLOYEE
		GROUP BY
			SALARY
	)
SELECT
	MAX(SALARY) AS HIGHEST_UNIQUE_SALARY
FROM
	SALARY_COUNTS
WHERE
	COUNT_SALARY = 1;

-- Reset Database:
DROP TABLE EMPLOYEE;